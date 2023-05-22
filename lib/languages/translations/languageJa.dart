import 'package:songtube/languages/languages.dart';

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

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'No Favorite Videos';
  @override
  String get labelNoFavoriteVideosDescription => 'Search for videos and save them as favorites. They will appear here';
  @override
  String get labelNoSubscriptions => 'No Subscriptions';
  @override
  String get labelNoSubscriptionsDescription => 'Tap the button above to show suggested Channels!';
  @override
  String get labelNoPlaylists => 'No Playlists';
  @override
  String get labelNoPlaylistsDescription => 'Search for videos or playlists and save them. They will appear here';
  @override
  String get labelSearch => 'Search';
  @override
  String get labelSubscriptions => 'Subscriptions';
  @override
  String get labelNoDownloadsCanceled => 'No Downloads Canceled';
  @override
  String get labelNoDownloadsCanceledDescription => 'Good news! But if you cancel or something goes wrong with the download, you can check from here';
  @override
  String get labelNoDownloadsYet => 'No Downloads Yet';
  @override
  String get labelNoDownloadsYetDescription => 'Go home, search for something to download or wait for the queue!';
  @override
  String get labelYourQueueIsEmpty => 'Your queue is empty';
  @override
  String get labelYourQueueIsEmptyDescription => 'Go home and search for something to download!';
  @override
  String get labelQueue => 'Queue';
  @override
  String get labelSearchDownloads => 'Search Downloads';
  @override
  String get labelWatchHistory => 'Watch History';
  @override
  String get labelWatchHistoryDescription => 'Look at which videos you have seen';
  @override
  String get labelBackupAndRestore => 'Backup & Restore';
  @override
  String get labelBackupAndRestoreDescription => 'Save or resture all of your local data';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription => 'Allow SongTube browser extension to detect this device, long press to learn more';
  @override
  String get labelSupportDevelopment => 'Support Development';
  @override
  String get labelSocialLinks => 'Social Links';
  @override
  String get labelSeeMore => 'See more';
  @override
  String get labelMostPlayed => 'Most played';
  @override
  String get labelNoPlaylistsYet => 'No Playlists Yet';
  @override
  String get labelNoPlaylistsYetDescription => 'You can create a playlist from your recents, music, albums or artists';
  @override
  String get labelNoSearchResults => 'No search results';
  @override
  String get labelSongResults => 'Song results';
  @override
  String get labelAlbumResults => 'Album results';
  @override
  String get labelArtistResults => 'Artist results';
  @override
  String get labelSearchAnything => 'Search anything';
  @override
  String get labelRecents => 'Recents';
  @override
  String get labelFetchingSongs => 'Fetching Songs';
  @override
  String get labelPleaseWaitAMoment => 'Please wait a moment';
  @override
  String get labelWeAreDone => 'We are done';
  @override
  String get labelEnjoyTheApp => 'Enjoy the\nApp';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube is back with a cleaner look and set of features, have fun with your music!';
  @override
  String get labelLetsGo => 'Let\'s go';
  @override
  String get labelPleaseWait => 'Please wait';
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
  String get labelContinue => 'Continue';
  @override
  String get labelAllowStorageRead => 'Allow Storage Read';
  @override
  String get labelSelectYourPreferred => 'Select your preferred';
  @override
  String get labelLight => 'Light';
  @override
  String get labelDark => 'Dark';
  @override
  String get labelSimultaneousDownloads => 'Simultaneous Downloads';
  @override
  String get labelSimultaneousDownloadsDescription => 'Define how many downloads can happen at the same time';
  @override
  String get labelItems => 'Items';
  @override
  String get labelInstantDownloadFormat => 'Instant Download';
  @override
  String get labelInstantDownloadFormatDescription => 'Change the audio format for instant downloads';
  @override
  String get labelCurrent => 'Current';
  @override
  String get labelPauseWatchHistory => 'Pause Watch History';
  @override
  String get labelPauseWatchHistoryDescription => 'While paused, videos are not saved into the watch history list';
  @override
  String get labelLockNavigationBar => 'Lock Navigation Bar';
  @override
  String get labelLockNavigationBarDescription => 'Locks the navigation bar from hiding and showing automatically on scroll';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription => 'Automatically enters PiP mode upon tapping home button while watching a video';
  @override
  String get labelBackgroundPlaybackAlpha => 'Background Playback (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Toggle background playback feature. Due to plugin limitations, only current video can be played in the background';
  @override
  String get labelBlurBackgroundDescription => 'Add blurred artwork background';
  @override
  String get labelBlurIntensity => 'Blur Intensity';
  @override
  String get labelBlurIntensityDescription => 'Change the blur intensity of the artwork background';
  @override
  String get labelBackdropOpacity => 'Backdrop Opacity';
  @override
  String get labelBackdropOpacityDescription => 'Change the colored backdrop opacity';
  @override
  String get labelArtworkShadowOpacity => 'Artwork Shadow Opacity';
  @override
  String get labelArtworkShadowOpacityDescription => 'Change the artwork shadow intensity of the music player';
  @override
  String get labelArtworkShadowRadius => 'Artwork Shadow Radius';
  @override
  String get labelArtworkShadowRadiusDescription => 'Change the artwork shadow radius of the music player';
  @override
  String get labelArtworkScaling => 'Artwork Scaling';
  @override
  String get labelArtworkScalingDescription => 'Scale out the music player artwork & background images';
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
  String get labelHomeScreen => 'Home Screen';
  @override
  String get labelHomeScreenDescription => 'Change the default landing screen when you open the app';
  @override
  String get labelDefaultMusicPage => 'Default Music Page';
  @override
  String get labelDefaultMusicPageDescription => 'Change the default page for the Music Page';
  @override
  String get labelAbout => 'About';
  @override
  String get labelConversionRequired => 'Conversion Required';
  @override
  String get labelConversionRequiredDescription =>  'This song format is incompatible with the ID3 Tags editor. The app will automatically convert this song to AAC (m4a) to sort out this issue.';
  @override
  String get labelPermissionRequired => 'Permission Required';
  @override
  String get labelPermissionRequiredDescription => 'All file access permission is required for SongTube to edit any song on your device';
  @override
  String get labelApplying => 'Applying';
  @override
  String get labelConvertingDescription => 'Re-encoding this song into AAC (m4a) format';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Applying new tags to this song';
  @override
  String get labelApply => 'Apply';
  @override
  String get labelSongs => 'Songs';
  @override
  String get labelPlayAll => 'Play All';
  @override
  String get labelPlaying => 'Playing';
  @override
  String get labelPages => 'Pages';
  @override
  String get labelMusicPlayer => 'Music Player';
  @override
  String get labelClearWatchHistory => 'Clear Watch History';
  @override
  String get labelClearWatchHistoryDescription =>  'You\'re about to delete all your watch history videos, this action cannot be undone, proceed?';
  @override
  String get labelDelete => 'Delete';
  @override
  String get labelAppUpdate => 'App Update';
  @override
  String get labelWhatsNew => 'What\'s New';
  @override
  String get labelLater => 'Later';
  @override
  String get labelUpdate => 'Update';
  @override
  String get labelUnsubscribe => 'Unsubscribe';
  @override
  String get labelAudioFeatures => 'Audio Features';
  @override
  String get labelVolumeBoost => 'Volume Boost';
  @override
  String get labelNormalizeAudio => 'Normalize Audio';
  @override
  String get labelSegmentedDownload => 'Segmented Download';
  @override
  String get labelEnableSegmentedDownload => 'Enable Segmented Download';
  @override
  String get labelEnableSegmentedDownloadDescription => 'This will download the whole audio file and then split it into the various enabled segments (or audio tracks) from the list below';
  @override
  String get labelCreateMusicPlaylist => 'Create Music Playlist';
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
  String get labelComments => 'Comments';
  @override
  String get labelPinned => 'Pinned';
  @override
  String get labelLikedByAuthor => 'Liked by Author';
  @override
  String get labelDescription => 'Description';
  @override
  String get labelViews => 'Views';
  @override
  String get labelPlayingNextIn => 'Playing next in';
  @override
  String get labelPlayNow => 'Play Now';
  @override
  String get labelLoadingPlaylist => 'Loading Playlist';
  @override
  String get labelPlaylistReachedTheEnd => 'Playlist reached the end';
  @override
  String get labelLiked => 'Liked';
  @override
  String get labelLike => 'Like';
  @override
  String get labelVideoRemovedFromFavorites => 'Video removed from favorites';
  @override
  String get labelVideoAddedToFavorites => 'Video added to favorites';
  @override
  String get labelPopupMode => 'Popup Mode';
  @override
  String get labelDownloaded => 'Downloaded';
  @override
  String get labelShowPlaylist => 'Show Playlist';
  @override
  String get labelCreatePlaylist => 'Create Playlist';
  @override
  String get labelAddVideoToPlaylist => 'Add video to playlist';
  @override
  String get labelBackupDescription => 'Backup all of your local data into a single file that can be used to restore later';
  @override
  String get labelBackupCreated => 'Backup Created';
  @override
  String get labelBackupRestored => 'Backup Restored';
  @override
  String get labelRestoreDescription => 'Restore all your data from a backup file';
  @override
  String get labelChannelSuggestions => 'Channel Suggestions';
  @override
  String get labelFetchingChannels => 'Fetching Channels';
  @override
  String get labelShareVideo => 'Shared Video';
  @override
  String get labelShareDescription => 'Share with friends or other platforms';
  @override
  String get labelRemoveFromPlaylists => 'Remove from playlist';
  @override
  String get labelThisActionCannotBeUndone => 'This action cannot be undone';
  @override
  String get labelAddVideoToPlaylistDescription => 'Add to existing or new video playlist';
  @override
  String get labelAddToPlaylists => 'Add to playlists';
  @override
  String get labelEditableOnceSaved => 'Editable once saved';
  @override
  String get labelPlaylistRemoved => 'Playlist Removed';
  @override
  String get labelPlaylistSaved => 'Playlist Saved';
  @override
  String get labelRemoveFromFavorites => 'Remove from favorites';
  @override
  String get labelRemoveFromFavoritesDescription => 'Remove this video from your favorites';
  @override
  String get labelSaveToFavorites => 'Save to favorites';
  @override
  String get labelSaveToFavoritesDescription => 'Add video to your list of favorites';
  @override
  String get labelSharePlaylist => 'Share Playlist';
  @override
  String get labelRemoveThisVideoFromThisList => 'Remove this video from this list';
  @override
  String get labelEqualizer => 'Equalizer';
  @override
  String get labelLoudnessEqualizationGain => 'Loudness Equalization Gain';
  @override
  String get labelSliders => 'Sliders';
  @override
  String get labelSave => 'Save';
  @override
  String get labelPlaylistName => 'PlaylistName';
  @override
  String get labelCreateVideoPlaylist => 'Create Video Playlist';
  @override
  String get labelSearchFilters => 'Search Filters';
  @override
  String get labelAddToPlaylistDescription => 'Add to existing or new playlist';
  @override
  String get labelShareSong => 'Share Song';
  @override
  String get labelShareSongDescription => 'Share with friends or other platforms';
  @override
  String get labelEditTagsDescription => 'Open ID3 tags and artwork editor';
  @override
  String get labelContains => 'Contains';
}