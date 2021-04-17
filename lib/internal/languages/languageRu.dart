import 'package:songtube/internal/languages.dart';

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
}