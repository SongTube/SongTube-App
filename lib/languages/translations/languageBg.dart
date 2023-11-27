import 'package:songtube/languages/languages.dart';

class LanguageBg extends Languages {
    
  // Introduction Screens
  @override
  String get labelAppWelcome => "Добре дошли в";
  @override
  String get labelStart => "Старт";
  @override
  String get labelSkip => "Пропусни";
  @override
  String get labelNext => "Следващ";
  @override
  String get labelExternalAccessJustification =>
    "Изисква достъп до вашия външен съхранителен диск, за да се запазят " +
    "всичките ви видеоклипове и музика";
  @override
  String get labelAppCustomization => "Персонализация";
  @override
  String get labelSelectPreferred => "Изберете по предпочитание";
  @override
  String get labelConfigReady => "Конфигурацията е готова";
  @override
  String get labelIntroductionIsOver => "Въвеждането завърши";
  @override
  String get labelEnjoy => "Насладете се";
  @override 
  String get labelGoHome => "Отиди в началото";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Начало";
  @override
  String get labelDownloads => "Изтегляния";
  @override
  String get labelMedia => "Медия";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Още";

  // Home Screen
  @override
  String get labelQuickSearch => "Бързо търсене...";
  @override
  String get labelTagsEditor => "Редактор на тагове";
  @override
  String get labelEditArtwork => "Редакция\nна графиката";
  @override
  String get labelDownloadAll => "Изтегли всичко";
  @override 
  String get labelLoadingVideos => "Зареждане на видеоклипове...";
  @override
  String get labelHomePage => "Начална страница";
  @override
  String get labelTrending => "Тенденции";
  @override
  String get labelFavorites => "Любими";
  @override
  String get labelWatchLater => "Гледай по-късно";

  // Video Options Menu
  @override
  String get labelCopyLink => "Копиране на линк";
  @override
  String get labelAddToFavorites => "Добавяне в Любими";
  @override
  String get labelAddToWatchLater => "Добавяне в Гледай по-късно";
  @override
  String get labelAddToPlaylist => "Добавяне в Плейлист";

  // Downloads Screen
  @override
  String get labelQueued => "В опашка";
  @override
  String get labelDownloading => "Изтегляне";
  @override
  String get labelConverting => "Конвертиране";
  @override
  String get labelCancelled => "Отменено";
  @override
  String get labelCompleted => "Завършено";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Изтеглянето е в опашка";
  @override
  String get labelDownloadAcesssDenied => "Достъпът е отказан";
  @override
  String get labelClearingExistingMetadata => "Изчистване на съществуващи метаданни...";
  @override
  String get labelWrittingTagsAndArtwork => "Запис на тагове и изкуство...";
  @override
  String get labelSavingFile => "Запазване на файл...";
  @override
  String get labelAndroid11FixNeeded => "Грешка, изисква се корекция за Android 11, проверете настройките";
  @override
  String get labelErrorSavingDownload => "Неуспешно запазване на изтеглянето ви, проверете разрешенията";
  @override
  String get labelDownloadingVideo => "Изтегляне на видео...";
  @override
  String get labelDownloadingAudio => "Изтегляне на аудио...";
  @override
  String get labelGettingAudioStream => "Получаване на аудио поток...";
  @override
  String get labelAudioNoDataRecieved => "Не може да се получи аудио поток";
  @override
  String get labelDownloadStarting => "Започва изтеглянето...";
  @override
  String get labelDownloadCancelled => "Изтеглянето е отменено";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Неуспешно конвертиране на аудиото";
  @override
  String get labelPatchingAudio => "Подготвяне на Аудио...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Включи Аудио Конвертиране";
  @override
  String get labelGainControls => "Контроли на усилването";
  @override
  String get labelVolume => "Сила на звука";
  @override
  String get labelBassGain => "Сила на баса";
  @override
  String get labelTrebleGain => "Сила на високите честоти";
  @override
  String get labelSelectVideo => "Избор на Видео";
  @override
  String get labelSelectAudio => "Избор на Аудио";
  @override
  String get labelGlobalParameters => "Глобални параметри";

