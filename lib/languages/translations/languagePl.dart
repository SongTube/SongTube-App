import 'package:songtube/languages/languages.dart';

class LanguagePl extends Languages {
  // Introduction Screens
  @override
  String get labelAppWelcome => "Witaj w";
  @override
  String get labelStart => "Start";
  @override
  String get labelSkip => "Pomiń";
  @override
  String get labelNext => "Dalej";
  @override
  String get labelExternalAccessJustification =>
      "Potrzebujemy dostępu do zewnętrznej pamięci aby zapisać wszystkie" +
      "twoje filmy i utowry";
  @override
  String get labelAppCustomization => "";
  @override
  String get labelSelectPreferred => "Wybierz preferowany";
  @override
  String get labelConfigReady => "Konfiguracja gotowa";
  @override
  String get labelIntroductionIsOver => "Koniec wprowadzenia";
  @override
  String get labelEnjoy => "Miłego używania";
  @override
  String get labelGoHome => "Idź do strony głównej";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Główna";
  @override
  String get labelDownloads => "Pobrane";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Więcej";

  // Home Screen
  @override
  String get labelQuickSearch => "Szybkie wyszukiwanie...";
  @override
  String get labelTagsEditor => "Edytor tagów";
  @override
  String get labelEditArtwork => "Edytuj\nUtwór";
  @override
  String get labelDownloadAll => "Pobierz wszystkie";
  @override
  String get labelLoadingVideos => "Ładowanie filmów...";
  @override
  String get labelHomePage => "Strona główna";
  @override
  String get labelTrending => "Trendujące";
  @override
  String get labelFavorites => "Ulubone";
  @override
  String get labelWatchLater => "Obejrzyj później";

  // Video Options Menu
  @override
  String get labelCopyLink => "Kopiuj link";
  @override
  String get labelAddToFavorites => "Add to Favorites";
  @override
  String get labelAddToWatchLater => "Add to Watch Later";
  @override
  String get labelAddToPlaylist => "Add to Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "Zakolejkowane";
  @override
  String get labelDownloading => "Pobierane";
  @override
  String get labelConverting => "Konwertowane";
  @override
  String get labelCancelled => "Anulowane";
  @override
  String get labelCompleted => "Zakończone";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Pobierz zakolejkowane";
  @override
  String get labelDownloadAcesssDenied => "Odmowa dostępu";
  @override
  String get labelClearingExistingMetadata => "Czyszczenie istniejących metadanych";
  @override
  String get labelWrittingTagsAndArtwork => "Zapisywanie tagów i utworu...";
  @override
  String get labelSavingFile => "Zapisywanie pliku...";
  @override
  String get labelAndroid11FixNeeded =>
      "Błąd, naprawa dla Android 11 wymagana, sprawdź ustawienia";
  @override
  String get labelErrorSavingDownload =>
      "Nie można zapisać twoich pobranych, sprawdź uprwawnienia";
  @override
  String get labelDownloadingVideo => "Pobieranie filmu...";
  @override
  String get labelDownloadingAudio => "Pobieranie dźwięku";
  @override
  String get labelGettingAudioStream => "Ładowanie strumienia dźwięku...";
  @override
  String get labelAudioNoDataRecieved => "Nie można uzyskać strumienia dźwięku";
  @override
  String get labelDownloadStarting => "Zaczynanie pobierania...";
  @override
  String get labelDownloadCancelled => "Pobieranie anulowane";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Konwertowanie nie powiodło się";
  @override
  String get labelPatchingAudio => "Patchowanie dźwięku";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Włącz Konwertowane audio";
  @override
  String get labelGainControls => "Uzyskaj kontrolę";
  @override
  String get labelVolume => "Głośność";
  @override
  String get labelBassGain => "Wzmocnienie basów";
  @override
  String get labelTrebleGain => "Wzmocnienie wysokich tonów";
  @override
  String get labelSelectVideo => "Wybierz film";
  @override
  String get labelSelectAudio => "Wybierz dźwięk";
  @override
  String get labelGlobalParameters => "Globalne parametry";

