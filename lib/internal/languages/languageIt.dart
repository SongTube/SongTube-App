import 'package:songtube/internal/languages.dart';

class LanguageIt extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Benvenuto a";
  @override
  String get labelStart => "Start";
  @override
  String get labelSkip => "Salta";
  @override
  String get labelNext => "Prossimo";
  @override
  String get labelExternalAccessJustification =>
    "Necessita l'accesso allo Spazio Esterno pee salvare tutti i " +
    "tuoi Video e la tua Musica";
  @override
  String get labelAppCustomization => "Personalizzazione";
  @override
  String get labelSelectPreferred => "Seleziona il tuo Preferito";
  @override
  String get labelConfigReady => "Configurazione Pronta";
  @override
  String get labelIntroductionIsOver => "L'introduzione è finita";
  @override
  String get labelEnjoy => "Enjoy";
  @override 
  String get labelGoHome => "Vai alla Home";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Home";
  @override
  String get labelDownloads => "Download";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Altro";

  // Home Screen
  @override
  String get labelQuickSearch => "Ricerca Rapida...";
  @override
  String get labelTagsEditor => "Tags\nEditor";
  @override
  String get labelEditArtwork => "Modifica\nArtwork";
  @override
  String get labelDownloadAll => "Scarica Tutto";
  @override 
  String get labelLoadingVideos => "Caricamento Video...";
  @override
  String get labelHomePage => "Pagina Home";
  @override
  String get labelTrending => "Di tendenza";
  @override
  String get labelFavorites => "Preferiti";
  @override
  String get labelWatchLater => "Guarda più Tardi";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copia Link";
  @override
  String get labelAddToFavorites => "Aggiungi ai preferiti";
  @override
  String get labelAddToWatchLater => "Aggiungi a Guarda più Tardi";
  @override
  String get labelAddToPlaylist => "Aggiungi alla Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "In coda";
  @override
  String get labelDownloading => "Scaricando";
  @override
  String get labelConverting => "Convertendo";
  @override
  String get labelCancelled => "Annullato";
  @override
  String get labelCompleted => "Completato";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download in coda";
  @override
  String get labelDownloadAcesssDenied => "Accesso Negato";
  @override
  String get labelClearingExistingMetadata => "Cancellazione dei Metadati esistenti...";
  @override
  String get labelWrittingTagsAndArtwork => "Scrivendo Tag & Artwork...";
  @override
  String get labelSavingFile => "Salvando File...";
  @override
  String get labelAndroid11FixNeeded => "Errore, Fix Android 11 necessario, controlla le Impostazioni";
  @override
  String get labelErrorSavingDownload => "Impossible salvare il tuo Download, controlla i Permessi";
  @override
  String get labelDownloadingVideo => "Scaricando Video...";
  @override
  String get labelDownloadingAudio => "Scaricando Audio...";
  @override
  String get labelGettingAudioStream => "Ottenendo Stream Audio...";
  @override
  String get labelAudioNoDataRecieved => "Impossibile ottenere Stream Audio";
  @override
  String get labelDownloadStarting => "Avviando Download...";
  @override
  String get labelDownloadCancelled => "Download Annullato";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Conversione Fallita";
  @override
  String get labelPatchingAudio => "Patching Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Abilita Conversione Audio";
  @override
  String get labelGainControls => "Controlli di Guadagno";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Guadagno Bassi";
  @override
  String get labelTrebleGain => "Guadagno Alti";
  @override
  String get labelSelectVideo => "Seleziona Video";
  @override
  String get labelSelectAudio => "Seleziona Audio";
  @override
  String get labelGlobalParameters => "Parametri globali";

  // Media Screen
  @override
  String get labelMusic => "Musica";
  @override
  String get labelVideos => "Video";
  @override
  String get labelNoMediaYet => "Ancora Nessun Media";
  @override
  String get labelNoMediaYetJustification => "Tutti i tuoi Media " +
    "verranno mostrati qui";
  @override
  String get labelSearchMedia => "Cerca Media...";
  @override
  String get labelDeleteSong => "Cancella Canzone";
  @override
  String get labelNoPermissionJustification => "Vedi i tuoi media Media" + "\n" +
    "Concedendo il permesso allo Spazio";
  @override
  String get labelGettingYourMedia => "Ottenendo i tuoi Media...";
  @override
  String get labelEditTags => "Modifica Tag";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Cerca YouTube...";

  // More Screen
  @override
  String get labelSettings => "Impostazioni";
  @override
  String get labelDonate => "Donazione";
  @override
  String get labelLicenses => "Licenze";
  @override
  String get labelChooseColor => "Scegli Colore";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Usa il Tema di Sistema";
  @override
  String get labelUseSystemThemeJustification =>
    "Abilita/Disabilita Tema automatico";
  @override
  String get labelEnableDarkTheme => "Abilita Tema Scuro";
  @override
  String get labelEnableDarkThemeJustification =>
    "Usa Tema Scuro di default";
  @override
  String get labelEnableBlackTheme => "Abilita Tema Nero";
  @override
  String get labelEnableBlackThemeJustification =>
    "Abilita Tema Nero Puro";
  @override
  String get labelAccentColor => "Colore accento";
  @override
  String get labelAccentColorJustification => "Personalizza colore accento";
  @override
  String get labelAudioFolder => "Cartella audio";
  @override
  String get labelAudioFolderJustification => "Scegli una cartella per " +
    "Download audio";
  @override
  String get labelVideoFolder => "Cartella video";
  @override
  String get labelVideoFolderJustification => "Scegli una cartella per " +
    "Download video";
  @override
  String get labelAlbumFolder => "Cartella Album";
  @override
  String get labelAlbumFolderJustification => "Crea una cartella per ogni Album delle canzoni";
  @override
  String get labelDeleteCache => "Elimina Cache";
  @override
  String get labelDeleteCacheJustification => "Pulisci Cache SongTube";
  @override
  String get labelAndroid11Fix => "Fix Android 11";
  @override
  String get labelAndroid11FixJustification => "Aggiusta i problemi dei Download in " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Effetua un Backup della tua libreria media";
  @override
  String get labelRestore => "Ripristina";
  @override
  String get labelRestoreJustification => "Ripristina la tua libreria audio da un backup";
  @override
  String get labelBackupLibraryEmpty => "La tua Libreria è vuota";
  @override
  String get labelBackupCompleted => "Backup Completato";
  @override
  String get labelRestoreNotFound => "Ripristino non trovato";
  @override
  String get labelRestoreCompleted => "Ripristino Completato";
  @override
  String get labelCacheIsEmpty => "La Cache è Vuota";
  @override
  String get labelYouAreAboutToClear => "Stai per cancellare";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titolo";
  @override
  String get labelEditorArtist => "Artista";
  @override
  String get labelEditorGenre => "Genere";
  @override
  String get labelEditorDisc => "Disco";
  @override
  String get labelEditorTrack => "Traccia";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 or 11 Rilevato";
  @override
  String get labelAndroid11DetectedJustification => "Per assicurare il corretto " +
    "funzionamento dei download di quest'app, su Android 10 e 11, il permesso " +
    "Accesso a Tutti i File potrebbe essere necessario. Questo è temporaneo e non richiesto " +
    "negli aggiornamenti futuri. Puoi anche applicare questo fix nelle impostazioni.";

  // Music Player
  @override
  String get labelPlayerSettings => "Impostazioni Player";
  @override
  String get labelExpandArtwork => "Espandi Artwork";
  @override
  String get labelArtworkRoundedCorners => "Angoli arrotondati dell'Artwork";
  @override
  String get labelPlayingFrom => "Riproducendo Da";
  @override
  String get labelBlurBackground => "Sfoca Sfondo";

  // Video Page
  @override
  String get labelTags => "Tag";
  @override
  String get labelRelated => "Correlati";
  @override
  String get labelAutoPlay => "AutoPlay";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formato audio non compatibile";
  @override
  String get labelNotSpecified => "Non specificato";
  @override
  String get labelPerformAutomaticTagging => 
    "Effettua Tagging Automatico";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Seleziona tag da MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Seleziona Artwork dal dispositivo";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Unisciti al canale Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Ti piace SongTube? Per favore entra nel Canale Telegram! Troverai " +
    "Aggiornamenti, Informazioni, Sviluppo, Link del Gruppo e altri link ai Social." +
    "\n\n" +
    "Nel caso abbia un problema o un bel suggerimento nella tua mente, " +
    "per favore entra nel gruppo dal canale e scrivilo! Ma tieni in mente " +
    "che puoi solo scrivere in inglese, grazie!";
  @override
  String get labelRemindLater => "Ricorda più Tardi";

  // Common Words (One word labels)
  @override
  String get labelExit => "Esco";
  @override
  String get labelSystem => "Sistema";
  @override
  String get labelChannel => "Canale";
  @override
  String get labelShare => "Condividi";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Download";
  @override
  String get labelBest => "Migliore";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Versione";
  @override
  String get labelLanguage => "Lingua";
  @override
  String get labelGrant => "Concedi";
  @override
  String get labelAllow => "Consenti";
  @override
  String get labelAccess => "Accesso";
  @override
  String get labelEmpty => "Vuoto";
  @override
  String get labelCalculating => "Calcolando";
  @override
  String get labelCleaning => "Pulendo";
  @override
  String get labelCancel => "Annulla";
  @override
  String get labelGeneral => "Generale";
  @override
  String get labelRemove => "Rimuovi";
  @override
  String get labelJoin => "Unisciti";
  @override
  String get labelNo => "No";
  @override
  String get labelLibrary => "Libreria";
  @override
  String get labelCreate => "Crea";
  @override
  String get labelPlaylists => "Playlist";
  @override
  String get labelQuality => "Qualità";
  @override
  String get labelSubscribe => "Iscriviti";
}