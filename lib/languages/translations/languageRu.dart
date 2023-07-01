import 'package:songtube/languages/languages.dart';

class LanguageRu extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Добро пожаловать в";
  @override
  String get labelStart => "Начать";
  @override
  String get labelSkip => "Пропустить";
  @override
  String get labelNext => "Далее";
  @override
  String get labelExternalAccessJustification =>
    "необходим доступ к внешнему хранилищу для сохранения" +
    "всех ваших видео и музыки";
  @override
  String get labelAppCustomization => "персонализация";
  @override
  String get labelSelectPreferred => "Выберите предпочтительный вариант";
  @override
  String get labelConfigReady => "Начальная настройка завершена";
  @override
  String get labelIntroductionIsOver => "Знакомство окончено";
  @override
  String get labelEnjoy => "Можете пользоваться";
  @override 
  String get labelGoHome => "На главную";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Главная";
  @override
  String get labelDownloads => "Загрузки";
  @override
  String get labelMedia => "Медиа";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Ещё";

  // Home Screen
  @override
  String get labelQuickSearch => "Поиск...";
  @override
  String get labelTagsEditor => "Редактор\nтегов";
  @override
  String get labelEditArtwork => "Редактор\nобложки";
  @override
  String get labelDownloadAll => "Скачать все";
  @override 
  String get labelLoadingVideos => "Загрузка видео...";
  @override
  String get labelHomePage => "Главная";
  @override
  String get labelTrending => "В тренде";
  @override
  String get labelFavorites => "Избранное";
  @override
  String get labelWatchLater => "Смотреть позже";

  // Video Options Menu
  @override
  String get labelCopyLink => "Скопировать ссылку";
  @override
  String get labelAddToFavorites => "Добавиь в Избранное";
  @override
  String get labelAddToWatchLater => "Добавить в Смотреть позже";
  @override
  String get labelAddToPlaylist => "Добавить в плейлист";

  // Downloads Screen
  @override
  String get labelQueued => "В очереди";
  @override
  String get labelDownloading => "Загрузка...";
  @override
  String get labelConverting => "Конвертация";
  @override
  String get labelCancelled => "Отменено";
  @override
  String get labelCompleted => "Загружено";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Загрузка добавлена в очередь";
  @override
  String get labelDownloadAcesssDenied => "Нет доступа";
  @override
  String get labelClearingExistingMetadata => "Очистка существующих тетаданных...";
  @override
  String get labelWrittingTagsAndArtwork => "Внесение тегов и обложек...";
  @override
  String get labelSavingFile => "Сохранение файла...";
  @override
  String get labelAndroid11FixNeeded => "Ошибка, требуется исправление для Android 11, проверьте настройки";
  @override
  String get labelErrorSavingDownload => "Не удалось сохранить загрузку, проверьте разрешения";
  @override
  String get labelDownloadingVideo => "Скачивание видео...";
  @override
  String get labelDownloadingAudio => "Скачивание аудио...";
  @override
  String get labelGettingAudioStream => "Получение аудиопотока...";
  @override
  String get labelAudioNoDataRecieved => "Не удалось получить аудиопоток";
  @override
  String get labelDownloadStarting => "Скачивание началось...";
  @override
  String get labelDownloadCancelled => "Скачивание отменено";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Конвертирование не удалось";
  @override
  String get labelPatchingAudio => "Cведение аудио...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Конвертация аудио";
  @override
  String get labelGainControls => "Регулятор усиления";
  @override
  String get labelVolume => "Громкость";
  @override
  String get labelBassGain => "Бас";
  @override
  String get labelTrebleGain => "Высокие частоты";
  @override
  String get labelSelectVideo => "Выберите формат видео";
  @override
  String get labelSelectAudio => "Выберите формат аудио";
  @override
  String get labelGlobalParameters => "Глобальные параметры";

  // Media Screen
  @override
  String get labelMusic => "Музыка";
  @override
  String get labelVideos => "Видео";
  @override
  String get labelNoMediaYet => "Пока что тут пусто";
  @override
  String get labelNoMediaYetJustification => "Вся ваша медиатека" +
    "будет отображаться тут";
  @override
  String get labelSearchMedia => "Поиск медиа...";
  @override
  String get labelDeleteSong => "Удалить песню";
  @override
  String get labelNoPermissionJustification => "Чтобы посмотреть вашу медиатеку" + "\n" +
    "дайте раршение к хранилищу";
  @override
  String get labelGettingYourMedia => "Получение вашей медиатеки...";
  @override
  String get labelEditTags => "Редактировать теги";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Поиск...";

  // More Screen
  @override
  String get labelSettings => "Настройки";
  @override
  String get labelDonate => "Пожертвовать";
  @override
  String get labelLicenses => "Лицензии";
  @override
  String get labelChooseColor => "Выберите цвет";
  @override
  String get labelTheme => "темы";
  @override
  String get labelUseSystemTheme => "Использовать системную тему";
  @override
  String get labelUseSystemThemeJustification =>
    "Включение/отключение системной темы";
  @override
  String get labelEnableDarkTheme => "Тёмная тема";
  @override
  String get labelEnableDarkThemeJustification =>
    "Использовать тёмную тему по умолчанию";
  @override
  String get labelEnableBlackTheme => "Amoled тема";
  @override
  String get labelEnableBlackThemeJustification =>
    "Использовать Amoled тему по умолчанию";
  @override
  String get labelAccentColor => "Цветовой акцент";
  @override
  String get labelAccentColorJustification => "Изменить цвет акцента";
  @override
  String get labelAudioFolder => "Папка для аудио";
  @override
  String get labelAudioFolderJustification => "Выберите папку " +
    "для скачанных аудио";
  @override
  String get labelVideoFolder => "Папака для видео";
  @override
  String get labelVideoFolderJustification => "Выберите папку" +
    "для скачанных видео";
  @override
  String get labelAlbumFolder => "Папка альбома";
  @override
  String get labelAlbumFolderJustification => "Создавать папку для каждой песни альбома";
  @override
  String get labelDeleteCache => "Очистить кэш";
  @override
  String get labelDeleteCacheJustification => "Очистить кэш SongTube";
  @override
  String get labelAndroid11Fix => "Исправление для Android 11";
  @override
  String get labelAndroid11FixJustification => "Исправляет проблемы со скачиванием на" +
    "Android 10 и 11";
  @override
  String get labelBackup => "Бэкап";
  @override
  String get labelBackupJustification => "Бэкап медиатеки";
  @override
  String get labelRestore => "Восстановить";
  @override
  String get labelRestoreJustification => "Воcтановить медиатеку";
  @override
  String get labelBackupLibraryEmpty => "Ваша медиатека пуста";
  @override
  String get labelBackupCompleted => "Бэкап завершён";
  @override
  String get labelRestoreNotFound => "Бэкап не найден";
  @override
  String get labelRestoreCompleted => "Восстановление завершено";
  @override
  String get labelCacheIsEmpty => "Кэш пуст";
  @override
  String get labelYouAreAboutToClear => "Будет очищено";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Название";
  @override
  String get labelEditorArtist => "Исполнитель";
  @override
  String get labelEditorGenre => "Жанр";
  @override
  String get labelEditorDisc => "Диск";
  @override
  String get labelEditorTrack => "Номер песни";
  @override
  String get labelEditorDate => "Дата";
  @override
  String get labelEditorAlbum => "Альбом";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Обнаружено, что вы пользуетесь Android 10 или 11";
  @override
  String get labelAndroid11DetectedJustification => "Для обеспечения правильного" +
    "загрузок на Android 10 и 11 дайте все разрешения." +
    "Возможно, потребуется разрешение на файлы, оно будет временным и не потребуется" +
    "при будущих обновлениях. Вы также можете применить это исправление в настройках.";

  // Music Player
  @override
  String get labelPlayerSettings => "Настройки плеера";
  @override
  String get labelExpandArtwork => "Увеличить обложку";
  @override
  String get labelArtworkRoundedCorners => "Скругление углов обложки";
  @override
  String get labelPlayingFrom => "Альбом";
  @override
  String get labelBlurBackground => "Заблюрить фон";

  // Video Page
  @override
  String get labelTags => "Теги";
  @override
  String get labelRelated => "Похожее";
  @override
  String get labelAutoPlay => "Автовоспроизведение";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Аудиоформат не поддерживается";
  @override
  String get labelNotSpecified => "Не указан";
  @override
  String get labelPerformAutomaticTagging => 
    "Автоматическое тегирование";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Тегирование с помощью MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Выберите обложку";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Подпишитесь на нас в телеграм!";
  @override
  String get labelJoinTelegramJustification =>
    "Вам нравится Song Tube? Пожалуйста, подпишитесь на наш телеграм канал! Там вы найдёте " +
    "обновления, различную информацию, в том числе о процессе разработки, ссылку на чат канала и другие ссылки на наши соцсети." +
    "\n\n" +
    "Если у вас есть проблема или отличная рекомендация, " +
    "пожалуйста, присоединяйтесь к чату из описания канала и напишите её! Но имейте в виду, " +
    "в чате можно общаться только на английском языке. Cпасибо!";
  @override
  String get labelRemindLater => "Напомнить позже";

  // Common Words (One word labels)
  @override
  String get labelExit => "Выйти";
  @override
  String get labelSystem => "Системная";
  @override
  String get labelChannel => "Канал";
  @override
  String get labelShare => "Поделиться";
  @override
  String get labelAudio => "Аудио";
  @override
  String get labelVideo => "Видео";
  @override
  String get labelDownload => "Скачать";
  @override
  String get labelBest => "Лучшее";
  @override
  String get labelPlaylist => "Плейлист";
  @override
  String get labelVersion => "Версия";
  @override
  String get labelLanguage => "Язык";
  @override
  String get labelGrant => "к внешнему хранилищу";
  @override
  String get labelAllow => "Дать";
  @override
  String get labelAccess => "Доступ";
  @override
  String get labelEmpty => "Пусто";
  @override
  String get labelCalculating => "Расчёт";
  @override
  String get labelCleaning => "Очистка";
  @override
  String get labelCancel => "Отмена";
  @override
  String get labelGeneral => "Общее";
  @override
  String get labelRemove => "Удалить";
  @override
  String get labelJoin => "Подписаться";
  @override
  String get labelNo => "Нет";
  @override
  String get labelLibrary => "библиотека";
  @override
  String get labelCreate => "Создавать";
  @override
  String get labelPlaylists => "Плейлисты";
  @override
  String get labelQuality => "Качественный";
  @override
  String get labelSubscribe => "Подписаться";

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
  @override
  String get labelPlaybackSpeed => 'Playback speed';
}