  // Media Screen
  @override
  String get labelMusic => "Muzyka";
  @override
  String get labelVideos => "Filmy";
  @override
  String get labelNoMediaYet => "Brak mediów";
  @override
  String get labelNoMediaYetJustification =>
      "Wszystkie twoje media" + "będą pokazane tutaj";
  @override
  String get labelSearchMedia => "Wyszukaj media...";
  @override
  String get labelDeleteSong => "Usuń utwór";
  @override
  String get labelNoPermissionJustification =>
      "Zobacz swoje multimedia przez" + "\n" + "Uzyskanie dostępu do pamięci";
  @override
  String get labelGettingYourMedia => "Ładowanie twoich mediów";
  @override
  String get labelEditTags => "Edytuj tagi";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Szukaj w YouTube";

  // More Screen
  @override
  String get labelSettings => "Ustawienia";
  @override
  String get labelDonate => "Dotacje";
  @override
  String get labelLicenses => "Licencje";
  @override
  String get labelChooseColor => "Wybierz kolor";
  @override
  String get labelTheme => "Motyw";
  @override
  String get labelUseSystemTheme => "Uyj motywu systemowego";
  @override
  String get labelUseSystemThemeJustification =>
      "Włącz/Wyłącz automatyczny motyw";
  @override
  String get labelEnableDarkTheme => "Włącz ciemny motyw";
  @override
  String get labelEnableDarkThemeJustification => "Używaj domyślnie ciemnego motywu";
  @override
  String get labelEnableBlackTheme => "Włącz czarny motywu";
  @override
  String get labelEnableBlackThemeJustification => "Włącz motyw głębokiej czerni";
  @override
  String get labelAccentColor => "Kolor akcentu";
  @override
  String get labelAccentColorJustification => "Dostosuj swój kolor akcentu";
  @override
  String get labelAudioFolder => "Folder dźwięku";
  @override
  String get labelAudioFolderJustification =>
      "Wybierz folder na " + "Pobieranie dźwięku";
  @override
  String get labelVideoFolder => "Folder filmów";
  @override
  String get labelVideoFolderJustification =>
      "Wybierz folder na " + "Pobieranie filmów";
  @override
  String get labelAlbumFolder => "Folder Albumów";
  @override
  String get labelAlbumFolderJustification =>
      "Twórz folder dla każdego albumu";
  @override
  String get labelDeleteCache => "Usuń cache";
  @override
  String get labelDeleteCacheJustification => "Wyczyść cache SongTube";
  @override
  String get labelAndroid11Fix => "Naprawa dla Android 11";
  @override
  String get labelAndroid11FixJustification =>
      "Naprawia błędy pobierania na " + "Androidzie 10 i 11";
  @override
  String get labelBackup => "Kopia zapasowa";
  @override
  String get labelBackupJustification => "Twórz kopię zapasową twojej biblioteki mediów";
  @override
  String get labelRestore => "Przywróć";
  @override
  String get labelRestoreJustification => "Przywróc swoją bibliotekę mediów";
  @override
  String get labelBackupLibraryEmpty => "Twoja biblioteka jest pusta";
  @override
  String get labelBackupCompleted => "Kopia zapasowa jest gotowa";
  @override
  String get labelRestoreNotFound => "Nie znaleziono kopii do przywrócenia";
  @override
  String get labelRestoreCompleted => "Przywracaie zakończone";
  @override
  String get labelCacheIsEmpty => "Cache jest pusty";
  @override
  String get labelYouAreAboutToClear => "Zaraz wyczyścisz";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Tytuł";
  @override
  String get labelEditorArtist => "Artysta";
  @override
  String get labelEditorGenre => "Gatunek";
  @override
  String get labelEditorDisc => "Płyta";
  @override
  String get labelEditorTrack => "Utwór";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 lub 11 wykryty";
  @override
  String get labelAndroid11DetectedJustification =>
      "Aby zapewnić poprawne" +
      "funkcjonowanie pobierania w tej aplikacji, na Androidzie 10 i 11, dostęp do wszystkich " +
      "Plików jest wymagany, jest to rozwiązanie tymczasowe i nie będzie potrzebne" +
      "w przyszłych aktualizacjach. Możesz także włączyć tą opcję w ustawieniach";

