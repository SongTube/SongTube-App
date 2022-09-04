import 'package:songtube/internal/languages.dart';

class LanguageJa extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "ようこそ";
  @override
  String get labelStart => "始める";
  @override
  String get labelSkip => "スキップ";
  @override
  String get labelNext => "次へ";
  @override
  String get labelExternalAccessJustification =>"動画と音楽を保存するために" +
    "は外部ストレージにアクセスする必要があります";
  @override
  String get labelAppCustomization => "カスタマイズ";
  @override
  String get labelSelectPreferred => "選択してください";
  @override
  String get labelConfigReady => "設定が完了しました";
  @override
  String get labelIntroductionIsOver => "説明は以上です";
  @override
  String get labelEnjoy => "楽しもう";
  @override 
  String get labelGoHome => "ホームへ";

  // Bottom Navigation Bar
  @override
  String get labelHome => "ホーム";
  @override
  String get labelDownloads => "ダウンロード";
  @override
  String get labelMedia => "メディア";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "もっと";

  // Home Screen
  @override
  String get labelQuickSearch => "検索...";
  @override
  String get labelTagsEditor => "タグを\n編集";
  @override
  String get labelEditArtwork => "アートワークを\n編集";
  @override
  String get labelDownloadAll => "すべてダウンロード";
  @override 
  String get labelLoadingVideos => "動画を読み込み中...";
  @override
  String get labelHomePage => "ホームページ";
  @override
  String get labelTrending => "トレンド";
  @override
  String get labelFavorites => "お気に入り";
  @override
  String get labelWatchLater => "後で見る";

  // Video Options Menu
  @override
  String get labelCopyLink => "リンクをコピー";
  @override
  String get labelAddToFavorites => "お気に入りに追加";
  @override
  String get labelAddToWatchLater => "後で見るに追加";
  @override
  String get labelAddToPlaylist => "プレイリストに追加";

  // Downloads Screen
  @override
  String get labelQueued => "追加済み";
  @override
  String get labelDownloading => "ダウンロード中";
  @override
  String get labelConverting => "変換中";
  @override
  String get labelCancelled => "中止済み";
  @override
  String get labelCompleted => "完了済み";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "開始を待っています";
  @override
  String get labelDownloadAcesssDenied => "アクセスが拒否されました";
  @override
  String get labelClearingExistingMetadata => "メタデータを整理しています...";
  @override
  String get labelWrittingTagsAndArtwork => "タグとアートワークを書き込んでいます...";
  @override
  String get labelSavingFile => "保存しています...";
  @override
  String get labelAndroid11FixNeeded => "エラー, Android 11 では設定の変更が必要です";
  @override
  String get labelErrorSavingDownload => "保存できませんでした, アクセス権限を確認してください";
  @override
  String get labelDownloadingVideo => "動画をダウンロード中...";
  @override
  String get labelDownloadingAudio => "音声をダウンロード中...";
  @override
  String get labelGettingAudioStream => "音声ストリームを取得中...";
  @override
  String get labelAudioNoDataRecieved => "音声ストリームを取得できませんでした";
  @override
  String get labelDownloadStarting => "ダウンロードを開始中...";
  @override
  String get labelDownloadCancelled => "ダウンロードがキャンセルされました";
  @override
  String get labelAnIssueOcurredConvertingAudio => "変換に失敗しました";
  @override
  String get labelPatchingAudio => "音声にパッチを適用しています...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "音声を変換";
  @override
  String get labelGainControls => "ゲイン調整";
  @override
  String get labelVolume => "音量";
  @override
  String get labelBassGain => "低音ゲイン";
  @override
  String get labelTrebleGain => "高音ゲイン";
  @override
  String get labelSelectVideo => "動画を選択";
  @override
  String get labelSelectAudio => "音声を選択";
  @override
  String get labelGlobalParameters => "グローバル変数";

  // Media Screen
  @override
  String get labelMusic => "音楽";
  @override
  String get labelVideos => "動画";
  @override
  String get labelNoMediaYet => "メディアがありません";
  @override
  String get labelNoMediaYetJustification => "メディアが" +
    "ここに表示されます";
  @override
  String get labelSearchMedia => "メディアを検索...";
  @override
  String get labelDeleteSong => "曲を削除";
  @override
  String get labelNoPermissionJustification => "外部ストレージへのアクセスを" + "\n" +
    "許可してメディアを表示";
  @override
  String get labelGettingYourMedia => "メディアを取得中...";
  @override
  String get labelEditTags => "タグを編集";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "YouTubeで検索...";

  // More Screen
  @override
  String get labelSettings => "設定";
  @override
  String get labelDonate => "寄付";
  @override
  String get labelLicenses => "ライセンス";
  @override
  String get labelChooseColor => "色を選択";
  @override
  String get labelTheme => "テーマ";
  @override
  String get labelUseSystemTheme => "システムのテーマを使用";
  @override
  String get labelUseSystemThemeJustification =>
    "テーマの自動選択を有効化/無効化";
  @override
  String get labelEnableDarkTheme => "ダークテーマを有効化";
  @override
  String get labelEnableDarkThemeJustification =>
    "デフォルトでダークテーマを使用";
  @override
  String get labelEnableBlackTheme => "ブラックテーマを有効化";
  @override
  String get labelEnableBlackThemeJustification =>
    "ピュアブラックテーマを有効化";
  @override
  String get labelAccentColor => "アクセントカラー";
  @override
  String get labelAccentColorJustification => "アクセントカラーをカスタマイズ";
  @override
  String get labelAudioFolder => "音声フォルダ";
  @override
  String get labelAudioFolderJustification => "音声のダウンロードに使用する" +
    "フォルダを選択";
  @override
  String get labelVideoFolder => "動画フォルダ";
  @override
  String get labelVideoFolderJustification => "動画のダウンロードに使用する" +
    "フォルダを選択";
  @override
  String get labelAlbumFolder => "アルバムフォルダ";
  @override
  String get labelAlbumFolderJustification => "アルバムごとにフォルダを作成する";
  @override
  String get labelDeleteCache => "キャッシュを消去";
  @override
  String get labelDeleteCacheJustification => "SongTubeのキャッシュを消去";
  @override
  String get labelAndroid11Fix => "Android 11 向けの修正";
  @override
  String get labelAndroid11FixJustification => "Android 10 と 11 で発生するダウンロードの問題を" +
    "修正します";
  @override
  String get labelBackup => "バックアップ";
  @override
  String get labelBackupJustification => "メディアライブラリーを閲覧";
  @override
  String get labelRestore => "リストア";
  @override
  String get labelRestoreJustification => "メディアライブラリーをリストア";
  @override
  String get labelBackupLibraryEmpty => "ライブラリーが空です";
  @override
  String get labelBackupCompleted => "バックアップ完了";
  @override
  String get labelRestoreNotFound => "リストアが見つかりませんでした";
  @override
  String get labelRestoreCompleted => "リストア完了";
  @override
  String get labelCacheIsEmpty => "キャッシュが空です";
  @override
  String get labelYouAreAboutToClear => "あなたがクリアしようとしているのは";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "タイトル";
  @override
  String get labelEditorArtist => "アーティスト";
  @override
  String get labelEditorGenre => "ジャンル";
  @override
  String get labelEditorDisc => "ディスク";
  @override
  String get labelEditorTrack => "トラック";
  @override
  String get labelEditorDate => "日付";
  @override
  String get labelEditorAlbum => "アルバム";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 または 11 を検出しました";
  @override
  String get labelAndroid11DetectedJustification => "Android 10 および 11 でこのアプリのダウンロードを" +
    "正しく機能させるためには, すべてのファイルへのアクセス許可が必要になる場合があります。" +
    "これは一時的なもので、今後のアップデートでは必要ありません。" +
    "この修正は設定でも適用できます。";

  // Music Player
  @override
  String get labelPlayerSettings => "プレイヤー設定";
  @override
  String get labelExpandArtwork => "アートワークを拡大表示";
  @override
  String get labelArtworkRoundedCorners => "アートワークの角の半径";
  @override
  String get labelPlayingFrom => "再生中のアルバム";
  @override
  String get labelBlurBackground => "背景をぼかす";

  // Video Page
  @override
  String get labelTags => "タグ";
  @override
  String get labelRelated => "関連";
  @override
  String get labelAutoPlay => "自動再生";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "音声のフォーマットが完了していません";
  @override
  String get labelNotSpecified => "未選択";
  @override
  String get labelPerformAutomaticTagging => 
    "自動でタグ付けする";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "MusicBrainzからタグを選択";
  @override
  String get labelSelectArtworkFromDevice =>
    "デバイスからタグを選択";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Telegramチャンネルに参加する";
  @override
  String get labelJoinTelegramJustification =>
    "SongTubeが気に入ったら, Telegram Channelにご参加ください。このチャンネルでは " +
    "アップデート, 情報, 開発, グループリンク, その他のソーシャルリンクを見ることができます。" +
    "\n\n" +
    "アプリに問題が発生した場合や提案がある場合は, " +
    "チャンネルからグループに参加して書き込んでください。" +
    "グループでは英語を使用してください。ありがとうございます！";
  @override
  String get labelRemindLater => "後で通知";

  // Common Words (One word labels)
  @override
  String get labelExit => "終了";
  @override
  String get labelSystem => "システム";
  @override
  String get labelChannel => "チャンネル";
  @override
  String get labelShare => "共有";
  @override
  String get labelAudio => "音声";
  @override
  String get labelVideo => "動画";
  @override
  String get labelDownload => "ダウンロード";
  @override
  String get labelBest => "ベスト";
  @override
  String get labelPlaylist => "プレイリスト";
  @override
  String get labelVersion => "バージョン";
  @override
  String get labelLanguage => "言語";
  @override
  String get labelGrant => "許諾";
  @override
  String get labelAllow => "許可";
  @override
  String get labelAccess => "アクセス";
  @override
  String get labelEmpty => "空";
  @override
  String get labelCalculating => "計算中";
  @override
  String get labelCleaning => "整理中";
  @override
  String get labelCancel => "キャンセル";
  @override
  String get labelGeneral => "全般";
  @override
  String get labelRemove => "削除";
  @override
  String get labelJoin => "参加";
  @override
  String get labelNo => "いいえ";
  @override
  String get labelLibrary => "ライブラリー";
  @override
  String get labelCreate => "作成";
  @override
  String get labelPlaylists => "プレイリスト";
  @override
  String get labelQuality => "画質";
  @override
  String get labelSubscribe => "登録";
}