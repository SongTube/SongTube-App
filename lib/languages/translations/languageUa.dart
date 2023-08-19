import 'package:songtube/languages/languages.dart';

class LanguageUa extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Вітаємо в";
  @override
  String get labelStart => "Пуск";
  @override
  String get labelSkip => "Пропустити";
  @override
  String get labelNext => "Далі";
  @override
  String get labelExternalAccessJustification =>
    "Потрібен доступ до Зовнішнього Сховища, щоб зберігати всі " +
    "ваші Відео та Музику";
  @override
  String get labelAppCustomization => "Персоналізація";
  @override
  String get labelSelectPreferred => "Вибрати бажане";
  @override
  String get labelConfigReady => "Налаштовано";
  @override
  String get labelIntroductionIsOver => "Ознайомлено";
  @override
  String get labelEnjoy => "Насолоджуйтесь";
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
  String get labelMore => "Ще";

  // Home Screen
  @override
  String get labelQuickSearch => "Швидкий пошук...";
  @override
  String get labelTagsEditor => "Редактор тегів";
  @override
  String get labelEditArtwork => "Редагувати\nобкладинку";
  @override
  String get labelDownloadAll => "Завантажити все";
  @override 
  String get labelLoadingVideos => "Відео вантажаться...";
  @override
  String get labelHomePage => "Головна";
  @override
  String get labelTrending => "Тренди";
  @override
  String get labelFavorites => "Вибране";
  @override
  String get labelWatchLater => "Переглянути пізніше";

  // Video Options Menu
  @override
  String get labelCopyLink => "Скопіювати посилання";
  @override
  String get labelAddToFavorites => "Додати у Вибране";
  @override
  String get labelAddToWatchLater => "Додати в Переглянути пізніше";
  @override
  String get labelAddToPlaylist => "Додати до списку відтворення";

  // Downloads Screen
  @override
  String get labelQueued => "В черзі";
  @override
  String get labelDownloading => "Завантажується";
  @override
  String get labelConverting => "Конвертується";
  @override
  String get labelCancelled => "Скасовано";
  @override
  String get labelCompleted => "Завершено";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "У черзі на завантаження";
  @override
  String get labelDownloadAcesssDenied => "Відмовлено в доступі";
  @override
  String get labelClearingExistingMetadata => "Очищення існуючих метаданих...";
  @override
  String get labelWrittingTagsAndArtwork => "Записуються теги й обкладинка...";
  @override
  String get labelSavingFile => "Збереження файлу...";
  @override
  String get labelAndroid11FixNeeded => "Помилка, потрібно Android 11 Виправлення, перевірте Налаштування";
  @override
  String get labelErrorSavingDownload => "Не вдалося зберегти завантаження, перевірте дозволи";
  @override
  String get labelDownloadingVideo => "Відео завантажується...";
  @override
  String get labelDownloadingAudio => "Аудіо завантажується...";
  @override
  String get labelGettingAudioStream => "Отримання аудіо потоку...";
  @override
  String get labelAudioNoDataRecieved => "Не вдалось отримати аудіопотік";
  @override
  String get labelDownloadStarting => "Починається завантаження...";
  @override
  String get labelDownloadCancelled => "Завантаження скасовано";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Конвертація не вдалась";
  @override
  String get labelPatchingAudio => "Виправлення аудіо...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Увімкнути конвертацію аудіо";
  @override
  String get labelGainControls => "Керування підсиленням";
  @override
  String get labelVolume => "Гучність";
  @override
  String get labelBassGain => "Посилення низьких частот";
  @override
  String get labelTrebleGain => "Посилення високих частот";
  @override
  String get labelSelectVideo => "Вибір Відео";
  @override
  String get labelSelectAudio => "Вибір Аудіо";
  @override
  String get labelGlobalParameters => "Глобальні параметри";

  // Media Screen
  @override
  String get labelMusic => "Музика";
  @override
  String get labelVideos => "Відео";
  @override
  String get labelNoMediaYet => "Поки що нема медіа";
  @override
  String get labelNoMediaYetJustification => "Всі ваші медіа " +
    "показуватимуться тут";
  @override
  String get labelSearchMedia => "Пошук медіа...";
  @override
  String get labelDeleteSong => "Видалити пісню";
  @override
  String get labelNoPermissionJustification => "Переглядайте свої медіа," + "\n" +
    "надавши дозвіл на зберігання";
  @override
  String get labelGettingYourMedia => "Отримання ваших медіа...";
  @override
  String get labelEditTags => "Редагувати теги";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "YouTube пошук...";

  // More Screen
  @override
  String get labelSettings => "Налаштування";
  @override
  String get labelDonate => "Пожертвувати";
  @override
  String get labelLicenses => "Ліцензії";
  @override
  String get labelChooseColor => "Вибрати колір";
  @override
  String get labelTheme => "Тема";
  @override
  String get labelUseSystemTheme => "Використовувати системну тему";
  @override
  String get labelUseSystemThemeJustification =>
    "Увімкнення/вимкнення теми автоматично";
  @override
  String get labelEnableDarkTheme => "Увімкнути темну тему";
  @override
  String get labelEnableDarkThemeJustification =>
    "Використовувати темну тему";
  @override
  String get labelEnableBlackTheme => "Увімкнути чорну тему";
  @override
  String get labelEnableBlackThemeJustification =>
    "Увімкнути чисто чорну тему";
  @override
  String get labelAccentColor => "Колір акценту";
  @override
  String get labelAccentColorJustification => "Налаштувати колір акценту";
  @override
  String get labelAudioFolder => "Тека аудіо";
  @override
  String get labelAudioFolderJustification => "Оберіть теку для " +
    "завантажень Аудіо";
  @override
  String get labelVideoFolder => "Тека відео";
  @override
  String get labelVideoFolderJustification => "Оберіть теку для " +
    "завантажень Відео";
  @override
  String get labelAlbumFolder => "Тека альбому";
  @override
  String get labelAlbumFolderJustification => "Створити теку для кожного альбому пісень";
  @override
  String get labelDeleteCache => "Видалити кеш";
  @override
  String get labelDeleteCacheJustification => "Очистити кеш SongTube";
  @override
  String get labelAndroid11Fix => "Android 11 Виправлення";
  @override
  String get labelAndroid11FixJustification => "Виправлення проблем завантаження на " +
    "Android 10 та 11";
  @override
  String get labelBackup => "Резервування";
  @override
  String get labelBackupJustification => "Резервування вашої бібліотеки медіа";
  @override
  String get labelRestore => "Відновлення";
  @override
  String get labelRestoreJustification => "Відновлення вашої бібліотеки медіа";
  @override
  String get labelBackupLibraryEmpty => "Ваша Бібліотека порожня";
  @override
  String get labelBackupCompleted => "Резервування завершено";
  @override
  String get labelRestoreNotFound => "Відновлення Не знайдено";
  @override
  String get labelRestoreCompleted => "Відновлення завершено";
  @override
  String get labelCacheIsEmpty => "Кеш порожній";
  @override
  String get labelYouAreAboutToClear => "Буде очищено";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Заголовок";
  @override
  String get labelEditorArtist => "Виконавець";
  @override
  String get labelEditorGenre => "Жанр";
  @override
  String get labelEditorDisc => "Диск";
  @override
  String get labelEditorTrack => "Доріжка";
  @override
  String get labelEditorDate => "Дата";
  @override
  String get labelEditorAlbum => "Альбом";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Виявлено Android 10 чи 11";
  @override
  String get labelAndroid11DetectedJustification => "Щоб забезпечити правильне " +
    "функціонування завантаження цим додатком, на Android 10 і 11, може знадобитися " +
    "дозвіл Доступ до всіх файлів, який буде тимчасово і не обов'язково " +
    "на майбутніх оновленнях. Ви також можете застосувати це виправлення в Налаштуваннях.";

  // Music Player
  @override
  String get labelPlayerSettings => "Налаштування плеєра";
  @override
  String get labelExpandArtwork => "Розгорнути обкладинку";
  @override
  String get labelArtworkRoundedCorners => "Закруглити кути обкладинки";
  @override
  String get labelPlayingFrom => "Відтворення з";
  @override
  String get labelBlurBackground => "Розмити фон";

  // Video Page
  @override
  String get labelTags => "Теги";
  @override
  String get labelRelated => "Пов'язане";
  @override
  String get labelAutoPlay => "Автовідтворення";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Формат аудіо несумісний";
  @override
  String get labelNotSpecified => "Не вказано";
  @override
  String get labelPerformAutomaticTagging => 
    "Виконати автоматичне тегування";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Вибрати теги з MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Вибрати обкладинку з пристрою";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Приєднуйтесь до Телеграм каналу!";
  @override
  String get labelJoinTelegramJustification =>
    "Вам подобається SongTube? Будь ласка, приєднуйтесь до Телеграм каналу! Ви знайдете " +
    "Оновлення, Інформацію, Розробку, посилання на групу та інші соціальні посилання." +
    "\n\n" +
    "У випадку, якщо у вас є проблема або чудова рекомендація, " +
    "будь ласка, приєднуйтесь до групи з каналу та напишіть це! Але майте на увазі " +
    "ви можете розмовляти лише англійською, дякую!";
  @override
  String get labelRemindLater => "Нагадати пізніше";

  // Common Words (One word labels)
  @override
  String get labelExit => "Вийти";
  @override
  String get labelSystem => "Система";
  @override
  String get labelChannel => "Канал";
  @override
  String get labelShare => "Поділитися";
  @override
  String get labelAudio => "Аудіо";
  @override
  String get labelVideo => "Відео";
  @override
  String get labelDownload => "Завантажити";
  @override
  String get labelBest => "Найкраще";
  @override
  String get labelPlaylist => "Список відтворення";
  @override
  String get labelVersion => "Версія";
  @override
  String get labelLanguage => "Мова";
  @override
  String get labelGrant => "Надати";
  @override
  String get labelAllow => "Дозволити";
  @override
  String get labelAccess => "Доступ";
  @override
  String get labelEmpty => "Порожньо";
  @override
  String get labelCalculating => "Обчислення";
  @override
  String get labelCleaning => "Очищення";
  @override
  String get labelCancel => "Скасувати";
  @override
  String get labelGeneral => "Загальне";
  @override
  String get labelRemove => "Вилучити";
  @override
  String get labelJoin => "Приєднатися";
  @override
  String get labelNo => "Ні";
  @override
  String get labelLibrary => "Бібліотека";
  @override
  String get labelCreate => "Створити";
  @override
  String get labelPlaylists => "Списки відтворення";
  @override
  String get labelQuality => "Якість";
  @override
  String get labelSubscribe => "Підписатися";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Немає вибраних відео';
  @override
  String get labelNoFavoriteVideosDescription => 'Шукайте відео та зберігайте їх у вибраному. Вони з\'являтимуться тут';
  @override
  String get labelNoSubscriptions => 'Немає підписок';
  @override
  String get labelNoSubscriptionsDescription => 'Натисніть кнопку вище, щоб переглянути запропоновані канали!';
  @override
  String get labelNoPlaylists => 'Немає списків відтворення';
  @override
  String get labelNoPlaylistsDescription => 'Шукайте відео чи списки відтворення та зберігайте їх. Вони з\'являтимуться тут';
  @override
  String get labelSearch => 'Шукати';
  @override
  String get labelSubscriptions => 'Підписки';
  @override
  String get labelNoDownloadsCanceled => 'Нема скасованих завантажень';
  @override
  String get labelNoDownloadsCanceledDescription => 'Добре! Але якщо ви скасуєте або щось піде неправильно із завантаженням, ви можете перевірити тут';
  @override
  String get labelNoDownloadsYet => 'Поки що немає завантажень';
  @override
  String get labelNoDownloadsYetDescription => 'Перейдіть на головну, шукайте щось для завантаження або очікуйте чергу!';
  @override
  String get labelYourQueueIsEmpty => 'Ваша черга порожня';
  @override
  String get labelYourQueueIsEmptyDescription => 'Перейдіть на головну та шукайте щось для завантаження!';
  @override
  String get labelQueue => 'Черга';
  @override
  String get labelSearchDownloads => 'Пошук Завантажень';
  @override
  String get labelWatchHistory => 'Історія перегляду';
  @override
  String get labelWatchHistoryDescription => 'Подивитися, які відео ви переглянули';
  @override
  String get labelBackupAndRestore => 'Резервування та Відновлення';
  @override
  String get labelBackupAndRestoreDescription => 'Зберегти чи відновити всі ваші локальні дані';
  @override
  String get labelSongtubeLink => 'SongTube Посилання';
  @override
  String get labelSongtubeLinkDescription => 'Дозволити розширенню SongTube браузера виявляти цей пристрій, утримуйте, щоб дізнатися більше';
  @override
  String get labelSupportDevelopment => 'Підтримати розробку';
  @override
  String get labelSocialLinks => 'Соціальні посилання';
  @override
  String get labelSeeMore => 'Перегляд';
  @override
  String get labelMostPlayed => 'Найбільш відтворювані';
  @override
  String get labelNoPlaylistsYet => 'Поки що нема списків відтворення';
  @override
  String get labelNoPlaylistsYetDescription => 'Ви можете створити список відтворення з своїх нещодавніх, музики, альбомів або виконавців';
  @override
  String get labelNoSearchResults => 'Немає результатів пошуку';
  @override
  String get labelSongResults => 'Результати пісень';
  @override
  String get labelAlbumResults => 'Результати альбомів';
  @override
  String get labelArtistResults => 'Результати виконавців';
  @override
  String get labelSearchAnything => 'Шукати будь-що';
  @override
  String get labelRecents => 'Нещодавні';
  @override
  String get labelFetchingSongs => 'Отримання пісень';
  @override
  String get labelPleaseWaitAMoment => 'Будь ласка, зачекайте трішки';
  @override
  String get labelWeAreDone => 'Завершено';
  @override
  String get labelEnjoyTheApp => 'Насолоджуйтесь\nдодатком';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube повернувся з чистішим виглядом і набором функцій, розважайтесь зі своєю музикою!';
  @override
  String get labelLetsGo => 'Вперед';
  @override
  String get labelPleaseWait => 'Будь ласка, зачекайте';
  @override
  String get labelPoweredBy => 'За підтримки';
  @override
  String get labelGetStarted => 'Почати';
  @override
  String get labelAllowUsToHave => 'Дозвольте отримати';
  @override
  String get labelStorageRead => 'Читання\nСховища';
  @override
  String get labelStorageReadDescription => 'Відсканується ваша музика, витягнуться обкладинки високої якості та персоналізується ваша музика';
  @override
  String get labelContinue => 'Продовжити';
  @override
  String get labelAllowStorageRead => 'Дозволити читання сховища';
  @override
  String get labelSelectYourPreferred => 'Виберіть бажане';
  @override
  String get labelLight => 'Світло';
  @override
  String get labelDark => 'Темно';
  @override
  String get labelSimultaneousDownloads => 'Одночасних завантажень';
  @override
  String get labelSimultaneousDownloadsDescription => 'Визначте, скільки завантажень може відбуватися одночасно';
  @override
  String get labelItems => 'Елементи';
  @override
  String get labelInstantDownloadFormat => 'Миттєве завантаження';
  @override
  String get labelInstantDownloadFormatDescription => 'Зміна формату аудіо для миттєвих завантажень';
  @override
  String get labelCurrent => 'Поточна';
  @override
  String get labelPauseWatchHistory => 'Призупинити історію перегляду';
  @override
  String get labelPauseWatchHistoryDescription => 'Якщо призупинено, відео не зберігаються до списку історії перегляду';
  @override
  String get labelLockNavigationBar => 'Заблокувати панель навігації';
  @override
  String get labelLockNavigationBarDescription => 'Блокування навігаційної панелі від приховування та показування автоматично під час прокрутки';
  @override
  String get labelPictureInPicture => 'Картинка в картинці';
  @override
  String get labelPictureInPictureDescription => 'Автоматичний перехід у режим PiP після натискання кнопки Додому під час перегляду відео';
  @override
  String get labelBackgroundPlaybackAlpha => 'Фонове відтворення (Альфа)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Перемикання функції фонового відтворення. Через обмеження плагіна, у фоні може відтворюватися лише поточне відео';
  @override
  String get labelBlurBackgroundDescription => 'Додавання розмитого фону обкладинки';
  @override
  String get labelBlurIntensity => 'Інтенсивність розмиття';
  @override
  String get labelBlurIntensityDescription => 'Зміна інтенсивності розмиття фону обкладинки';
  @override
  String get labelBackdropOpacity => 'Непрозорість тла';
  @override
  String get labelBackdropOpacityDescription => 'Зміна непрозорості кольорового тла';
  @override
  String get labelArtworkShadowOpacity => 'Непрозорість тіні обкладинки';
  @override
  String get labelArtworkShadowOpacityDescription => 'Зміна інтенсивності тіні обкладинки музичного плеєра';
  @override
  String get labelArtworkShadowRadius => 'Радіус тіні обкладинки';
  @override
  String get labelArtworkShadowRadiusDescription => 'Зміна радіуса тіні обкладинки музичного плеєра';
  @override
  String get labelArtworkScaling => 'Масштабування обкладинки';
  @override
  String get labelArtworkScalingDescription => 'Масштабування обкладинки та фонових зображень музичного плеєра';
  @override
  String get labelBackgroundParallax => 'Паралакс фону';
  @override
  String get labelBackgroundParallaxDescription =>  'Ввімкнути/вимкнути ефект паралаксу фонового зображення';
  @override
  String get labelRestoreThumbnails => 'Відновити мініатюри';
  @override
  String get labelRestoreThumbnailsDescription => 'Примусова генерація мініатюр і обкладинок';
  @override
  String get labelRestoringArtworks => 'Відновлення обкладинок';
  @override
  String get labelRestoringArtworksDone => 'Виконано відновлення обкладинок';
  @override
  String get labelHomeScreen => 'Основний екран';
  @override
  String get labelHomeScreenDescription => 'Зміна цільового екрану при відкритті додатку';
  @override
  String get labelDefaultMusicPage => 'Типова сторінка Музики';
  @override
  String get labelDefaultMusicPageDescription => 'Зміна типової сторінки Музики';
  @override
  String get labelAbout => 'Про додаток';
  @override
  String get labelConversionRequired => 'Необхідна конвертація';
  @override
  String get labelConversionRequiredDescription =>  'Цей формат пісні несумісний з редактором тегів ID3. Програма автоматично перетворить цю пісню на AAC (m4a), щоб вирішити цю проблему.';
  @override
  String get labelPermissionRequired => 'Необхідний дозвіл';
  @override
  String get labelPermissionRequiredDescription => 'Для редагування будь-якої пісні на вашому пристрої SongTube потрібен дозвіл Доступ до всіх файлів';
  @override
  String get labelApplying => 'Застосування';
  @override
  String get labelConvertingDescription => 'Перекодування цієї пісні у формат AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Застосування нових тегів до цієї пісні';
  @override
  String get labelApply => 'Застосувати';
  @override
  String get labelSongs => 'Пісні';
  @override
  String get labelPlayAll => 'Відтворити всі';
  @override
  String get labelPlaying => 'Відтворення';
  @override
  String get labelPages => 'Сторінки';
  @override
  String get labelMusicPlayer => 'Музичний плеєр';
  @override
  String get labelClearWatchHistory => 'Очистити історію перегляду';
  @override
  String get labelClearWatchHistoryDescription =>  'Ви збираєтесь видалити всі свої відео з історії переглядів, цю дію неможливо скасувати, продовжувати?';
  @override
  String get labelDelete => 'Видалити';
  @override
  String get labelAppUpdate => 'Оновлення додатку';
  @override
  String get labelWhatsNew => 'Що нового';
  @override
  String get labelLater => 'Пізніше';
  @override
  String get labelUpdate => 'Оновити';
  @override
  String get labelUnsubscribe => 'Відписатися';
  @override
  String get labelAudioFeatures => 'Особливості аудіо';
  @override
  String get labelVolumeBoost => 'Посилення гучності';
  @override
  String get labelNormalizeAudio => 'Нормалізація звуку';
  @override
  String get labelSegmentedDownload => 'Сегментоване завантаження';
  @override
  String get labelEnableSegmentedDownload => 'Увімкнути сегментоване завантаження';
  @override
  String get labelEnableSegmentedDownloadDescription => 'Це завантаження цілого аудіофайлу, потім розділення його на різні включені сегменти (або аудіодоріжки) зі списку нижче';
  @override
  String get labelCreateMusicPlaylist => 'Створити музичний плейлист';
  @override
  String get labelCreateMusicPlaylistDescription => 'Створити музичний плейлист з усіх завантажених і збережених аудіофрагментів';
  @override
  String get labelApplyTags => 'Застосувати теги';
  @override
  String get labelApplyTagsDescription => 'Витягнути теги з MusicBrainz для всіх сегментів';
  @override
  String get labelLoading => 'Вантажиться';
  @override
  String get labelMusicDownloadDescription => 'Вибрати якість, конвертувати та завантажити тільки аудіо';
  @override
  String get labelVideoDownloadDescription =>  'Обрати якість відео зі списку та завантажити його';
  @override
  String get labelInstantDescription => 'Миттєво завантажити як музику';
  @override
  String get labelInstant => 'Миттєво';
  @override
  String get labelCurrentQuality => 'Поточна якість';
  @override
  String get labelFastStreamingOptions => 'Параметри швидкої трансляції';
  @override
  String get labelStreamingOptions => 'Параметри трансляції';
  @override
  String get labelComments => 'Коментарі';
  @override
  String get labelPinned => 'Закріплено';
  @override
  String get labelLikedByAuthor => 'Вподобано автором';
  @override
  String get labelDescription => 'Опис';
  @override
  String get labelViews => 'Переглядів';
  @override
  String get labelPlayingNextIn => 'Відтворення наступного за';
  @override
  String get labelPlayNow => 'Відтворити зараз';
  @override
  String get labelLoadingPlaylist => 'Вантаження списку відтворення';
  @override
  String get labelPlaylistReachedTheEnd => 'Список відтворення досягнув кінця';
  @override
  String get labelLiked => 'Обрати';
  @override
  String get labelLike => 'Обрано';
  @override
  String get labelVideoRemovedFromFavorites => 'Відео вилучено з вибраного';
  @override
  String get labelVideoAddedToFavorites => 'Відео додано до вибраного';
  @override
  String get labelPopupMode => 'Режим спливаючого вікна';
  @override
  String get labelDownloaded => 'Завантажено';
  @override
  String get labelShowPlaylist => 'Показати плейлист';
  @override
  String get labelCreatePlaylist => 'Створити плейлист';
  @override
  String get labelAddVideoToPlaylist => 'Додати відео до плейлиста';
  @override
  String get labelBackupDescription => 'Резервувати всі локальні дані в один файл, який можна використати для подальшого відновлення';
  @override
  String get labelBackupCreated => 'Резерв створено';
  @override
  String get labelBackupRestored => 'Резерв відновлено';
  @override
  String get labelRestoreDescription => 'Відновити всі дані з резервного файлу';
  @override
  String get labelChannelSuggestions => 'Запропоновані канали';
  @override
  String get labelFetchingChannels => 'Отримання каналів';
  @override
  String get labelShareVideo => 'Поділитися відео';
  @override
  String get labelShareDescription => 'Поділіться з друзями або іншими платформами';
  @override
  String get labelRemoveFromPlaylists => 'Вилучити список відтворення';
  @override
  String get labelThisActionCannotBeUndone => 'Цю дію неможливо скасувати';
  @override
  String get labelAddVideoToPlaylistDescription => 'Додати відео до існуючого або нового списку відтворення';
  @override
  String get labelAddToPlaylists => 'Додати до плейлистів';
  @override
  String get labelEditableOnceSaved => 'Редагування після збереження';
  @override
  String get labelPlaylistRemoved => 'Вилучено список відтворення';
  @override
  String get labelPlaylistSaved => 'Збережено список відтворення';
  @override
  String get labelRemoveFromFavorites => 'Вилучити з вибраного';
  @override
  String get labelRemoveFromFavoritesDescription => 'Вилучити це відео з вибраного';
  @override
  String get labelSaveToFavorites => 'Зберегти до вибраного';
  @override
  String get labelSaveToFavoritesDescription => 'Додати відео до списку вибраних';
  @override
  String get labelSharePlaylist => 'Поділитися плейлистом';
  @override
  String get labelRemoveThisVideoFromThisList => 'Вилучити це відео зі списку';
  @override
  String get labelEqualizer => 'Еквалайзер';
  @override
  String get labelLoudnessEqualizationGain => 'Посилення еквалайзера гучності';
  @override
  String get labelSliders => 'Повзунки';
  @override
  String get labelSave => 'Зберегти';
  @override
  String get labelPlaylistName => 'Назва списку відтворення';
  @override
  String get labelCreateVideoPlaylist => 'Створити плейлист відео';
  @override
  String get labelSearchFilters => 'Фільтри пошуку';
  @override
  String get labelAddToPlaylistDescription => 'Додати до існуючого або нового плейлиста';
  @override
  String get labelShareSong => 'Поділитися піснею';
  @override
  String get labelShareSongDescription => 'Поділіться з друзями або іншими платформами';
  @override
  String get labelEditTagsDescription => 'Відкрити редактор тегів ID3 й обкладинки';
  @override
  String get labelContains => 'Вмістити';
  @override
  String get labelPlaybackSpeed => 'Playback speed';
}
