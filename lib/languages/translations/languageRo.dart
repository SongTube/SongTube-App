import 'package:songtube/languages/languages.dart';

class LanguageRo extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Bine ați venit la";
  @override
  String get labelStart => "Începe";
  @override
  String get labelSkip => "Sări";
  @override
  String get labelNext => "Următor";
  @override
  String get labelExternalAccessJustification =>
    "Are nevoie de acces la stocarea externă pentru a salva toate " +
    "videoclipurile și muzica dvs.";
  @override
  String get labelAppCustomization => "Personalizare";
  @override
  String get labelSelectPreferred => "Selectați preferatul tău";
  @override
  String get labelConfigReady => "Configurație pregătită";
  @override
  String get labelIntroductionIsOver => "Introducerea s-a terminat";
  @override
  String get labelEnjoy => "Bucură-te";
  @override 
  String get labelGoHome => "Go Home";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Acasă";
  @override
  String get labelDownloads => "Descărcări";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Mai mult";

  // Home Screen
  @override
  String get labelQuickSearch => "Căutare rapidă...";
  @override
  String get labelTagsEditor => "Tag-uri Editor";
  @override
  String get labelEditArtwork => "Edit\nArtwork";
  @override
  String get labelDownloadAll => "Descărcați toate";
  @override 
  String get labelLoadingVideos => "Încărcarea videoclipurilor...";
  @override
  String get labelHomePage => "Pagina de start";
  @override
  String get labelTrending => "Tendințe";
  @override
  String get labelFavorites => "Favorite";
  @override
  String get labelWatchLater => "Urmăriți mai târziu";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copiați link-ul";
  @override
  String get labelAddToFavorites => "Adăugați la favorite";
  @override
  String get labelAddToWatchLater => "Adăugați la vizionare mai târziu";
  @override
  String get labelAddToPlaylist => "Adăugați la Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "Coadă de așteptare";
  @override
  String get labelDownloading => "Descărcarea";
  @override
  String get labelConverting => "Convertirea";
  @override
  String get labelCancelled => "Anulat";
  @override
  String get labelCompleted => "Finalizat";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download Queued";
  @override
  String get labelDownloadAcesssDenied => "Acces refuzat";
  @override
  String get labelClearingExistingMetadata => "Ștergerea metadatelor existente...";
  @override
  String get labelWrittingTagsAndArtwork => "Writting Tags & Artwork...";
  @override
  String get labelSavingFile => "Salvarea fișierului...";
  @override
  String get labelAndroid11FixNeeded => "Eroare, Android 11 Fixare necesară, verificați Setări";
  @override
  String get labelErrorSavingDownload => "Nu s-a putut salva descărcarea, verificați permisiunile";
  @override
  String get labelDownloadingVideo => "Descărcarea video...";
  @override
  String get labelDownloadingAudio => "Descărcarea audio...";
  @override
  String get labelGettingAudioStream => "Obținerea fluxului audio...";
  @override
  String get labelAudioNoDataRecieved => "Nu s-a putut obține fluxul audio";
  @override
  String get labelDownloadStarting => "Descărcare începând...";
  @override
  String get labelDownloadCancelled => "Descărcare anulată";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Procesul convertit a eșuat";
  @override
  String get labelPatchingAudio => "Patching Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Activează conversia audio";
  @override
  String get labelGainControls => "Gain Controls";
  @override
  String get labelVolume => "Volum";
  @override
  String get labelBassGain => "Bass Gain";
  @override
  String get labelTrebleGain => "Treble Gain";
  @override
  String get labelSelectVideo => "Selectați Video";
  @override
  String get labelSelectAudio => "Selectați Audio";
  @override
  String get labelGlobalParameters => "Parametrii globali";

  // Media Screen
  @override
  String get labelMusic => "Muzică";
  @override
  String get labelVideos => "Videouri";
  @override
  String get labelNoMediaYet => "Nu există media încă";
  @override
  String get labelNoMediaYetJustification => "Toate media dvs. " +
    "vor fi afișate aici";
  @override
  String get labelSearchMedia => "Căutare Media...";
  @override
  String get labelDeleteSong => "Șterge melodia";
  @override
  String get labelNoPermissionJustification => "Vizualizați media prin" + "\n" +
    "acordarea permisiunii de stocare";
  @override
  String get labelGettingYourMedia => "Obținerea de media...";
  @override
  String get labelEditTags => "Editare Tag-uri";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Căutare YouTube...";

  // More Screen
  @override
  String get labelSettings => "Setări";
  @override
  String get labelDonate => "Donați";
  @override
  String get labelLicenses => "Licențe";
  @override
  String get labelChooseColor => "Alegeți culoarea";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Utilizați tema sistemului";
  @override
  String get labelUseSystemThemeJustification =>
    "Activați/Dezactivați Tema automată";
  @override
  String get labelEnableDarkTheme => "Activați tema întunecată";
  @override
  String get labelEnableDarkThemeJustification =>
    "Utilizați tema întunecată în mod implicit";
  @override
  String get labelEnableBlackTheme => "Activați tema neagră";
  @override
  String get labelEnableBlackThemeJustification =>
    "Activați Tema Pur negru";
  @override
  String get labelAccentColor => "Culoare accentuală";
  @override
  String get labelAccentColorJustification => "Personalizați culoarea accentului";
  @override
  String get labelAudioFolder => "Dosar audio";
  @override
  String get labelAudioFolderJustification => "Alegeți un dosar pentru " +
    "descărcări audio";
  @override
  String get labelVideoFolder => "Dosar video";
  @override
  String get labelVideoFolderJustification => "Alegeţi un dosar pentru" +
    "descărcări video";
  @override
  String get labelAlbumFolder => "Dosar album";
  @override
  String get labelAlbumFolderJustification => "Creați un dosar pentru fiecare album de melodii";
  @override
  String get labelDeleteCache => "Ștergeți Cache";
  @override
  String get labelDeleteCacheJustification => "Ștergeți cache-ul SongTube";
  @override
  String get labelAndroid11Fix => "Android 11 Fixare";
  @override
  String get labelAndroid11FixJustification => "Fixează problemele de descărcare pe " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Efectuați un backup al bibliotecii media";
  @override
  String get labelRestore => "Restauraţi";
  @override
  String get labelRestoreJustification => "Restaurați biblioteca media";
  @override
  String get labelBackupLibraryEmpty => "Biblioteca ta este goală";
  @override
  String get labelBackupCompleted => "Backup finalizat";
  @override
  String get labelRestoreNotFound => "Restaurarea nu este găsită";
  @override
  String get labelRestoreCompleted => "Restaurare finalizată";
  @override
  String get labelCacheIsEmpty => "Cache este gol";
  @override
  String get labelYouAreAboutToClear => "Ești pe cale să-ți ștergi";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titlu";
  @override
  String get labelEditorArtist => "Artist";
  @override
  String get labelEditorGenre => "Gen";
  @override
  String get labelEditorDisc => "Disc";
  @override
  String get labelEditorTrack => "Pistă";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 sau 11 detectat";
  @override
  String get labelAndroid11DetectedJustification => "Pentru asigura corecta " +
    "Funcționarea descărcărilor acestei aplicații, pe Android 10 și 11, acces la toate " +
    "Este posibil ca permisiunea fișierelor să fie necesară, aceasta va fi temporală și nu este necesară " +
    "la actualizările viitoare. De asemenea, puteți aplica această soluție în setări.";

  // Music Player
  @override
  String get labelPlayerSettings => "Setări player";
  @override
  String get labelExpandArtwork => " Extindeți artwork";
  @override
  String get labelArtworkRoundedCorners => "Artwork Colțuri rotunjite";
  @override
  String get labelPlayingFrom => "Redarea de la";
  @override
  String get labelBlurBackground => "Estomparea fundalului";

  // Video Page
  @override
  String get labelTags => "Tag-uri";
  @override
  String get labelRelated => "În legătură cu";
  @override
  String get labelAutoPlay => "Redare automată";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formatul audio nu este compatibil";
  @override
  String get labelNotSpecified => "Nespecificat";
  @override
  String get labelPerformAutomaticTagging => 
    "Efectuați Tagging automată";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Selectați tag-uri din MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Selectați artwork de pe dispozitiv";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Alăturați-vă canalului Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Îți place SongTube? Vă rugăm să vă alăturați canalului Telegram! Veți găsi " +
    "Actualizări, Informații, Dezvoltare, Link de grup și alte link-uri sociale." +
    "\n\n" +
    "În cazul în care aveți o problemă sau o recomandare grozavă în minte, " +
    "vă rugăm să vă alăturați Grupului din Canal și să o scrieți! Dar țineți cont de faptul " +
    "că puteți vorbi doar în limba engleză, mulțumesc!";
  @override
  String get labelRemindLater => "Reamintește mai târziu";

  // Common Words (One word labels)
  @override
  String get labelExit => "Ieşire";
  @override
  String get labelSystem => "Sistem";
  @override
  String get labelChannel => "Canal";
  @override
  String get labelShare => "Distribuie";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Descarcă";
  @override
  String get labelBest => "Cel mai bun";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Versiunea";
  @override
  String get labelLanguage => "Limbă";
  @override
  String get labelGrant => "Acordă";
  @override
  String get labelAllow => "Permite";
  @override
  String get labelAccess => "Acces";
  @override
  String get labelEmpty => "Gol";
  @override
  String get labelCalculating => "Calcularea";
  @override
  String get labelCleaning => "Curăţare";
  @override
  String get labelCancel => "Anulare";
  @override
  String get labelGeneral => "General";
  @override
  String get labelRemove => "Şterge";
  @override
  String get labelJoin => "Alăturați-vă";
  @override
  String get labelNo => "Nu";
  @override
  String get labelLibrary => "Bibliotecă";
  @override
  String get labelCreate => "Creează";
  @override
  String get labelPlaylists => "Playlisturi";
  @override
  String get labelQuality => "Calitate";
  @override
  String get labelSubscribe => "Abonează-te";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'Fără videoclipuri favorite';
  @override
  String get labelNoFavoriteVideosDescription => 'Căutați videoclipuri și salvați-le ca favorite. Acestea vor apărea aici';
  @override
  String get labelNoSubscriptions => 'Fără abonamente';
  @override
  String get labelNoSubscriptionsDescription => 'Atingeți butonul de mai sus pentru a afișa canalele sugerate!';
  @override
  String get labelNoPlaylists => 'Fără playlisturi';
  @override
  String get labelNoPlaylistsDescription => 'Căutați videoclipuri sau playlisturi și salvați-le. Acestea vor apărea aici';
  @override
  String get labelSearch => 'Căutare';
  @override
  String get labelSubscriptions => 'Abonamente';
  @override
  String get labelNoDownloadsCanceled => 'Nu există descărcări anulate';
  @override
  String get labelNoDownloadsCanceledDescription => 'Vești bune! Dar dacă anulați sau ceva nu merge bine cu descărcarea, puteți verifica de aici';
  @override
  String get labelNoDownloadsYet => 'Încă nu există descărcări';
  @override
  String get labelNoDownloadsYetDescription => 'Mergeți acasă, căutați ceva de descărcat sau așteptați la coadă!';
  @override
  String get labelYourQueueIsEmpty => 'Coada ta este goală';
  @override
  String get labelYourQueueIsEmptyDescription => 'Mergeți acasă și căutați ceva de descărcat!';
  @override
  String get labelQueue => 'Coadă de așteptare';
  @override
  String get labelSearchDownloads => 'Căutare Descărcări';
  @override
  String get labelWatchHistory => 'Istoricul videoclipurilor vizionate';
  @override
  String get labelWatchHistoryDescription => 'Privește la ce videoclipuri ai văzut';
  @override
  String get labelBackupAndRestore => 'Backup & Restaurare';
  @override
  String get labelBackupAndRestoreDescription => 'Salvați sau restaurați toate datele locale';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription => 'Permiteți extensiei de browser SongTube să detecteze acest dispozitiv, apăsați lung pentru a afla mai multe';
  @override
  String get labelSupportDevelopment => 'Sprijină dezvoltarea';
  @override
  String get labelSocialLinks => 'Link-uri sociale';
  @override
  String get labelSeeMore => 'Vezi mai mult';
  @override
  String get labelMostPlayed => 'Cele mai redate';
  @override
  String get labelNoPlaylistsYet => 'Nu există playlisturi încă';
  @override
  String get labelNoPlaylistsYetDescription => 'Poţi crea un playlist din recentele tale, muzică, albume sau artişti.';
  @override
  String get labelNoSearchResults => 'Nu sunt rezultate de căutare';
  @override
  String get labelSongResults => 'Rezultatele melodiilor';
  @override
  String get labelAlbumResults => 'Rezultatele albumelor';
  @override
  String get labelArtistResults => 'Rezultatele artiștilor';
  @override
  String get labelSearchAnything => 'Căutați orice';
  @override
  String get labelRecents => 'Recente';
  @override
  String get labelFetchingSongs => 'Preluare melodii';
  @override
  String get labelPleaseWaitAMoment => 'Vă rugăm să așteptați un moment ';
  @override
  String get labelWeAreDone => 'Am terminat';
  @override
  String get labelEnjoyTheApp => 'Bucură-te de\nApplicaţie';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube s-a întors cu un aspect mai curat și un set de caracteristici, distrează-te cu muzica ta!';
  @override
  String get labelLetsGo => 'Să mergem';
  @override
  String get labelPleaseWait => 'Vă rugăm să așteptați';
  @override
  String get labelPoweredBy => 'Powered by';
  @override
  String get labelGetStarted => 'Începeți';
  @override
  String get labelAllowUsToHave => 'Permiteți-ne să avem';
  @override
  String get labelStorageRead => 'Stocare\nRead';
  @override
  String get labelStorageReadDescription => 'Îți va scana muzica, va extrage artwork-uri de calitate superioară și îți va permite să îți personalizezi muzica.';
  @override
  String get labelContinue => 'Continuă';
  @override
  String get labelAllowStorageRead => 'Permiteți citirea stocării';
  @override
  String get labelSelectYourPreferred => 'Selectați preferatul tău';
  @override
  String get labelLight => 'Luminos';
  @override
  String get labelDark => 'Întunecat';
  @override
  String get labelSimultaneousDownloads => 'Descărcări simultane';
  @override
  String get labelSimultaneousDownloadsDescription => 'Definiți câte descărcări pot avea loc în același timp';
  @override
  String get labelItems => 'Articole';
  @override
  String get labelInstantDownloadFormat => 'Descărcare instantanee';
  @override
  String get labelInstantDownloadFormatDescription => 'Schimbați formatul audio pentru descărcări instantanee';
  @override
  String get labelCurrent => 'Curent';
  @override
  String get labelPauseWatchHistory => 'Pauză Istoricul videoclipurilor';
  @override
  String get labelPauseWatchHistoryDescription => 'În timp ce este în pauză, videoclipurile nu sunt salvate în lista istoricul videoclipurilor vizionate';
  @override
  String get labelLockNavigationBar => 'Blocarea barei de navigare';
  @override
  String get labelLockNavigationBarDescription => 'Blochează ascunderea și afișarea automată a barei de navigare la defilare';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription => 'Intră automat în modul PiP la atingerea butonului Home în timpul vizionării unui videoclip';
  @override
  String get labelBackgroundPlaybackAlpha => 'Redare în fundal (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Comutați funcția de redare în fundal. Din cauza limitărilor plugin-ului, numai videoclipul curent poate fi redat în fundal.';
  @override
  String get labelBlurBackgroundDescription => 'Adăugați fundalul blurat artwork';
  @override
  String get labelBlurIntensity => 'Intensitatea blurului';
  @override
  String get labelBlurIntensityDescription => 'Modificați intensitatea de blurare a fundalului artwork-ului';
  @override
  String get labelBackdropOpacity => 'Opacitatea fundalului';
  @override
  String get labelBackdropOpacityDescription => 'Modificați opacitatea fundalului colorat';
  @override
  String get labelArtworkShadowOpacity => 'Opacitatea umbrei artwork';
  @override
  String get labelArtworkShadowOpacityDescription => 'Schimbați intensitatea umbrei artwork a playerului muzical';
  @override
  String get labelArtworkShadowRadius => 'Raza de umbră artwork';
  @override
  String get labelArtworkShadowRadiusDescription => 'Modificarea razei de umbrire artwork a music player-ului';
  @override
  String get labelArtworkScaling => 'Scalarea artwork-ului';
  @override
  String get labelArtworkScalingDescription => 'Redimensionați artwork-ul playerului muzical și imaginile de fundal';
  @override
  String get labelBackgroundParallax => 'Paralax de fundal';
  @override
  String get labelBackgroundParallaxDescription =>  'Activați/dezactivați efectul de paralaxare a imaginii de fundal';
  @override
  String get labelRestoreThumbnails => 'Restaurați miniaturi';
  @override
  String get labelRestoreThumbnailsDescription => 'Forțați miniaturile și procesul de generare a artwork-ului';
  @override
  String get labelRestoringArtworks => 'Restaurarea artwork-uri';
  @override
  String get labelRestoringArtworksDone => 'Restaurarea artwork-uri terminat';
  @override
  String get labelHomeScreen => 'Ecranul de pornire';
  @override
  String get labelHomeScreenDescription => 'Schimbați ecranul de destinație implicit atunci când deschideți aplicația';
  @override
  String get labelDefaultMusicPage => 'Pagina implicită de muzică';
  @override
  String get labelDefaultMusicPageDescription => 'Schimbați pagina implicită pentru Pagina de muzică';
  @override
  String get labelAbout => 'Despre';
  @override
  String get labelConversionRequired => 'Conversie necesară';
  @override
  String get labelConversionRequiredDescription =>  'Acest format de melodie este incompatibil cu editorul de tag-uri ID3. Aplicația va converti automat această melodie în AAC (m4a) pentru a rezolva această problemă.';
  @override
  String get labelPermissionRequired => 'Permisiunea necesară';
  @override
  String get labelPermissionRequiredDescription => 'Toate permisiunile de acces la fișiere sunt necesare pentru ca SongTube să editeze orice melodie de pe dispozitivul tău';
  @override
  String get labelApplying => 'Aplicarea';
  @override
  String get labelConvertingDescription => 'Re-codificarea acestei melodii în format AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Aplicarea de noi tag-uri pentru acest melodie';
  @override
  String get labelApply => 'Aplică';
  @override
  String get labelSongs => 'Melodii';
  @override
  String get labelPlayAll => 'Redă toate';
  @override
  String get labelPlaying => 'Redarea';
  @override
  String get labelPages => 'Pagini';
  @override
  String get labelMusicPlayer => 'Player de muzică';
  @override
  String get labelClearWatchHistory => 'Ștergeți istoricul videoclipurilor vizionate"';
  @override
  String get labelClearWatchHistoryDescription =>  'Sunteți pe cale să ștergeți toate videoclipurile din istoricul de vizionare, această acțiune nu poate fi anulată, continuați?';
  @override
  String get labelDelete => 'Şterge';
  @override
  String get labelAppUpdate => 'Actualizare aplicație';
  @override
  String get labelWhatsNew => 'Noutăți';
  @override
  String get labelLater => 'Mai târziu';
  @override
  String get labelUpdate => 'Actualizare';
  @override
  String get labelUnsubscribe => 'Dezabonează-te';
  @override
  String get labelAudioFeatures => 'Funcții audio';
  @override
  String get labelVolumeBoost => 'Creșterea volumului';
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