  // Music Player
  @override
  String get labelPlayerSettings => "Ustawienia odtwarzacza";
  @override
  String get labelExpandArtwork => "Rozszerze okładkę";
  @override
  String get labelArtworkRoundedCorners => "Zaokrąglone rogi okładki";
  @override
  String get labelPlayingFrom => "Odtwarzenie z";
  @override
  String get labelBlurBackground => "Rozmyj tło";

  // Video Page
  @override
  String get labelTags => "Tagi";
  @override
  String get labelRelated => "Powiązane";
  @override
  String get labelAutoPlay => "Automatyczne odtwarzanie";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible => "Niekompatybilny format dźwięku";
  @override
  String get labelNotSpecified => "Nie podano";
  @override
  String get labelPerformAutomaticTagging => "Przeprowadź automatyczne tagowanie";
  @override
  String get labelSelectTagsfromMusicBrainz => "Wybierz tagi z MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice => "Wybierz okładkę z urządzenia";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Dołącz do kanały Telegram";
  @override
  String get labelJoinTelegramJustification =>
      "Podoba Ci się SongTube? Dołącz do kanału Telegram! Znajdziesz tam " +
      "Aktualizacje, informacje, rozwój, linki do grup i inne linki społecznościowe." +
      "\n\n" +
      "Jeśli masz jakiś problem lub rekomendację, " +
      "Dołącz do grupy z kanału i zapisz to! Ale pamiętaj" +
      "Możesz mówić tylko po Angielsku, dziękujemy!";
  @override
  String get labelRemindLater => "Przypomnij później";