  // Media Screen
  @override
  String get labelMusic => "Музика";
  @override
  String get labelVideos => "Видео";
  @override
  String get labelNoMediaYet => "Все още няма медия";
  @override
  String get labelNoMediaYetJustification => "Цялата ви медия " +
    "ще бъде показана тук";
  @override
  String get labelSearchMedia => "Търси Медия...";
  @override
  String get labelDeleteSong => "Изтрий Песен";
  @override
  String get labelNoPermissionJustification => "Вижте вашите медийни файлове, като" + "\n" +
    "предоставите разрешение за достъп до хранилището";
  @override
  String get labelGettingYourMedia => "Изтегляне на вашите Медия...";
  @override
  String get labelEditTags => "Редактиране на тагове";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Търси в YouTube...";

  // More Screen
  @override
  String get labelSettings => "Настройки";
  @override
  String get labelDonate => "Дарете";
  @override
  String get labelLicenses => "Лицензи";
  @override
  String get labelChooseColor => "Изберете Цвят";
  @override
  String get labelTheme => "Тема";
  @override
  String get labelUseSystemTheme => "Използвайте системната тема";
  @override
  String get labelUseSystemThemeJustification =>
    "Активиране/Деактивиране на автоматичната тема";
  @override
  String get labelEnableDarkTheme => "Активирайте тъмната тема";
  @override
  String get labelEnableDarkThemeJustification =>
    "Използвайте тъмна тема по подразбиране";
  @override
  String get labelEnableBlackTheme => "Активирайте черната тема";
  @override
  String get labelEnableBlackThemeJustification =>
    "Активирайте темата Pure Black";
  @override
  String get labelAccentColor => "Цвят на акцента";
  @override
  String get labelAccentColorJustification => "Персонализирайте цвета на акцента";
  @override
  String get labelAudioFolder => "Аудио Папка";
  @override
  String get labelAudioFolderJustification => "Изберете папка за " +
    "Аудио изтегляния";
  @override
  String get labelVideoFolder => "Видео Папка";
  @override
  String get labelVideoFolderJustification => "Изберете папка за " +
    "Видео изтегляния";
  @override
  String get labelAlbumFolder => "Албумна Папка";
  @override
  String get labelAlbumFolderJustification => "Създайте папка за всеки албум с песни";
  @override
  String get labelDeleteCache => "Изчистване на кеша";
  @override
  String get labelDeleteCacheJustification => "Изчистете кеша на SongTube";
  @override
  String get labelAndroid11Fix => "Поправете Android 11";
  @override
  String get labelAndroid11FixJustification => "Поправя проблеми свързани с изтеглянето на " +
    "Android 10 и 11";
  @override
  String get labelBackup => "Архивиране";
  @override
  String get labelBackupJustification => "Архивирайте медийната си библиотека";
  @override
  String get labelRestore => "Възстанови";
  @override
  String get labelRestoreJustification => "Възстановете медийната си библиотека";
  @override
  String get labelBackupLibraryEmpty => "Вашата библиотека е празна";
  @override
  String get labelBackupCompleted => "Архивирането е завършено";
  @override
  String get labelRestoreNotFound => "Възстановяването не е намерено";
  @override
  String get labelRestoreCompleted => "Възстановяването е завършено";
  @override
  String get labelCacheIsEmpty => "Кешът е празен";
  @override
  String get labelYouAreAboutToClear => "На път сте да изчистите";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Заглавие";
  @override
  String get labelEditorArtist => "Артист";
  @override
  String get labelEditorGenre => "Жанр";
  @override
  String get labelEditorDisc => "Диск";
  @override
  String get labelEditorTrack => "Запис";
  @override
  String get labelEditorDate => "Дата";
  @override
  String get labelEditorAlbum => "Албум";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Открит е Android 10 или 11";
  @override
  String get labelAndroid11DetectedJustification => "За да се гарантира правилното " +
    "функциониране на изтеглянията в това приложение, на Android 10 и 11 " +
    "може да бъде необходим достъп до всички разрешения за файлове, което ще бъде " +
    "временно и не е необходимо за бъдещи актуализации. Можете също да приложите " +
    "тази корекция и в настройките.";

  // Music Player
  @override
  String get labelPlayerSettings => "Настройки на плейъра";
  @override
  String get labelExpandArtwork => "Разшири изображението";
  @override
  String get labelArtworkRoundedCorners => "Закръглени ъгли на изображението";
  @override
  String get labelPlayingFrom => "Възпроизвеждане от";
  @override
  String get labelBlurBackground => "Замъгляване на фона";

