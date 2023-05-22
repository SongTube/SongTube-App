import 'package:songtube/languages/languages.dart';

class LanguageEs extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Bienvenido a";
  @override
  String get labelStart => "Comenzar";
  @override
  String get labelSkip => "Saltar";
  @override
  String get labelNext => "Siguiente";
  @override
  String get labelExternalAccessJustification =>
    "Necesita acceder a tu memoria Externa para guardar " +
    "tus Videos y Música";
  @override
  String get labelAppCustomization => "Personalización";
  @override
  String get labelSelectPreferred => "Selecciona tu favorito";
  @override
  String get labelConfigReady => "Configuración Lista";
  @override
  String get labelIntroductionIsOver => "La Introducción ha terminado";
  @override
  String get labelEnjoy => "Disfruta";
  @override 
  String get labelGoHome => "Ir a Inicio";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Inicio";
  @override
  String get labelDownloads => "Descargas";
  @override
  String get labelMedia => "Colección";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Más";

  // Home Screen
  @override
  String get labelQuickSearch => "Busqueda Rápida...";
  @override
  String get labelTagsEditor => "Editor de\nTags";
  @override
  String get labelEditArtwork => "Editor de\nCaratula";
  @override
  String get labelDownloadAll => "Descargar Todo";
  @override 
  String get labelLoadingVideos => "Cargando Videos...";
  @override
  String get labelHomePage => "Inicio";
  @override
  String get labelTrending => "Tendencias";
  @override
  String get labelFavorites => "Favoritos";
  @override
  String get labelWatchLater => "Ver mas tarde";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copiar Enlace";
  @override
  String get labelAddToFavorites => "Añadir a Favoritos";
  @override
  String get labelAddToWatchLater => "Añadir a Ver mas tarde";
  @override
  String get labelAddToPlaylist => "Añadir a Lista de reproducción";

  // Downloads Screen
  @override
  String get labelQueued => "En Cola";
  @override
  String get labelDownloading => "Descargando";
  @override
  String get labelConverting => "Convirtiendo";
  @override
  String get labelCancelled => "Cancelado";
  @override
  String get labelCompleted => "Completado";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Descarga en Cola";
  @override
  String get labelDownloadAcesssDenied => "Acceso Denegado";
  @override
  String get labelClearingExistingMetadata => "Limpiando Metadatos Existentes...";
  @override
  String get labelWrittingTagsAndArtwork => "Añadiendo Tags & Caratula...";
  @override
  String get labelSavingFile => "Guardando Archivo...";
  @override
  String get labelAndroid11FixNeeded => "Se necesita el Parche para Android 11, revisa la Configuración";
  @override
  String get labelErrorSavingDownload => "No se pudo guardar tu Descarga, revisa los Permisos";
  @override
  String get labelDownloadingVideo => "Descargando Video...";
  @override
  String get labelDownloadingAudio => "Descargando Audio...";
  @override
  String get labelGettingAudioStream => "Extrayendo el Stream de Audio...";
  @override
  String get labelAudioNoDataRecieved => "No se pudo extraer el Stream de Audio";
  @override
  String get labelDownloadStarting => "Comenzando Descarga...";
  @override
  String get labelDownloadCancelled => "Descarga Cancelada";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Conversión fallida";
  @override
  String get labelPatchingAudio => "Parcheando el Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Activar conversión de audio";
  @override
  String get labelGainControls => "Controles de Ganancia";
  @override
  String get labelVolume => "Volumen";
  @override
  String get labelBassGain => "Bajos";
  @override
  String get labelTrebleGain => "Sobreagudo";
  @override
  String get labelSelectVideo => "Seleciona un Video";
  @override
  String get labelSelectAudio => "Selecciona un Audio";
  @override
  String get labelGlobalParameters => "Parámetros globales";

  // Media Screen
  @override
  String get labelMusic => "Música";
  @override
  String get labelVideos => "Videos";
  @override
  String get labelNoMediaYet => "Colección vacía";
  @override
  String get labelNoMediaYetJustification => "Toda tu Colección " +
    "se mostrará aquí";
  @override
  String get labelSearchMedia => "Buscar en Colección...";
  @override
  String get labelDeleteSong => "Borrar Canción";
  @override
  String get labelNoPermissionJustification => "Accede a tu Colección permitiendo" + "\n" +
    "acceso a la Memoria Externa";
  @override
  String get labelGettingYourMedia => "Obteniendo tu Colección...";
  @override
  String get labelEditTags => "Editar Tags";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Buscar en YouTube...";

  // More Screen
  @override
  String get labelSettings => "Configuración";
  @override
  String get labelDonate => "Donar";
  @override
  String get labelLicenses => "Licencias";
  @override
  String get labelChooseColor => "Selecciona un Color";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Usar Tema de Sistema";
  @override
  String get labelUseSystemThemeJustification =>
    "Activa/Desactiva tema automatico";
  @override
  String get labelEnableDarkTheme => "Activar tema Oscuro";
  @override
  String get labelEnableDarkThemeJustification =>
    "Usar tema oscuro por defecto";
  @override
  String get labelEnableBlackTheme => "Activar tema Negro";
  @override
  String get labelEnableBlackThemeJustification =>
    "Activa el tema Negro AMOLED";
  @override
  String get labelAccentColor => "Color de Acento";
  @override
  String get labelAccentColorJustification => "Personaliza el color de Acento";
  @override
  String get labelAudioFolder => "Carpeta de Música";
  @override
  String get labelAudioFolderJustification => "Selecciona una carpeta para la " +
    "descarga de Música";
  @override
  String get labelVideoFolder => "Carpeta de Videos";
  @override
  String get labelVideoFolderJustification => "Selecciona una carpeta para la " +
    "descarga de Videos";
  @override
  String get labelAlbumFolder => "Carpeta de Albums";
  @override
  String get labelAlbumFolderJustification => "Crea una carpeta por cada Album " +
    "de tus Canciones";
  @override
  String get labelDeleteCache => "Borrar Caché";
  @override
  String get labelDeleteCacheJustification => "Borra el Caché de SongTube";
  @override
  String get labelAndroid11Fix => "Parche para Android 11";
  @override
  String get labelAndroid11FixJustification => "Soluciona los problemas de " +
    "descarga en Android 11";
  @override
  String get labelBackup => "Respaldo";
  @override
  String get labelBackupJustification => "Respalda tu colección de Descargas";
  @override
  String get labelRestore => "Restaurar";
  @override
  String get labelRestoreJustification => "Restaura tu colección de Descargas";
  @override
  String get labelBackupLibraryEmpty => "Tu librería esta vacía";
  @override
  String get labelBackupCompleted => "Respaldo completado";
  @override
  String get labelRestoreNotFound => "Respaldo no encontrado";
  @override
  String get labelRestoreCompleted => "Respaldo restaurado";
  @override
  String get labelCacheIsEmpty => "El Caché esta vacío";
  @override
  String get labelYouAreAboutToClear => "Estas por limpiar";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titulo";
  @override
  String get labelEditorArtist => "Artista";
  @override
  String get labelEditorGenre => "Genero";
  @override
  String get labelEditorDisc => "Disco";
  @override
  String get labelEditorTrack => "Canción";
  @override
  String get labelEditorDate => "Fecha";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 11 Detectado";
  @override
  String get labelAndroid11DetectedJustification => "Para asegurar el buen " +
    "funcionamiento de las Descargas, en Android 10 y 11, el permiso para " +
    "todos los Archivos del dispositivo puede ser necesario, este permiso va " +
    "a ser temporal y no será requerido en futuras actualizaciones. Puedes" +
    "también dar el permiso luego en la Configuracion de esta aplicación.";

  // Music Player
  @override
  String get labelPlayerSettings => "Configuration del Reproductor";
  @override
  String get labelExpandArtwork => "Expandir Caratula";
  @override
  String get labelArtworkRoundedCorners => "Carátula con bordes redondeados";
  @override
  String get labelPlayingFrom => "Reproduciendo desde";
  @override
  String get labelBlurBackground => "Fondo desenfocado";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Relacionado";
  @override
  String get labelAutoPlay => "Reproducción Automatica";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formato de audio no compatible";
  @override
  String get labelNotSpecified => "Sin Especificar";
  @override
  String get labelPerformAutomaticTagging => 
    "Taggear Automaticamente";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Seleccionar Tags desde MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Seleccionar Caratula local";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "¡Unete al canal de Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "¿Te gusta SongTube? ¡Entra a nuestro canal! Vas a encontrar " +
    "Actualizaciones, Información, Desarrollo, link del Group " +
    "redes sociales." +
    "\n\n" +
    "En caso de que tengas un problema o una gran recomendación que hacer, " +
    "¡eres bienvenido de entrar al grupo desde el canal y hacermelo saber! "+ 
    "Pero ten en cuenta que solo esta permitido hablar en inglés, ¡gracias!";
  @override
  String get labelRemindLater => "Recordar mas tarde";

  // Common Words (One word labels)
  @override
  String get labelExit => "Salir";
  @override
  String get labelSystem => "Sistema";
  @override
  String get labelChannel => "Canal";
  @override
  String get labelShare => "Compartir";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Descarga";
  @override
  String get labelBest => "Mejor";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Versión";
  @override
  String get labelLanguage => "Idioma";
  @override
  String get labelGrant => "Conceder";
  @override
  String get labelAllow => "Permitir";
  @override
  String get labelAccess => "Acceso";
  @override
  String get labelEmpty => "Vacío";
  @override
  String get labelCalculating => "Calculando";
  @override
  String get labelCleaning => "Limpiando";
  @override
  String get labelCancel => "Cancelar";
  @override
  String get labelGeneral => "General";
  @override
  String get labelRemove => "Remover";
  @override
  String get labelJoin => "Entrar";
  @override
  String get labelNo => "No";
  @override
  String get labelLibrary => "Librería";
  @override
  String get labelCreate => "Crear";
  @override
  String get labelPlaylists => "Listas de reproducción";
  @override
  String get labelQuality => "Calidad";
  @override
  String get labelSubscribe => "Suscribirme";

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
