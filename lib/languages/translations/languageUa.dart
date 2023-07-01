import 'package:songtube/languages/languages.dart';

class LanguageUa extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Вітаємо в";
  @override
  String get labelStart => "Старт";
  @override
  String get labelSkip => "Пропустити";
  @override
  String get labelNext => "Далі";
  @override
  String get labelExternalAccessJustification =>
    "Необхідний доступ до зовнішнього сховища для збереження" +
    "ваших відео та музики";
  @override
  String get labelAppCustomization => "Персоналізація";
  @override
  String get labelSelectPreferred => "Виберіть пріоритетний варіант";
  @override
  String get labelConfigReady => "Початкове налаштування завершено";
  @override
  String get labelIntroductionIsOver => "Ознайомлено";
  @override
  String get labelEnjoy => "Насолоджуйтесь!";
  @override 
  String get labelGoHome => "На головну";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Головна";
  @override
  String get labelDownloads => "Завантаження";
  @override
  String get labelMedia => "Медіа";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Додатково";

  // Home Screen
  @override
  String get labelQuickSearch => "Пошук...";
  @override
  String get labelTagsEditor => "Редактор\nтегів";
  @override
  String get labelEditArtwork => "Редактор\nобкладинки";
  @override
  String get labelDownloadAll => "Завантажити все";
  @override 
  String get labelLoadingVideos => "Завантаження видео...";
  @override
  String get labelHomePage => "Головна";
  @override
  String get labelTrending => "В тренді";
  @override
  String get labelFavorites => "Обране";
  @override
  String get labelWatchLater => "Переглянути пізніше";

  // Video Options Menu
  @override
  String get labelCopyLink => "Скопіювати посилання";
  @override
  String get labelAddToFavorites => "Додати до Обраного";
  @override
  String get labelAddToWatchLater => "Додати до Переглянути пізніше";
  @override
  String get labelAddToPlaylist => "Додати до плейлисту";

  // Downloads Screen
  @override
  String get labelQueued => "В черзі";
  @override
  String get labelDownloading => "Завантаження...";
  @override
  String get labelConverting => "Конвертація";
  @override
  String get labelCancelled => "Відмінено";
  @override
  String get labelCompleted => "Завантажено";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Завантаження додано до черги";
  @override
  String get labelDownloadAcesssDenied => "Доступ заборонено";
  @override
  String get labelClearingExistingMetadata => "Очищення існуючих метаданих...";
  @override
  String get labelWrittingTagsAndArtwork => "Внесення тегів і обкладинок...";
  @override
  String get labelSavingFile => "Збереження файлу...";
  @override
  String get labelAndroid11FixNeeded => "Помилка, потрібно виправлення для Android 11, перевірте налаштування";
  @override
  String get labelErrorSavingDownload => "Неможливо зберегти завантаження, перевірте дозвіл на збереження";
  @override
  String get labelDownloadingVideo => " Завантаження відео...";
  @override
  String get labelDownloadingAudio => "Завантаження аудіо...";
  @override
  String get labelGettingAudioStream => "Отримання аудіопотоку...";
  @override
  String get labelAudioNoDataRecieved => "Не вдалось отримати аудіопотік";
  @override
  String get labelDownloadStarting => "Завантаження розпочалось...";
  @override
  String get labelDownloadCancelled => "Завантаження відмінено";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Конвертація не вдалась";
  @override
  String get labelPatchingAudio => "Зведення аудіо...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Конвертація аудіо";
  @override
  String get labelGainControls => "Регулятор підсилення";
  @override
  String get labelVolume => "Гучність";
  @override
  String get labelBassGain => "Бас";
  @override
  String get labelTrebleGain => "Високі частоти";
  @override
  String get labelSelectVideo => "Оберіть формат відео";
  @override
  String get labelSelectAudio => "Оберіть формат аудіо";
  @override
  String get labelGlobalParameters => "Глобальні параметри";

  // Media Screen
  @override
  String get labelMusic => "Музика";
  @override
  String get labelVideos => "Відео";
  @override
  String get labelNoMediaYet => "Нажаль, тут пусто";
  @override
  String get labelNoMediaYetJustification => "Ваша медіатека" +
    "буде відображатись тут";
  @override
  String get labelSearchMedia => "Пошук медіа...";
  @override
  String get labelDeleteSong => "Видалити пісню";
  @override
  String get labelNoPermissionJustification => "Щоб мати змогу переглядати вашу медіатеку" + "\n" +
    "надайте дозвіл до сховища";
  @override
  String get labelGettingYourMedia => "Отримання вашої медіатеки...";
  @override
  String get labelEditTags => "Редагувати теги";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Пошук...";

  // More Screen
  @override
  String get labelSettings => "Налаштування";
  @override
  String get labelDonate => "Донат";
  @override
  String get labelLicenses => "Ліцензії";
  @override
  String get labelChooseColor => "Оберіть колір";
  @override
  String get labelTheme => "Теми";
  @override
  String get labelUseSystemTheme => "Використати системную тему";
  @override
  String get labelUseSystemThemeJustification =>
    "Увімкнення/вимкнення системной теми";
  @override
  String get labelEnableDarkTheme => "Темна тема";
  @override
  String get labelEnableDarkThemeJustification =>
    "Використати темну тему за замовчуванню";
  @override
  String get labelEnableBlackTheme => "Amoled тема";
  @override
  String get labelEnableBlackThemeJustification =>
    "Використати Amoled тему за замовчуванню";
  @override
  String get labelAccentColor => " Колірний акцент";
  @override
  String get labelAccentColorJustification => "Змінити колір акценту";
  @override
  String get labelAudioFolder => "Тека для аудіо";
  @override
  String get labelAudioFolderJustification => "Оберіть теку " +
    "для завантажених аудіо";
  @override
  String get labelVideoFolder => "Тека для відео";
  @override
  String get labelVideoFolderJustification => "Оберіть теку" +
    "для завантажених відео";
  @override
  String get labelAlbumFolder => "Тека альбому";
  @override
  String get labelAlbumFolderJustification => "Створювати теку для кожної пісні альбому";
  @override
  String get labelDeleteCache => "Очистити кеш";
  @override
  String get labelDeleteCacheJustification => "Очистити кеш SongTube";
  @override
  String get labelAndroid11Fix => "Виправлення для Android 11";
  @override
  String get labelAndroid11FixJustification => "Виправляє проблеми зі скачуванням на" +
    "Android 10 и 11";
  @override
  String get labelBackup => "Бекап";
  @override
  String get labelBackupJustification => "Бекап медіатеки";
  @override
  String get labelRestore => "Відновити";
  @override
  String get labelRestoreJustification => "Відновити медіатеку";
  @override
  String get labelBackupLibraryEmpty => "Нажаль, Ваша медіатека пуста";
  @override
  String get labelBackupCompleted => "Бекап завершено";
  @override
  String get labelRestoreNotFound => "Бекап не знайдено";
  @override
  String get labelRestoreCompleted => "Відновлення завершено";
  @override
  String get labelCacheIsEmpty => "Кеш пустий";
  @override
  String get labelYouAreAboutToClear => "Буде очищено";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Назва";
  @override
  String get labelEditorArtist => "Виконавець";
  @override
  String get labelEditorGenre => "Жанр";
  @override
  String get labelEditorDisc => "Диск";
  @override
  String get labelEditorTrack => "Номер пісні";
  @override
  String get labelEditorDate => "Дата";
  @override
  String get labelEditorAlbum => "Альбом";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Виявлено, що ви використовуєте Android 10 або 11";
  @override
  String get labelAndroid11DetectedJustification => "Для забезпечення правильного" +
    "завантаження на Android 10 и 11 надайте всі дозволи." +
    "Можливо, буде потрібно дозвіл на файли, воно буде тимчасовим і не буде потрібно" +
    "при майбутніх оновленнях. Ви також можете застосувати це виправлення в налаштуваннях.";

  // Music Player
  @override
  String get labelPlayerSettings => "Налаштування плеєра";
  @override
  String get labelExpandArtwork => "Збільшити обкладинку";
  @override
  String get labelArtworkRoundedCorners => "Округлення кутів обкладинки";
  @override
  String get labelPlayingFrom => "Альбом";
  @override
  String get labelBlurBackground => "Заблюрити фон";

  // Video Page
  @override
  String get labelTags => "Теги";
  @override
  String get labelRelated => "Схоже";
  @override
  String get labelAutoPlay => "Автовідтворення";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Аудіоформат не підтримується";
  @override
  String get labelNotSpecified => "Не вказано";
  @override
  String get labelPerformAutomaticTagging => 
    "Автоматичне тегирування";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Тегирування із допомогою MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Оберіть обкладинку";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Підпишіться на нас в телеграмі!";
  @override
  String get labelJoinTelegramJustification =>
    "Чи подобається Song Tube? Будь ласка, підпишіться на наш телеграм канал! Там ви знайдете " +
    "оновлення, різну інформацію, а також про процес розробки, посилання на чат каналу та інші посилання на наші соцмережі." +
    "\n\n" +
    "Якщо є проблема чи рекомендація, " +
    "будь ласка, приєднуйтесь до чату з опису каналу і опишіть її! Але майте на увазі, " +
    "в чаті можна спілкуватись лише англійскою мовою. Дякуємо!";
  @override
  String get labelRemindLater => "Нагадати пізніше";

  // Common Words (One word labels)
  @override
  String get labelExit => "Вийти";
  @override
  String get labelSystem => "Системна";
  @override
  String get labelChannel => "Канал";
  @override
  String get labelShare => "Поширити";
  @override
  String get labelAudio => "Аудіо";
  @override
  String get labelVideo => "Відео";
  @override
  String get labelDownload => "Завантажити";
  @override
  String get labelBest => "Найкраще";
  @override
  String get labelPlaylist => "Плейлист";
  @override
  String get labelVersion => "Версія";
  @override
  String get labelLanguage => "Мова";
  @override
  String get labelGrant => "До зовнішнього сховища";
  @override
  String get labelAllow => "Надати";
  @override
  String get labelAccess => "Доступ";
  @override
  String get labelEmpty => "Пусто";
  @override
  String get labelCalculating => "Розрахунок";
  @override
  String get labelCleaning => "Очищення";
  @override
  String get labelCancel => "Відміна";
  @override
  String get labelGeneral => "Загальне";
  @override
  String get labelRemove => "Видалити";
  @override
  String get labelJoin => "Приєднатись";
  @override
  String get labelNo => "Ніт";
  @override
  String get labelLibrary => "Бібліотека";
  @override
  String get labelCreate => "Створювати";
  @override
  String get labelPlaylists => "Плейлисти";
  @override
  String get labelQuality => "Якісний";
  @override
  String get labelSubscribe => "Підписатись";

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