  // Video Page
  @override
  String get labelTags => "Етикети";
  @override
  String get labelRelated => "Свързани";
  @override
  String get labelAutoPlay => "Автоматично възпроизвеждане";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Аудио форматът не е съвместим";
  @override
  String get labelNotSpecified => "Не е посочено";
  @override
  String get labelPerformAutomaticTagging => 
    "Извърши автоматично маркиране";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Избери тагове от MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Избери изображения от устройството";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Присъединете се към канала в Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Харесвате ли SongTube? Моля, присъединете се към Telegram канала! Там ще намерите " +
    "актуализации, информация, разработка, линк към групата и други социални линкове." +
    "\n\n" +
    "В случай че имате проблем или страхотно предложение, " +
    "моля присъединете се към групата от канала и го запишете! Имайте предвид, че " +
    "можете да говорите само на английски, благодаря!";
  @override
  String get labelRemindLater => "Remind Later";

  // Common Words (One word labels)
  @override
  String get labelExit => "Изход";
  @override
  String get labelSystem => "Система";
  @override
  String get labelChannel => "Канал";
  @override
  String get labelShare => "Сподели";
  @override
  String get labelAudio => "Аудио";
  @override
  String get labelVideo => "Видео";
  @override
  String get labelDownload => "Изтегли";
  @override
  String get labelBest => "Най-добро";
  @override
  String get labelPlaylist => "Плейлист";
  @override
  String get labelVersion => "Версия";
  @override
  String get labelLanguage => "Език";
  @override
  String get labelGrant => "Субсидия";
  @override
  String get labelAllow => "Разреши";
  @override
  String get labelAccess => "Достъп";
  @override
  String get labelEmpty => "Празно";
  @override
  String get labelCalculating => "Изчисляване";
  @override
  String get labelCleaning => "Изчистване";
  @override
  String get labelCancel => "Отказ";
  @override
  String get labelGeneral => "Общи";
  @override
  String get labelRemove => "Премахни";
  @override
  String get labelJoin => "Присъедини се";
  @override
  String get labelNo => "Не";
  @override
  String get labelLibrary => "Библиотека";
  @override
  String get labelCreate => "Създай";
  @override
  String get labelPlaylists => "Плейлисти";
  @override
  String get labelQuality => "Качество";
  @override
  String get labelSubscribe => "Абонирай се";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Няма любими видеоклипове';
  @override
  String get labelNoFavoriteVideosDescription => 'Търсете видеоклипове и ги запазвайте като любими. Те ще се появят тук';
  @override
  String get labelNoSubscriptions => 'Няма абонаменти';
  @override
  String get labelNoSubscriptionsDescription => 'Докоснете бутона отгоре, за да видите предложените канали!';
  @override
  String get labelNoPlaylists => 'Без плейлисти';
  @override
  String get labelNoPlaylistsDescription => 'Търсете видеоклипове или плейлисти и ги запазвайте. Те ще се появят тук';
  @override
  String get labelSearch => 'Търсене';
  @override
  String get labelSubscriptions => 'Абонаменти';
  @override
  String get labelNoDownloadsCanceled => 'Няма отменени изтегляния';
  @override
  String get labelNoDownloadsCanceledDescription => 'Добри новини! Но ако отмените нещо или нещо се обърка по време на изтеглянето, можете да проверите оттук';
  @override
  String get labelNoDownloadsYet => 'Все още няма изтегляния';
  @override
  String get labelNoDownloadsYetDescription => 'Върнете се в начало, потърсете нещо за изтегляне или изчакайте опашката!';
  @override
  String get labelYourQueueIsEmpty => 'Опашката е празна';
  @override
  String get labelYourQueueIsEmptyDescription => 'Върнете се в начало и потърсете нещо за изтегляне!';
  @override
  String get labelQueue => 'Опашка';
  @override
  String get labelSearchDownloads => 'Търсене в изтеглянията';
  @override
  String get labelWatchHistory => 'История на гледане';
  @override
  String get labelWatchHistoryDescription => 'Вижте кои видеоклипове сте гледали';
  @override
  String get labelBackupAndRestore => 'Резервно копие и възстановяване';
  @override
  String get labelBackupAndRestoreDescription => 'Запазете или възстановете всички ваши локални данни';
  @override
  String get labelSongtubeLink => 'SongTube Връзка';
  @override
  String get labelSongtubeLinkDescription => 'Разрешете на разширението на браузъра SongTube да открие това устройство, натиснете продължително, за да научите повече';
  @override
  String get labelSupportDevelopment => 'Подкрепете разработката';
  @override
  String get labelSocialLinks => 'Социални линкове';
  @override
  String get labelSeeMore => 'Вижте още';
  @override
  String get labelMostPlayed => 'Най-пускани';
  @override
  String get labelNoPlaylistsYet => 'Все още няма плейлисти';
  @override
  String get labelNoPlaylistsYetDescription => 'Можете да създадете плейлист от вашите последни, музика, албуми или изпълнители';
  @override
  String get labelNoSearchResults => 'Няма резултати от търсенето';
  @override
  String get labelSongResults => 'Резултати от търсенето за песни';
  @override
  String get labelAlbumResults => 'Резултати от търсенето за албуми';
  @override
  String get labelArtistResults => 'Резултати от търсенето за артисти';
  @override
  String get labelSearchAnything => 'Търсене на каквото и да е';
  @override
  String get labelRecents => 'Последни';
  @override
  String get labelFetchingSongs => 'Извличане на песни';
  @override
  String get labelPleaseWaitAMoment => 'Моля, изчакайте един момент';
  @override
  String get labelWeAreDone => 'Готови сме';
  @override
  String get labelEnjoyTheApp => 'Насладете се на\nПриложението';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube се завръща с по-чист вид и набор от функции, наслаждавайте се на вашата музика!';
  @override
  String get labelLetsGo => 'Хайде';
  @override
  String get labelPleaseWait => 'Моля изчакайте';
  @override
  String get labelPoweredBy => 'Предоставено от';
  @override
  String get labelGetStarted => 'Започнете';
  @override
  String get labelAllowUsToHave => 'Разрешете ни да имаме';
  @override
  String get labelStorageRead => 'Съхранение\Четене';
  @override
  String get labelStorageReadDescription => 'Това ще сканира музиката ви, ще извлече изображения с високо качество и ще ви позволи да персонализирате вашата музика';
  @override
  String get labelContinue => 'Продължи';
  @override
  String get labelAllowStorageRead => 'Разрешете четенето на съхранението';
  @override
  String get labelSelectYourPreferred => 'Изберете вашите предпочитания';
  @override
  String get labelLight => 'Светло';
  @override
  String get labelDark => 'Тъмно';
  @override
  String get labelSimultaneousDownloads => 'Едновременни Изтегляния';
  @override
  String get labelSimultaneousDownloadsDescription => 'Задайте колко изтегляния могат да се случат едновременно';
  @override
  String get labelItems => 'Елементи';
  @override
  String get labelInstantDownloadFormat => 'Мигновено изтегляне';
  @override
  String get labelInstantDownloadFormatDescription => 'Променете аудио формата за мигновени изтегляния';
  @override
  String get labelCurrent => 'Текущ';
  @override
  String get labelPauseWatchHistory => 'Паузиране на историята на гледане';
  @override
  String get labelPauseWatchHistoryDescription => 'Докато е паузиран, видеоклиповете не се записват в списъка с история на гледането';
  @override
  String get labelLockNavigationBar => 'Заключване на навигационната лента';
  @override
  String get labelLockNavigationBarDescription => 'Заключва лентата за навигация от скриване и автоматично показване при превъртане';
  @override
  String get labelPictureInPicture => 'Картина в Картината';
  @override
  String get labelPictureInPictureDescription => 'Автоматично влиза в режим PiP (Картина в Картината) при докосване на началния бутон, докато гледате видео';
  @override
  String get labelBackgroundPlaybackAlpha => 'Фоново възпроизвеждане (Алфа)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Превключване на функцията за фоново възпроизвеждане. Поради ограниченията на плъгина във фонов режим може да се възпроизвежда само текущият видеоклип';
  @override
  String get labelBlurBackgroundDescription => 'Добавя замъглен заден план с изображение';
  @override
  String get labelBlurIntensity => 'Интензивност на замъгляване';
  @override
  String get labelBlurIntensityDescription => 'Променете интензивността на замъгляването на задния план';
  @override
  String get labelBackdropOpacity => 'Прозрачност на фона';
  @override
  String get labelBackdropOpacityDescription => 'Променете прозрачността на цветния фон';
  @override
  String get labelArtworkShadowOpacity => 'Прозрачност на сянката на изображението';
  @override
  String get labelArtworkShadowOpacityDescription => 'Променете интензивността на сянката на изображението на музикалния плейър';
  @override
  String get labelArtworkShadowRadius => 'Радиус на сянката на изображението';
  @override
  String get labelArtworkShadowRadiusDescription => 'Променете радиуса на сянката на изображението на музикалния плейър';
  @override
  String get labelArtworkScaling => 'Мащабиране на изображението';
  @override
  String get labelArtworkScalingDescription => 'Мащабирайте изображението и фоновите изображения на музикалния плейър';
  @override
  String get labelBackgroundParallax => 'Фонов паралакс';
  @override
  String get labelBackgroundParallaxDescription =>  'Активиране/деактивиране на ефекта на паралакс на фоновото изображение';
  @override
  String get labelRestoreThumbnails => 'Възстановяване на миниатюрите';
  @override
  String get labelRestoreThumbnailsDescription => 'Принудително генериране на миниатюри и изображения';
  @override
  String get labelRestoringArtworks => 'Възстановяване на изображенията';
  @override
  String get labelRestoringArtworksDone => 'Възстановяването на изображенията завършено';
  @override
  String get labelHomeScreen => 'Начален екран';
  @override
  String get labelHomeScreenDescription => 'Променете началния екран по подразбиране, когато отворите приложението';
  @override
  String get labelDefaultMusicPage => 'Страница за музика по подразбиране';
  @override
  String get labelDefaultMusicPageDescription => 'Променете страницата по подразбиране със страницата с музика';
  @override
  String get labelAbout => 'Относно';
  @override
  String get labelConversionRequired => 'Изисква се преобразуване';
  @override
  String get labelConversionRequiredDescription =>  'Този формат не е съвместим с редактора на ID3 тагове. Приложението автоматично ще преобразува тази песен в AAC (m4a), за да реши този проблем.';
  @override
  String get labelPermissionRequired => 'Изисква се разрешение';
  @override
  String get labelPermissionRequiredDescription => 'Изисква се разрешение за достъп до всички файлове, за да може SongTube да редактира всяка песен на вашето устройство';
  @override
  String get labelApplying => 'Прилага се';
  @override
  String get labelConvertingDescription => 'Преобразуване на песента във формат AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Прилагане на нови тагове към песента';
  @override
  String get labelApply => 'Приложи';
  @override
  String get labelSongs => 'Песни';
  @override
  String get labelPlayAll => 'Пусни всички';
  @override
  String get labelPlaying => 'Възпроизвеждане';
  @override
  String get labelPages => 'Страници';
  @override
  String get labelMusicPlayer => 'Музикален плейър';
  @override
  String get labelClearWatchHistory => 'Изчисти историята на гледанията';
  @override
  String get labelClearWatchHistoryDescription =>  'Ще изтриете всички видеоклипове от историята си на гледания. Това действие не може да бъде отменено. Продължавате ли?';
  @override
  String get labelDelete => 'Изтрий';
  @override
  String get labelAppUpdate => 'Актуализация на приложението';
  @override
  String get labelWhatsNew => 'Какво ново';
  @override
  String get labelLater => 'По-късно';
  @override
  String get labelUpdate => 'Актуализирай';
  @override
  String get labelUnsubscribe => 'Отписване';
  @override
  String get labelAudioFeatures => 'Аудио функции';
  @override
  String get labelVolumeBoost => 'Увеличаване на силата на звука';
  @override
  String get labelNormalizeAudio => 'Нормализиране на аудио';
  @override
  String get labelSegmentedDownload => 'Сегментирано изтегляне';
  @override
  String get labelEnableSegmentedDownload => 'Активирайте сегментираното изтегляне';
  @override
  String get labelEnableSegmentedDownloadDescription => 'Това ще изтегли целия аудио файл и след това ще го раздели на различни активирани сегменти (или аудио записи) от списъка по-долу';
  @override
  String get labelCreateMusicPlaylist => 'Създайте музикален плейлист';
  @override
  String get labelCreateMusicPlaylistDescription => 'Създайте музикален плейлист от всички изтеглени и запазени аудио сегменти';
  @override
  String get labelApplyTags => 'Прилагане на тагове';
  @override
  String get labelApplyTagsDescription => 'Извличане на тагове от MusicBrainz за всички сегменти';
  @override
  String get labelLoading => 'Зареждане';
  @override
  String get labelMusicDownloadDescription => 'Изберете качество, преобразувайте и изтеглете само аудиото';
  @override
  String get labelVideoDownloadDescription =>  'Изберете видео качество от списъка и го изтеглете';
  @override
  String get labelInstantDescription => 'Започнете изтеглянето веднага като музика';
  @override
  String get labelInstant => 'Моментално';
  @override
  String get labelCurrentQuality => 'Текущо качество';
  @override
  String get labelFastStreamingOptions => 'Бързи опции за стриймване';
  @override
  String get labelStreamingOptions => 'Опции за стриймване';
  @override
  String get labelComments => 'Коментари';
  @override
  String get labelPinned => 'Закачено';
  @override
  String get labelLikedByAuthor => 'Харесано от автора';
  @override
  String get labelDescription => 'Описание';
  @override
  String get labelViews => 'Прегледи';
  @override
  String get labelPlayingNextIn => 'Започва след';
  @override
  String get labelPlayNow => 'Пусни сега';
  @override
  String get labelLoadingPlaylist => 'Зарежда се плейлист';
  @override
  String get labelPlaylistReachedTheEnd => 'Плейлистът достигна края';
  @override
  String get labelLiked => 'Харесано';
  @override
  String get labelLike => 'Харесай';
  @override
  String get labelVideoRemovedFromFavorites => 'Видеоклипът е премахнат от любими';
  @override
  String get labelVideoAddedToFavorites => 'Видеоклипът е добавен към любими';
  @override
  String get labelPopupMode => 'Режим на изскачащ прозорец';
  @override
  String get labelDownloaded => 'Изтеглено';
  @override
  String get labelShowPlaylist => 'Покажи плейлист';
  @override
  String get labelCreatePlaylist => 'Създай плейлист';
  @override
  String get labelAddVideoToPlaylist => 'Добави видео към плейлист';
  @override
  String get labelBackupDescription => 'Запазете всички локални данни в един файл, който може да бъде използван за възстановяване по-късно';
  @override
  String get labelBackupCreated => 'Резервното копие е създадено';
  @override
  String get labelBackupRestored => 'Резервното копие е възстановено';
  @override
  String get labelRestoreDescription => 'Възстановете всички данни от файл с резервно копие';
  @override
  String get labelChannelSuggestions => 'Предложения за канали';
  @override
  String get labelFetchingChannels => 'Извличане на канали';
  @override
  String get labelShareVideo => 'Споделено видео';
  @override
  String get labelShareDescription => 'Споделете с приятели или на други платформи';
  @override
  String get labelRemoveFromPlaylists => 'Премахни от плейлист';
  @override
  String get labelThisActionCannotBeUndone => 'Това действие не може да бъде отменено';
  @override
  String get labelAddVideoToPlaylistDescription => 'Добавете в съществуващ или нов видео плейлист';
  @override
  String get labelAddToPlaylists => 'Добави в плейлист';
  @override
  String get labelEditableOnceSaved => 'Редактируемо след запазване';
  @override
  String get labelPlaylistRemoved => 'Плейлистът е премахнат';
  @override
  String get labelPlaylistSaved => 'Плейлистът е запазен';
  @override
  String get labelRemoveFromFavorites => 'Премахни от любими';
  @override
  String get labelRemoveFromFavoritesDescription => 'Премахни това видео от любими';
  @override
  String get labelSaveToFavorites => 'Запази в любими';
  @override
  String get labelSaveToFavoritesDescription => 'Добави това видео към списъка с любими';
  @override
  String get labelSharePlaylist => 'Сподели плейлиста';
  @override
  String get labelRemoveThisVideoFromThisList => 'Премахни това видео от този списък';
  @override
  String get labelEqualizer => 'Еквалайзер';
  @override
  String get labelLoudnessEqualizationGain => 'Изравняване на силата на звука';
  @override
  String get labelSliders => 'Плъзгачи';
  @override
  String get labelSave => 'Запази';
  @override
  String get labelPlaylistName => 'Име на плейлиста';
  @override
  String get labelCreateVideoPlaylist => 'Създай видео плейлист';
  @override
  String get labelSearchFilters => 'Филтри за търсене';
  @override
  String get labelAddToPlaylistDescription => 'Добави към съществуващ или нов плейлист';
  @override
  String get labelShareSong => 'Сподели песента';
  @override
  String get labelShareSongDescription => 'Споделете с приятели или на други платформи';
  @override
  String get labelEditTagsDescription => 'Отворете редактора на ID3 тагове и изображения';
  @override
  String get labelContains => 'Съдържа';
  @override
  String get labelPlaybackSpeed => 'Скорост на възпроизвеждане';
}