  // Common Words (One word labels)
  @override
  String get labelExit => "Wyjdź";
  @override
  String get labelSystem => "System";
  @override
  String get labelChannel => "Kanał";
  @override
  String get labelShare => "Udostępnij";
  @override
  String get labelAudio => "Dźwięk";
  @override
  String get labelVideo => "Film";
  @override
  String get labelDownload => "Pobierz";
  @override
  String get labelBest => "Najlepsze";
  @override
  String get labelPlaylist => "Playlista";
  @override
  String get labelVersion => "Wersja";
  @override
  String get labelLanguage => "Język";
  @override
  String get labelGrant => "Przyznaj";
  @override
  String get labelAllow => "Pozwól";
  @override
  String get labelAccess => "Dostęp";
  @override
  String get labelEmpty => "Pusty";
  @override
  String get labelCalculating => "Obliczanie";
  @override
  String get labelCleaning => "Czyszczenie";
  @override
  String get labelCancel => "Anuluj";
  @override
  String get labelGeneral => "Ogólne";
  @override
  String get labelRemove => "Usuń";
  @override
  String get labelJoin => "Dołącz";
  @override
  String get labelNo => "Nie";
  @override
  String get labelLibrary => "Library";
  @override
  String get labelCreate => "Stwórz";
  @override
  String get labelPlaylists => "Playlisty";
  @override
  String get labelQuality => "Jakość";
  @override
  String get labelSubscribe => "Subskrybuj";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Brak ulubionych filmów';
  @override
  String get labelNoFavoriteVideosDescription =>
      'Szukaj filmów i zapisuj je jako ulubione. Pojawią się tutaj';
  @override
  String get labelNoSubscriptions => 'Brak subskrybcji';
  @override
  String get labelNoSubscriptionsDescription =>
      'Naciśnij przycisk aby pokazać sugerowane kanały!';
  @override
  String get labelNoPlaylists => 'Brak playlist';
  @override
  String get labelNoPlaylistsDescription =>
      'Szukaj filmów i playlist i zapisuj je. Pojawią się tutaj';
  @override
  String get labelSearch => 'Szukaj';
  @override
  String get labelSubscriptions => 'Subskrybcje';
  @override
  String get labelNoDownloadsCanceled => 'Brak anulowanych pobrań';
  @override
  String get labelNoDownloadsCanceledDescription =>
      'Dobre wiadomości! Ale jeśli anulujesz pobieranie lub coś pójdzie nie tak z pobieraniem, możesz to sprawdzić tutaj';
  @override
  String get labelNoDownloadsYet => 'Nie pobrano jeszcze żadnych plików';
  @override
  String get labelNoDownloadsYetDescription =>
      'Idź na stronę główną i wyszukaj coś do pobrania lub poczekaj na kolejkę!';
  @override
  String get labelYourQueueIsEmpty => 'Twoja kolejka jest pusta';
  @override
  String get labelYourQueueIsEmptyDescription =>
      'Idź na stronę główną i wyszukaj coś do pobrania!';
  @override
  String get labelQueue => 'Kolejka';
  @override
  String get labelSearchDownloads => 'Wyszukaj pobrane';
  @override
  String get labelWatchHistory => 'Historia oglądania';
  @override
  String get labelWatchHistoryDescription =>
      'Popatrz na oglądane filmy';
  @override
  String get labelBackupAndRestore => 'Kopia zapasowa i przywracanie';
  @override
  String get labelBackupAndRestoreDescription =>
      'Zapisz lub przywróć wszystkie swoje dane lokalne';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription =>
      'Pozwól rozszerzeniu do przeglądarki SongTube na wykrywanie tego urządzenia, naciśnij i przytrzymaj aby dowiedzieć się więcej';
  @override
  String get labelSupportDevelopment => 'Wesprzyj rozwój';
  @override
  String get labelSocialLinks => 'Linki social media';
  @override
  String get labelSeeMore => 'Zobacz więcej';
  @override
  String get labelMostPlayed => 'Najcześciej odtwarzane';
  @override
  String get labelNoPlaylistsYet => 'Nie dodano jeszcze żadnych playlist';
  @override
  String get labelNoPlaylistsYetDescription =>
      'Możesz stworzyć playlistę z ostatnio odtwarzanych, muzyki, albumów lub artystów';
  @override
  String get labelNoSearchResults => 'Brak wyników wyszukiwania';
  @override
  String get labelSongResults => 'Znalezione piosenki';
  @override
  String get labelAlbumResults => 'Znalezione albumy';
  @override
  String get labelArtistResults => 'Znalezieni artyści';
  @override
  String get labelSearchAnything => 'Wszystkie wyniki';
  @override
  String get labelRecents => 'Ostatnie';
  @override
  String get labelFetchingSongs => 'Pobieranie piosenek';
  @override
  String get labelPleaseWaitAMoment => 'Poczekaj chwilę';
  @override
  String get labelWeAreDone => 'Wszystko gotowe';
  @override
  String get labelEnjoyTheApp => 'Miłego używania\nAplikacji';
  @override
  String get labelSongtubeIsBackDescription =>
      'SongTube powraca z czystszym wyglądem i nowym zestawem funkcji, ciesz się swoją muzyką!';
  @override
  String get labelLetsGo => 'Zaczynajmy';
  @override
  String get labelPleaseWait => 'Zaczekaj';
  @override
  String get labelPoweredBy => 'Zasilany przez';
  @override
  String get labelGetStarted => 'Zaczynajmy';
  @override
  String get labelAllowUsToHave => 'Pozwól nam na';
  @override
  String get labelStorageRead => 'Odczyt\nPamięci';
  @override
  String get labelStorageReadDescription =>
      'Pozwoli to zeskanować twoją muzykę, wyodrębnić wysokiej jakości utwory i spersonalizować twoją muzykę';
  @override
  String get labelContinue => 'Kontynuuj';
  @override
  String get labelAllowStorageRead => 'Pozwól na odczyt pamięci';
  @override
  String get labelSelectYourPreferred => 'Wybierz preferowany';
  @override
  String get labelLight => 'Jasny';
  @override
  String get labelDark => 'Ciemny';
  @override
  String get labelSimultaneousDownloads => 'Jednoczesne pobieranie';
  @override
  String get labelSimultaneousDownloadsDescription =>
      'Zdefiniuj ile pobrań może mieć miejsce w tym samym czasie';
  @override
  String get labelItems => 'Rzeczy';
  @override
  String get labelInstantDownloadFormat => 'Natychmiastowe pobieranie';
  @override
  String get labelInstantDownloadFormatDescription =>
      'Zmień format dźwięku do natychmiastowego pobierania';
  @override
  String get labelCurrent => 'Aktualne';
  @override
  String get labelPauseWatchHistory => 'Zapauzuj historię oglądania';
  @override
  String get labelPauseWatchHistoryDescription =>
      'Podczas zapauzowania filmy nie są zapisywane w historii';
  @override
  String get labelLockNavigationBar => 'Blokada paska nawigacji';
  @override
  String get labelLockNavigationBarDescription =>
      'Blokuje chowanie paska nawigacji i pokazywanie go automatycznie podczas scrollowania';
  @override
  String get labelPictureInPicture => 'Obraz w obrazie';
  @override
  String get labelPictureInPictureDescription =>
      'Automatycznie wchodzi w tryb obraz w obrazie kiedy naciśnięto przycisk strony głównej podczas oglądania';
  @override
  String get labelBackgroundPlaybackAlpha => 'Odtwarzanie w tle(Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription =>
      'Włącza funkcję odtwarzania w tle. Z powodu ograniczeń tylko aktualny film może być odtwarzany w tle';
  @override
  String get labelBlurBackgroundDescription => 'Rozmyta okładka w tle';
  @override
  String get labelBlurIntensity => 'Intensywność rozmycia';
  @override
  String get labelBlurIntensityDescription =>
      'Zmień intensywność rozmycia okładki w tle';
  @override
  String get labelBackdropOpacity => 'Krycie tła';
  @override
  String get labelBackdropOpacityDescription =>
      'Zmień krycie kolorowego tła';
  @override
  String get labelArtworkShadowOpacity => 'Krycie cienia okładki';
  @override
  String get labelArtworkShadowOpacityDescription =>
      'Zmień intensywność cienia okładki w odtwarzaczu';
  @override
  String get labelArtworkShadowRadius => 'Promień cienia okładki';
  @override
  String get labelArtworkShadowRadiusDescription =>
      'Zmień promień cienia okładki w odtwarzaczu';
  @override
  String get labelArtworkScaling => 'Skalowanie okładki';
  @override
  String get labelArtworkScalingDescription =>
      'Skalowanie okładki odtwarzacza i obrazów w tle';
  @override
  String get labelBackgroundParallax => 'Paralaksa tła';
  @override
  String get labelBackgroundParallaxDescription =>
      'Włącz/wyłącz efekt paralaksy tła';
  @override
  String get labelRestoreThumbnails => 'Odtwórz miniaturki';
  @override
  String get labelRestoreThumbnailsDescription =>
      'Wymuś generowanie miniaturek i okładek';
  @override
  String get labelRestoringArtworks => 'Odtwarzenie okładek';
  @override
  String get labelRestoringArtworksDone => 'Odtwarzanie okładek zakończone';
  @override
  String get labelHomeScreen => 'Strona startowa';
  @override
  String get labelHomeScreenDescription =>
      'Zmień stronę startową pokazywaną po otwarciu aplikacji';
  @override
  String get labelDefaultMusicPage => 'Domyślna strona muzyki';
  @override
  String get labelDefaultMusicPageDescription =>
      'Zmień stronę startową na stronę muzyki';
  @override
  String get labelAbout => 'O aplikacji';
  @override
  String get labelConversionRequired => 'Potrzebna konwersja';
  @override
  String get labelConversionRequiredDescription =>
      'Ten format piosenki jest nikompatybilny z edytorem tagów ID3. Aplikacja automatycznie przekonwertuje ten format do AAC (m4a) żeby rozwiązać ten problem.';
  @override
  String get labelPermissionRequired => 'Wymagana zgoda';
  @override
  String get labelPermissionRequiredDescription =>
      'Pełny dostęp do plików jest wymagany dla SongTube żeby edytować każdą piosenkę na twoim urządzeniu';
  @override
  String get labelApplying => 'Zastosowywanie';
  @override
  String get labelConvertingDescription =>
      'Rekodowanie tej piosenki w formacie AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription =>
      'Zastosowywanie nowych tagów dla tej piosenki';
  @override
  String get labelApply => 'Zastosuj';
  @override
  String get labelSongs => 'Piosenki';
  @override
  String get labelPlayAll => 'Odtwórz wszystko';
  @override
  String get labelPlaying => 'Odtwarzanie';
  @override
  String get labelPages => 'Strony';
  @override
  String get labelMusicPlayer => 'Odtwarzacz muzyki';
  @override
  String get labelClearWatchHistory => 'Clear Watch History';
  @override
  String get labelClearWatchHistoryDescription =>
      'Czy na pewno chcesz usunąć całą historię oglądania, tej akcji nie można cofnąć, kontynuować?';
  @override
  String get labelDelete => 'Usuń';
  @override
  String get labelAppUpdate => 'Aktualizacja aplikacji';
  @override
  String get labelWhatsNew => 'Co nowego';
  @override
  String get labelLater => 'Później';
  @override
  String get labelUpdate => 'Aktualizuj';
  @override
  String get labelUnsubscribe => 'Anuluj subskrypcję';
  @override
  String get labelAudioFeatures => 'Funkcje dźwięku';
  @override
  String get labelVolumeBoost => 'Zwiększenie głośności';
  @override
  String get labelNormalizeAudio => 'Normalizacja dźwięku';
  @override
  String get labelSegmentedDownload => 'Pobieranie segmentowe';
  @override
  String get labelEnableSegmentedDownload => 'Włącz segmentowe pobieranie';
  @override
  String get labelEnableSegmentedDownloadDescription =>
      'Spowoduje to pobranie całego pliku audio, a następnie podzielenie go na różne włączone segmenty (dla plików audio) z listy';
  @override
  String get labelCreateMusicPlaylist => 'Stwórz playlistę muzyki';
  @override
  String get labelCreateMusicPlaylistDescription =>
      'Stwórz playlistę muzyki ze wszystkich pobranych segmentów audio';
  @override
  String get labelApplyTags => 'Zastosuj tagi';
  @override
  String get labelApplyTagsDescription =>
      'Wyciągnij tagi z MusicBrainz dla wszystkich segmentów';
  @override
  String get labelLoading => 'Ładowanie';
  @override
  String get labelMusicDownloadDescription =>
      'Wybierz jakość, tylko do pobierania i konwertowania';
  @override
  String get labelVideoDownloadDescription =>
      'Wybierz jakość filmu z listy i pobierz go';
  @override
  String get labelInstantDescription => 'Natychmiast zacznij pobierać jako muzykę';
  @override
  String get labelInstant => 'Natychmiastowe';
  @override
  String get labelCurrentQuality => 'Aktualna jakość';
  @override
  String get labelFastStreamingOptions => 'Opcje szybkiego streamowania';
  @override
  String get labelStreamingOptions => 'Opcje streamowania';
  @override
  String get labelComments => 'Komentarze';
  @override
  String get labelPinned => 'Przypięte';
  @override
  String get labelLikedByAuthor => 'Powiązane przez autora';
  @override
  String get labelDescription => 'Opis';
  @override
  String get labelViews => 'Wyświetlenia';
  @override
  String get labelPlayingNextIn => 'Odtwarzaj następne za';
  @override
  String get labelPlayNow => 'Odtwaraj teraz';
  @override
  String get labelLoadingPlaylist => 'Ładowanie playlisty';
  @override
  String get labelPlaylistReachedTheEnd => 'Koniec playlisty';
  @override
  String get labelLiked => 'Powiązane';
  @override
  String get labelLike => 'Polub';
  @override
  String get labelVideoRemovedFromFavorites => 'Filmy usunięte z ulubionych';
  @override
  String get labelVideoAddedToFavorites => 'Filmy dodane do ulubionych';
  @override
  String get labelPopupMode => 'Tryb wyskakujących okien';
  @override
  String get labelDownloaded => 'Pobrane';
  @override
  String get labelShowPlaylist => 'Pokaż playlistę';
  @override
  String get labelCreatePlaylist => 'Stwórz playlistę';
  @override
  String get labelAddVideoToPlaylist => 'Dodaj film do playlisty';
  @override
  String get labelBackupDescription =>
      'Utwórz kopię zapasową swoich lokalnych danych do jednego pliku z którego mogą być odtworzone później';
  @override
  String get labelBackupCreated => 'Kopia zapasowa stworzona';
  @override
  String get labelBackupRestored => 'Kopia zapasowa przywrócona';
  @override
  String get labelRestoreDescription =>
      'Odtwórz wszystkie swoje dane z pliku';
  @override
  String get labelChannelSuggestions => 'Propozycje kanałów';
  @override
  String get labelFetchingChannels => 'Pobieranie kanałów';
  @override
  String get labelShareVideo => 'Udostępnij film';
  @override
  String get labelShareDescription => 'Podziel się z przyjaciółmi na innych platformach';
  @override
  String get labelRemoveFromPlaylists => 'Usuń z playlisty';
  @override
  String get labelThisActionCannotBeUndone => 'Ta czynność nie może być cofnięta';
  @override
  String get labelAddVideoToPlaylistDescription =>
      'Dodaj istniejący lub nowy film do playlisty';
  @override
  String get labelAddToPlaylists => 'Dodaj do playlist';
  @override
  String get labelEditableOnceSaved => 'Możliwe do edycji po zapisaniu';
  @override
  String get labelPlaylistRemoved => 'Playlista usunięta';
  @override
  String get labelPlaylistSaved => 'Playlista zapisana';
  @override
  String get labelRemoveFromFavorites => 'Usuń z ulubionych';
  @override
  String get labelRemoveFromFavoritesDescription =>
      'Usuń ten film z ulubionych';
  @override
  String get labelSaveToFavorites => 'Zapisz do ulubionych';
  @override
  String get labelSaveToFavoritesDescription =>
      'Dodaj film do twojej listy ulubionych';
  @override
  String get labelSharePlaylist => 'Udostępnij playlistę';
  @override
  String get labelRemoveThisVideoFromThisList =>
      'Usuń ten film z tej listy';
  @override
  String get labelEqualizer => 'Equalizer';
  @override
  String get labelLoudnessEqualizationGain => 'Wzmocnienie korekty głośności';
  @override
  String get labelSliders => 'Suwaki';
  @override
  String get labelSave => 'Zapisz';
  @override
  String get labelPlaylistName => 'NazwaPlaylisty';
  @override
  String get labelCreateVideoPlaylist => 'Utwórz playlistę filmów';
  @override
  String get labelSearchFilters => 'Filtry wyszukiwania';
  @override
  String get labelAddToPlaylistDescription => 'Dodaj do istniejącej lub nowej playlisty';
  @override
  String get labelShareSong => 'Udostępnij piosenkę';
  @override
  String get labelShareSongDescription =>
      'Podziel się piosenką z przyjaciółmi na innych platformach';
  @override
  String get labelEditTagsDescription => 'Otwórz taki ID3 i edytor okładek';
  @override
  String get labelContains => 'Zawiera';
  @override
  String get labelPlaybackSpeed => 'Szybkość odtwarzania';
}
