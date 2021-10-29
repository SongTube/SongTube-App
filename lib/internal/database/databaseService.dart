// Dart
import 'dart:io';

// Internal
import 'package:audio_tagger/audio_tagger.dart';
import 'package:songtube/internal/ffmpeg/extractor.dart';
import 'package:songtube/internal/models/songFile.dart';

// Packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:string_validator/string_validator.dart';

const String table = "itemsTable";

class DatabaseService {

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MediaItems.db');
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title STRING,
        album STRING,
        author STRING,
        duration STRING,
        downloadType STRING,
        path STRING,
        fileSize STRING,
        coverUrl STRING)
      ''',
    );
  }

  Future<void> insertDownload(SongFile download) async {
    Database db = await database;
    await db.insert(table, download.toMap());
  }

  Future<SongFile> getDownload(String id) async {
    Database db = await database;
    List<Map> data = await db.query(table,
      where: 'id = ?',
      whereArgs: [id]
    );
    if (data.length > 0) {
      return SongFile.fromMap(data.first);
    }
    return null;
  }

  Future<List<SongFile>> getDownloadList() async {
    List<SongFile> list = [];
    Database db = await database;
    var result = await db.query(table, columns: [
      "id",
      "title",
      "album",
      "author",
      "duration",
      "downloadType",
      "path",
      "fileSize",
      "coverUrl"
    ]);
    await Future.forEach(result, (element) async {
      SongFile songFile = SongFile.fromMap(element);
      if (await File(songFile.path).exists()) {
        File coverImage = await FFmpegExtractor.getAudioArtwork(
          audioFile: songFile.path,
          extractionMethod: ArtworkExtractMethod.Automatic,
          forceExtraction: true
        );
        if (!await coverImage.exists()) {
          if (isURL(songFile.coverUrl)) {
            coverImage = await AudioTagger.generateCover(songFile.coverUrl);
          } else {
            coverImage = File(songFile.coverUrl);
          }
        }
        songFile.coverPath = coverImage.path;
        list.add(songFile);
      }
    });
    return list;
  }

  Future<int> deleteDownload(int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

}