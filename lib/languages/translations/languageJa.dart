import 'package:songtube/languages/languages.dart';

class LanguageJa extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "ようこそ";
  @override
  String get labelStart => "はじめる";
  @override
  String get labelSkip => "スキップ";
  @override
  String get labelNext => "次へ";
  @override
  String get labelExternalAccessJustification =>"動画と音楽を保存するには" +
    "外部の保存領域が必要です";
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
  String get labelQuickSearch => "かんたん検索...";
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
  String get labelTrending => "急上昇";
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
  String get labelPlaylists => "再生リスト";
  @override
  String get labelQuality => "画質";
  @override
  String get labelSubscribe => "登録";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'お気に入りの動画なし';
  @override
  String get labelNoFavoriteVideosDescription => '動画を検索してお気に入りに保存するとここに表示されます';
  @override
  String get labelNoSubscriptions => '登録チャンネルなし';
  @override
  String get labelNoSubscriptionsDescription => '上部のボタンを押すとおすすめのチャンネルを表示します！';
  @override
  String get labelNoPlaylists => '再生リストなし';
  @override
  String get labelNoPlaylistsDescription => '動画や再生リストを検索して保存するとここに表示されます';
  @override
  String get labelSearch => '検索';
  @override
  String get labelSubscriptions => 'チャンネル購読';
  @override
  String get labelNoDownloadsCanceled => 'キャンセルしたダウンロードなし';
  @override
  String get labelNoDownloadsCanceledDescription => 'いいことです！でもキャンセルしたりダウンロードに失敗すればここに表示されます';
  @override
  String get labelNoDownloadsYet => 'まだダウンロードなし';
  @override
  String get labelNoDownloadsYetDescription => 'ホームから何かを検索しダウンロードするか or wait for the queue!';
  @override
  String get labelYourQueueIsEmpty => 'キューに登録なし';
  @override
  String get labelYourQueueIsEmptyDescription => 'ホームから何かを検索しダウンロードしましょう！';
  @override
  String get labelQueue => 'キュー';
  @override
  String get labelSearchDownloads => 'ダウンロードを検索';
  @override
  String get labelWatchHistory => '再生履歴';
  @override
  String get labelWatchHistoryDescription => '見た動画です';
  @override
  String get labelBackupAndRestore => 'バックアップ & 復元';
  @override
  String get labelBackupAndRestoreDescription => '端末内データのすべてを保存または復元';
  @override
  String get labelSongtubeLink => 'SongTube リンク';
  @override
  String get labelSongtubeLinkDescription => 'SongTube ブラウザ拡張機能がこの端末を検出できるようにします。長押しで詳細';
  @override
  String get labelSupportDevelopment => '開発支援';
  @override
  String get labelSocialLinks => 'ソーシャルリンク';
  @override
  String get labelSeeMore => 'もっと見る';
  @override
  String get labelMostPlayed => '再生回数が多い';
  @override
  String get labelNoPlaylistsYet => 'まだ再生リストなし';
  @override
  String get labelNoPlaylistsYetDescription => '履歴、曲、アルバム、アーティストから再生リストを作成できます';
  @override
  String get labelNoSearchResults => '検索結果はありませんでした';
  @override
  String get labelSongResults => '曲';
  @override
  String get labelAlbumResults => 'アルバム';
  @override
  String get labelArtistResults => 'アーティスト';
  @override
  String get labelSearchAnything => 'Search anything';
  @override
  String get labelRecents => 'Recents';
  @override
  String get labelFetchingSongs => '曲を取得';
  @override
  String get labelPleaseWaitAMoment => '少しお待ちください';
  @override
  String get labelWeAreDone => 'We are done';
  @override
  String get labelEnjoyTheApp => 'Enjoy the\nApp';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube is back with a cleaner look and set of features, have fun with your music!';
  @override
  String get labelLetsGo => 'Let\'s go';
  @override
  String get labelPleaseWait => 'お待ちください';
  @override
  String get labelPoweredBy => 'Powered by';
  @override
  String get labelGetStarted => 'Get Started';
  @override
  String get labelAllowUsToHave => 'Allow us to have';
  @override
  String get labelStorageRead => 'Storage\nRead';
  @override
  String get labelStorageReadDescription => 'This will scan your music, extract high quality artworks and allow you to personalize your music';
  @override
  String get labelContinue => '続行';
  @override
  String get labelAllowStorageRead => 'Allow Storage Read';
  @override
  String get labelSelectYourPreferred => 'Select your preferred';
  @override
  String get labelLight => 'ライト';
  @override
  String get labelDark => 'ダーク';
  @override
  String get labelSimultaneousDownloads => 'Simultaneous Downloads';
  @override
  String get labelSimultaneousDownloadsDescription => 'Define how many downloads can happen at the same time';
  @override
  String get labelItems => 'Items';
  @override
  String get labelInstantDownloadFormat => 'すぐダウンロード';
  @override
  String get labelInstantDownloadFormatDescription => 'すぐダウンロード用の音声形式を変更';
  @override
  String get labelCurrent => 'Current';
  @override
  String get labelPauseWatchHistory => '再生履歴を停止';
  @override
  String get labelPauseWatchHistoryDescription => '停止中は動画は再生履歴にの一覧に保存されません';
  @override
  String get labelLockNavigationBar => 'ナビバーを固定';
  @override
  String get labelLockNavigationBarDescription => 'Locks the navigation bar from hiding and showing automatically on scroll';
  @override
  String get labelPictureInPicture => 'ピクチャーインピクチャー';
  @override
  String get labelPictureInPictureDescription => '動画視聴中にホームボタンを押すと自動的にPiPモードにします';
  @override
  String get labelBackgroundPlaybackAlpha => 'バックグラウンド再生 (アルファ)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'バックグラウンド再生を切り替え。プラグインの制限により、バックグラウンド再生するのは現在の動画のみです';
  @override
  String get labelBlurBackgroundDescription => 'アートワークの背景にぼかしを追加';
  @override
  String get labelBlurIntensity => 'ぼかしの強さ';
  @override
  String get labelBlurIntensityDescription => 'アートワークの背景のぼかしの強さを変更;
  @override
  String get labelBackdropOpacity => '背景の不透明度';
  @override
  String get labelBackdropOpacityDescription => '背景の不透明度';
  @override
  String get labelArtworkShadowOpacity => 'アートワークの影の不透明度';
  @override
  String get labelArtworkShadowOpacityDescription => '音楽プレイヤーのアートワークの影の強さを変更';
  @override
  String get labelArtworkShadowRadius => 'アートワークの影の丸み';
  @override
  String get labelArtworkShadowRadiusDescription => '音楽プレイヤーのアートワークの影の丸みを変更r';
  @override
  String get labelArtworkScaling => 'アートワークの拡大率';
  @override
  String get labelArtworkScalingDescription => '音楽プレイヤーのアートワークと背景画像の拡大率';
  @override
  String get labelBackgroundParallax => 'Background Parallax';
  @override
  String get labelBackgroundParallaxDescription =>  'Enable/Disable background image parallax effect';
  @override
  String get labelRestoreThumbnails => 'Restore Thumbnails';
  @override
  String get labelRestoreThumbnailsDescription => 'Force thumbnails and artwork generation process';
  @override
  String get labelRestoringArtworks => 'Restoring artworks';
  @override
  String get labelRestoringArtworksDone => 'Restoring artworks done';
  @override
  String get labelHomeScreen => 'ホーム画面';
  @override
  String get labelHomeScreenDescription => 'アプリ開始時の最初の表示画面を変更';
  @override
  String get labelDefaultMusicPage => 'Default Music Page';
  @override
  String get labelDefaultMusicPageDescription => 'Change the default page for the Music Page';
  @override
  String get labelAbout => 'About';
  @override
  String get labelConversionRequired => '要変換';
  @override
  String get labelConversionRequiredDescription =>  'この曲の形式は ID3 タグエディターの対応しません。本アプリはこの曲を AAC (m4a) に自動変換しこの問題を解決します。';
  @override
  String get labelPermissionRequired => '許可が必要';
  @override
  String get labelPermissionRequiredDescription => 'この端末上でSongTubeが曲を編集するにはすべてのファイルにアクセスする許可が必要です';
  @override
  String get labelApplying => '適用中';
  @override
  String get labelConvertingDescription => 'この曲を AAC (m4a) 形式に再エンコード中';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'この曲に新たなタグを適用中';
  @override
  String get labelApply => '適用';
  @override
  String get labelSongs => '曲';
  @override
  String get labelPlayAll => 'すべて再生';
  @override
  String get labelPlaying => 'Playing';
  @override
  String get labelPages => 'ページ';
  @override
  String get labelMusicPlayer => '音楽プレイヤー';
  @override
  String get labelClearWatchHistory => '再生履歴を消去';
  @override
  String get labelClearWatchHistoryDescription =>  '動画の再生履歴をすべて削除しようとしています。元に戻せません。続けますか？';
  @override
  String get labelDelete => '削除';
  @override
  String get labelAppUpdate => 'アプリの更新';
  @override
  String get labelWhatsNew => '更新内容';
  @override
  String get labelLater => '後で';
  @override
  String get labelUpdate => '更新';
  @override
  String get labelUnsubscribe => '登録解除';
  @override
  String get labelAudioFeatures => '音声の機能';
  @override
  String get labelVolumeBoost => '音量ブースト';
  @override
  String get labelNormalizeAudio => '音声の正規化';
  @override
  String get labelSegmentedDownload => 'Segmented Download';
  @override
  String get labelEnableSegmentedDownload => 'Enable Segmented Download';
  @override
  String get labelEnableSegmentedDownloadDescription => 'This will download the whole audio file and then split it into the various enabled segments (or audio tracks) from the list below';
  @override
  String get labelCreateMusicPlaylist => '音楽再生リストの作成';
  @override
  String get labelCreateMusicPlaylistDescription => 'Create music playlist from all downloaded and saved audio segments';
  @override
  String get labelApplyTags => 'Apply Tags';
  @override
  String get labelApplyTagsDescription => 'Extract tags from MusicBrainz for all segments';
  @override
  String get labelLoading => 'Loading';
  @override
  String get labelMusicDownloadDescription => 'Select quality, convert and download audio only';
  @override
  String get labelVideoDownloadDescription =>  'Choose a video quality from the list and download it';
  @override
  String get labelInstantDescription => 'Instantly start downloading as music';
  @override
  String get labelInstant => 'Instant';
  @override
  String get labelCurrentQuality => 'Current Quality';
  @override
  String get labelFastStreamingOptions => 'Fast Streaming Options';
  @override
  String get labelStreamingOptions => 'Streaming Options';
  @override
  String get labelComments => 'コメント';
  @override
  String get labelPinned => 'ピン留め';
  @override
  String get labelLikedByAuthor => 'Liked by Author';
  @override
  String get labelDescription => '説明';
  @override
  String get labelViews => 'Views';
  @override
  String get labelPlayingNextIn => 'Playing next in';
  @override
  String get labelPlayNow => '今すぐ再生';
  @override
  String get labelLoadingPlaylist => '再生リスト読み込み中';
  @override
  String get labelPlaylistReachedTheEnd => '再生リストの最後まで再生しました';
  @override
  String get labelLiked => 'Liked';
  @override
  String get labelLike => 'Like';
  @override
  String get labelVideoRemovedFromFavorites => 'お気に入りから動画を削除しました';
  @override
  String get labelVideoAddedToFavorites => 'お気に入りに動画を追加しました';
  @override
  String get labelPopupMode => 'Popup Mode';
  @override
  String get labelDownloaded => 'Downloaded';
  @override
  String get labelShowPlaylist => '再生リスト表示';
  @override
  String get labelCreatePlaylist => '再生リスト作成';
  @override
  String get labelAddVideoToPlaylist => '動画を再生リストに追加';
  @override
  String get labelBackupDescription => 'すべての端末内のデータを1つのファイルにバックアップし後から復元できます';
  @override
  String get labelBackupCreated => 'バックアップを作成しました';
  @override
  String get labelBackupRestored => 'バックアップを復元しました';
  @override
  String get labelRestoreDescription => 'バックアップファイルからすべてのデータを復元';
  @override
  String get labelChannelSuggestions => 'おすすめのチャンネル';
  @override
  String get labelFetchingChannels => 'チャンネル取得中';
  @override
  String get labelShareVideo => 'Shared Video';
  @override
  String get labelShareDescription => '友達やほかのプラットフォームに共有';
  @override
  String get labelRemoveFromPlaylists => '再生リストから削除';
  @override
  String get labelThisActionCannotBeUndone => 'この操作は元に戻せません';
  @override
  String get labelAddVideoToPlaylistDescription => '既存または新しい動画の再生リストに追加';
  @override
  String get labelAddToPlaylists => '再生リストに追加';
  @override
  String get labelEditableOnceSaved => 'Editable once saved';
  @override
  String get labelPlaylistRemoved => '再生リストを削除しました';
  @override
  String get labelPlaylistSaved => '再生リストを保存しました';
  @override
  String get labelRemoveFromFavorites => 'お気に入りから除去';
  @override
  String get labelRemoveFromFavoritesDescription => 'この動画をお気に入りから除去';
  @override
  String get labelSaveToFavorites => 'お気に入りに保存';
  @override
  String get labelSaveToFavoritesDescription => 'お気に入り一覧に追加';
  @override
  String get labelSharePlaylist => '再生リストを共有';
  @override
  String get labelRemoveThisVideoFromThisList => 'この一覧からこの動画を除去';
  @override
  String get labelEqualizer => 'イコライザー';
  @override
  String get labelLoudnessEqualizationGain => 'Loudness Equalization Gain';
  @override
  String get labelSliders => 'スライダー';
  @override
  String get labelSave => '保存';
  @override
  String get labelPlaylistName => '再生リスト名';
  @override
  String get labelCreateVideoPlaylist => '動画の再生リストの作成';
  @override
  String get labelSearchFilters => '検索絞り込み';
  @override
  String get labelAddToPlaylistDescription => '既存または新しい再生リストに追加';
  @override
  String get labelShareSong => '曲を共有';
  @override
  String get labelShareSongDescription => '友達やほかのプラットフォームに共有';
  @override
  String get labelEditTagsDescription => 'ID3 タグとアートワークのエディターを開く';
  @override
  String get labelContains => 'Contains';
}
