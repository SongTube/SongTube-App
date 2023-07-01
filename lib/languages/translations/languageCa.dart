import 'package:songtube/languages/languages.dart';

class LanguageCa extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Benvingut a";
  @override
  String get labelStart => "Començar";
  @override
  String get labelSkip => "Saltar";
  @override
  String get labelNext => "Següent";
  @override
  String get labelExternalAccessJustification =>
    "Necessita accedir a la memòria externa per desar " +
    "els teus videos i música";
  @override
  String get labelAppCustomization => "Personalització";
  @override
  String get labelSelectPreferred => "Selecciona el teu preferit";
  @override
  String get labelConfigReady => "Configuració preparada";
  @override
  String get labelIntroductionIsOver => "La introducció ha acabat";
  @override
  String get labelEnjoy => "Gaudeix";
  @override 
  String get labelGoHome => "Anar a l'Inici";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Inici";
  @override
  String get labelDownloads => "Descàrregues";
  @override
  String get labelMedia => "Colecció";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Més";

  // Home Screen
  @override
  String get labelQuickSearch => "Cerca ràpida...";
  @override
  String get labelTagsEditor => "Editor de\nEtiquetes";
  @override
  String get labelEditArtwork => "Editor de\Portada";
  @override
  String get labelDownloadAll => "Descarregar tots";
  @override 
  String get labelLoadingVideos => "Carregant vídeos...";
  @override
  String get labelHomePage => "Inici";
  @override
  String get labelTrending => "Tendències";
  @override
  String get labelFavorites => "Favorits";
  @override
  String get labelWatchLater => "Visualitzar més tard";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copiar enllaç";
  @override
  String get labelAddToFavorites => "Afegir a Favorits";
  @override
  String get labelAddToWatchLater => "Afegir a Visualitzar més tard";
  @override
  String get labelAddToPlaylist => "Afegint a la llista de reproducció";

  // Downloads Screen
  @override
  String get labelQueued => "En cua";
  @override
  String get labelDownloading => "Descarregant";
  @override
  String get labelConverting => "Convertint";
  @override
  String get labelCancelled => "Cancel·lat";
  @override
  String get labelCompleted => "Completat";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Descàrrega";
  @override
  String get labelDownloadAcesssDenied => "Accés denegat";
  @override
  String get labelClearingExistingMetadata => "Netejant metadades existents...";
  @override
  String get labelWrittingTagsAndArtwork => "Afegint les etiquetes i la portada...";
  @override
  String get labelSavingFile => "Desant fitxer...";
  @override
  String get labelAndroid11FixNeeded => "És necessària la correcció per Android 11, revisa la configuració";
  @override
  String get labelErrorSavingDownload => "No s'ha pogut desar la descàrrega, si us plau, revisa els permisos";
  @override
  String get labelDownloadingVideo => "Descarregant vídeo...";
  @override
  String get labelDownloadingAudio => "Descarregant àudio...";
  @override
  String get labelGettingAudioStream => "Extraient la pista d'àudio...";
  @override
  String get labelAudioNoDataRecieved => "No s'ha pogut extreure la pista d'àudio";
  @override
  String get labelDownloadStarting => "Iniciant descàrrega...";
  @override
  String get labelDownloadCancelled => "Descàrrega cancel·lada";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Conversió fallida";
  @override
  String get labelPatchingAudio => "Corregint l'àudio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Activar conversió d'àudio";
  @override
  String get labelGainControls => "Controls de guany";
  @override
  String get labelVolume => "Volum";
  @override
  String get labelBassGain => "Baixos";
  @override
  String get labelTrebleGain => "Aguts";
  @override
  String get labelSelectVideo => "Seleciona un vídeo";
  @override
  String get labelSelectAudio => "Selecciona un àudio";
  @override
  String get labelGlobalParameters => "Paràmetres globals";

  // Media Screen
  @override
  String get labelMusic => "Música";
  @override
  String get labelVideos => "Vídeos";
  @override
  String get labelNoMediaYet => "Colecció buida";
  @override
  String get labelNoMediaYetJustification => "Tota la colecció " +
    "es mostrarà aquí";
  @override
  String get labelSearchMedia => "Cercar a la colecció...";
  @override
  String get labelDeleteSong => "Eliminar cançó";
  @override
  String get labelNoPermissionJustification => "Accedeix a la teva colecció permetent" + "\n" +
    "accés a la memòria externa";
  @override
  String get labelGettingYourMedia => "Obtenint la teva colecció...";
  @override
  String get labelEditTags => "Editar etiquetes";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Cercar a YouTube...";

  // More Screen
  @override
  String get labelSettings => "Configuració";
  @override
  String get labelDonate => "Donar";
  @override
  String get labelLicenses => "Llicències";
  @override
  String get labelChooseColor => "Selecciona un color";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Utilitzar tema del sistema";
  @override
  String get labelUseSystemThemeJustification =>
    "Activa/Desactiva el tema automàtic";
  @override
  String get labelEnableDarkTheme => "Activar tema fosc";
  @override
  String get labelEnableDarkThemeJustification =>
    "Utilitzar el tema fosc por defecte";
  @override
  String get labelEnableBlackTheme => "Activar tema negre";
  @override
  String get labelEnableBlackThemeJustification =>
    "Activa el tema negre AMOLED";
  @override
  String get labelAccentColor => "Color d'accent";
  @override
  String get labelAccentColorJustification => "Personaliza el color d'accent";
  @override
  String get labelAudioFolder => "Carpeta de música";
  @override
  String get labelAudioFolderJustification => "Selecciona una carpeta per la " +
    "descàrrega de música";
  @override
  String get labelVideoFolder => "Carpeta de vídeos";
  @override
  String get labelVideoFolderJustification => "Selecciona una carpeta per la " +
    "descàrrega de vídeos";
  @override
  String get labelAlbumFolder => "Carpeta d'àlbums";
  @override
  String get labelAlbumFolderJustification => "Crea una carpeta per cada àlbum " +
    "de les teves cançons";
  @override
  String get labelDeleteCache => "Netejar memòria cau";
  @override
  String get labelDeleteCacheJustification => "Netejar la memòria cau de SongTube";
  @override
  String get labelAndroid11Fix => "Correcció per Android 11";
  @override
  String get labelAndroid11FixJustification => "Sol·luciona els problemes de " +
    "descàrrega a Android 11";
  @override
  String get labelBackup => "Còpia de seguretat";
  @override
  String get labelBackupJustification => "Copia la teva colecció de descàrregues";
  @override
  String get labelRestore => "Restaurar";
  @override
  String get labelRestoreJustification => "Restaura la còpia de descarregues";
  @override
  String get labelBackupLibraryEmpty => "La libreria està buida";
  @override
  String get labelBackupCompleted => "Còpia completada";
  @override
  String get labelRestoreNotFound => "Còpia no trobada";
  @override
  String get labelRestoreCompleted => "Còpia restaurada";
  @override
  String get labelCacheIsEmpty => "La memòria cau està buida";
  @override
  String get labelYouAreAboutToClear => "Estàs a punt de netejar";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Títol";
  @override
  String get labelEditorArtist => "Artista";
  @override
  String get labelEditorGenre => "Gènere";
  @override
  String get labelEditorDisc => "Disc";
  @override
  String get labelEditorTrack => "Cançó";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Àlbum";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 11 detectat";
  @override
  String get labelAndroid11DetectedJustification => "Per assegurar el bon " +
    "funcionament de les descarregues a Android 10 i 11, el permís per " +
    "tots els fitxers del dispositiu pot ser necessari. Aquest permís " +
    "serà temporal i no serà requerit en futures actualizacions. Pots" +
    "també donar el permís més endavant en la configuració de l'aplicació.";

  // Music Player
  @override
  String get labelPlayerSettings => "Configuració del reproductor";
  @override
  String get labelExpandArtwork => "Expandir portada";
  @override
  String get labelArtworkRoundedCorners => "Portada amb vores arrodonides";
  @override
  String get labelPlayingFrom => "Reproduint des de";
  @override
  String get labelBlurBackground => "Fons desenfocat";

  // Video Page
  @override
  String get labelTags => "Etiquetes";
  @override
  String get labelRelated => "Relacionat";
  @override
  String get labelAutoPlay => "Reproducció automàtica";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Format d'àudio no compatible";
  @override
  String get labelNotSpecified => "Sense especificar";
  @override
  String get labelPerformAutomaticTagging => 
    "Etiquetar automàticament";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Seleccionar etiquetes des de MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Seleccionar portada local";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Uneix-te al canal de Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "T'agrada SongTube? Entra al nostre canal! Trobaràs " +
    "Actualitzacions, Informació, Desenvolupament, l'enllaç al grup i" +
    "les xarxes socials." +
    "\n\n" +
    "En cas que tinguis un problema o una gran recomanació a fer, " +
    "no dubtis a entrar al grup des del canal i fer-m'ho saber! "+
    "Tingues en compte que només està permès parlar en anglès, gràcies!";
  @override
  String get labelRemindLater => "Recordar més tard";

  // Common Words (One word labels)
  @override
  String get labelExit => "Sortir";
  @override
  String get labelSystem => "Sistema";
  @override
  String get labelChannel => "Canal";
  @override
  String get labelShare => "Compartir";
  @override
  String get labelAudio => "Àudio";
  @override
  String get labelVideo => "Vídeo";
  @override
  String get labelDownload => "Descarregar";
  @override
  String get labelBest => "Millor";
  @override
  String get labelPlaylist => "Llista de reproducció";
  @override
  String get labelVersion => "Versió";
  @override
  String get labelLanguage => "Idioma";
  @override
  String get labelGrant => "Concedir";
  @override
  String get labelAllow => "Permetre";
  @override
  String get labelAccess => "Accés";
  @override
  String get labelEmpty => "Buit";
  @override
  String get labelCalculating => "Calculant";
  @override
  String get labelCleaning => "Netejant";
  @override
  String get labelCancel => "Cancel·lar";
  @override
  String get labelGeneral => "Generzal";
  @override
  String get labelRemove => "Borrar";
  @override
  String get labelJoin => "Entrar";
  @override
  String get labelNo => "No";
  @override
  String get labelLibrary => "Llibreria";
  @override
  String get labelCreate => "Crear";
  @override
  String get labelPlaylists => "Llistes de reproducció";
  @override
  String get labelQuality => "Qualitat";
  @override
  String get labelSubscribe => "Subscriure'm";

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
