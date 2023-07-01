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
  String get labelTagsEditor => "Editor de Tags";
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
  String get labelNoFavoriteVideos => 'No hay videos favoritos';
  @override
  String get labelNoFavoriteVideosDescription => 'Busca videos y guardalos como favoritos. Apareceran aqui';
  @override
  String get labelNoSubscriptions => 'No hay subscripciones';
  @override
  String get labelNoSubscriptionsDescription => '¡Toca el boton de arriba para ver los canales sugeridos!';
  @override
  String get labelNoPlaylists => 'No hay listas de reproduccion';
  @override
  String get labelNoPlaylistsDescription => 'Busca videos o listas de reproduccion y guardalas. Apareceran aqui';
  @override
  String get labelSearch => 'Buscar';
  @override
  String get labelSubscriptions => 'Subscripciones';
  @override
  String get labelNoDownloadsCanceled => 'No hay descargas canceladas';
  @override
  String get labelNoDownloadsCanceledDescription => 'Buenas noticias! Pero si cancelas o algo sucede con tu descarga, aparecera aqui';
  @override
  String get labelNoDownloadsYet => 'No hay descargas!';
  @override
  String get labelNoDownloadsYetDescription => 'Ve al inicio, busca por algo para descargar o espera la cola de descargas';
  @override
  String get labelYourQueueIsEmpty => 'Tu lista de descargas esta vacia';
  @override
  String get labelYourQueueIsEmptyDescription => '¡Ve al inicio y encuentra algo para descargar!';
  @override
  String get labelQueue => 'Cola';
  @override
  String get labelSearchDownloads => 'Buscar Descargas';
  @override
  String get labelWatchHistory => 'Historial de Videos';
  @override
  String get labelWatchHistoryDescription => 'Revisa que videos has visto';
  @override
  String get labelBackupAndRestore => 'Respaldar & Restaurar';
  @override
  String get labelBackupAndRestoreDescription => 'Guarda o restaura todos tus datos locales';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription => 'Permite que la extension para el navegador detecte SongTube. Manten presionado para saber mas';
  @override
  String get labelSupportDevelopment => 'Ayuda el Desarrollo';
  @override
  String get labelSocialLinks => 'Redes Sociales';
  @override
  String get labelSeeMore => 'Ver mas';
  @override
  String get labelMostPlayed => 'Reproducciones frecuentes';
  @override
  String get labelNoPlaylistsYet => 'No hay listas de reproduccion';
  @override
  String get labelNoPlaylistsYetDescription => 'Puedes crear una lista de reproduccion desde tu recientes, musica, albumes o artistas';
  @override
  String get labelNoSearchResults => 'No hay resultados';
  @override
  String get labelSongResults => 'Resultados de Musica';
  @override
  String get labelAlbumResults => 'Resultados de Albumes';
  @override
  String get labelArtistResults => 'Resultados de Artistas';
  @override
  String get labelSearchAnything => 'Buscar todo';
  @override
  String get labelRecents => 'Recientes';
  @override
  String get labelFetchingSongs => 'Buscando Canciones';
  @override
  String get labelPleaseWaitAMoment => 'Espere un momento';
  @override
  String get labelWeAreDone => 'Estamos listos';
  @override
  String get labelEnjoyTheApp => 'Disfruta la\nAplicacion';
  @override
  String get labelSongtubeIsBackDescription => '¡SongTube esta devuelta con nueva apariencia y caracteristicas, disfruta tu musica!';
  @override
  String get labelLetsGo => 'Comenzar';
  @override
  String get labelPleaseWait => 'Espere por favor';
  @override
  String get labelPoweredBy => 'Powered by';
  @override
  String get labelGetStarted => 'Comenzar';
  @override
  String get labelAllowUsToHave => 'Permite a la app';
  @override
  String get labelStorageRead => 'Leer el\nAlmacenamiento';
  @override
  String get labelStorageReadDescription => 'Esto va a escanear, extraer caratulas de alta calidad y permitirte personalizar tu musica';
  @override
  String get labelContinue => 'Continuar';
  @override
  String get labelAllowStorageRead => 'Permitir';
  @override
  String get labelSelectYourPreferred => 'Selecciona tu';
  @override
  String get labelLight => 'Blanco';
  @override
  String get labelDark => 'Oscuro';
  @override
  String get labelSimultaneousDownloads => 'Descargas Simultaneas';
  @override
  String get labelSimultaneousDownloadsDescription => 'Define cuantas descargas pueden procesarse al mismo tiempo';
  @override
  String get labelItems => 'Elementos';
  @override
  String get labelInstantDownloadFormat => 'Descarga Instantanea';
  @override
  String get labelInstantDownloadFormatDescription => 'Cambia el formato de audio para la descarga instantanea';
  @override
  String get labelCurrent => 'Actual';
  @override
  String get labelPauseWatchHistory => 'Pausar Historial de Videos';
  @override
  String get labelPauseWatchHistoryDescription => 'Mientras este pausado, ningun video se va a guardar en el historial';
  @override
  String get labelLockNavigationBar => 'Bloquear Barra de Navegacion';
  @override
  String get labelLockNavigationBarDescription => 'Evita que la barra de navegacion se muestre o oculte automaticamente';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription => 'Ingresa automáticamente al modo PiP al tocar el botón de inicio mientras ve un video';
  @override
  String get labelBackgroundPlaybackAlpha => 'Reproduccion en segundo plano (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Activa o desactiva la reproduccion en segundo plano.';
  @override
  String get labelBlurBackgroundDescription => 'Añade efecto de desenfoque a la caratura de fondo';
  @override
  String get labelBlurIntensity => 'Intensidad del Desenfoque';
  @override
  String get labelBlurIntensityDescription => 'Cambia la intensidad de desenfoque de la caratula de fondo';
  @override
  String get labelBackdropOpacity => 'Opacidad del Fondo';
  @override
  String get labelBackdropOpacityDescription => 'Cambia la opacidad del fondo de color';
  @override
  String get labelArtworkShadowOpacity => 'Opacidad de la sombra de la Caratula';
  @override
  String get labelArtworkShadowOpacityDescription => 'Cambia la intensidad de la sombra de la caratula del reproductor de música';
  @override
  String get labelArtworkShadowRadius => 'Radio de sombra de la Caratula';
  @override
  String get labelArtworkShadowRadiusDescription => 'Cambia el radio de sombra de la caratula del reproductor de música';
  @override
  String get labelArtworkScaling => 'Escalado de Caratula';
  @override
  String get labelArtworkScalingDescription => 'Escala las caratulas de portada y fondo del reproductor de música';
  @override
  String get labelBackgroundParallax => 'Fondo Parallax';
  @override
  String get labelBackgroundParallaxDescription =>  'Activa o desactiva el efecto Parallax en el fondo del reproductor de musica';
  @override
  String get labelRestoreThumbnails => 'Restaurar Thumbnails';
  @override
  String get labelRestoreThumbnailsDescription => 'Fuerza la regeneracion de caratulas de todas las canciones';
  @override
  String get labelRestoringArtworks => 'Restaurando Caratulas';
  @override
  String get labelRestoringArtworksDone => 'Caratulas restauradas';
  @override
  String get labelHomeScreen => 'Pagina de Inicio';
  @override
  String get labelHomeScreenDescription => 'Cambia la pagina de inicio por defecto al abrir la aplicacion';
  @override
  String get labelDefaultMusicPage => 'Pagina de Musica';
  @override
  String get labelDefaultMusicPageDescription => 'Cambia la pagina de Musica por defecto';
  @override
  String get labelAbout => 'Acerca de';
  @override
  String get labelConversionRequired => 'Conversion Requerida';
  @override
  String get labelConversionRequiredDescription =>  'El formato de esta cancion es incompatible. La aplicacion va a convertir esta cancion a AAC (m4a) para resolver este problema.';
  @override
  String get labelPermissionRequired => 'Permiso Requerido';
  @override
  String get labelPermissionRequiredDescription => 'Se requiere todo permiso de acceso a archivos para que SongTube edite cualquier canción en su dispositivo';
  @override
  String get labelApplying => 'Aplicando';
  @override
  String get labelConvertingDescription => 'Recodificando esta cancion al formato AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Aplicando nuevas etiquetas y caratura a esta cancion';
  @override
  String get labelApply => 'Aplicar';
  @override
  String get labelSongs => 'Canciones';
  @override
  String get labelPlayAll => 'Reproducir Todo';
  @override
  String get labelPlaying => 'Reproduciendo';
  @override
  String get labelPages => 'Paginas';
  @override
  String get labelMusicPlayer => 'Reproductor de Musica';
  @override
  String get labelClearWatchHistory => 'Limpiar Historial de Videos';
  @override
  String get labelClearWatchHistoryDescription =>  'Vas a elimianr todos los videos de tu historial, esta accion es irreversible, ¿Continuar?';
  @override
  String get labelDelete => 'Borrar';
  @override
  String get labelAppUpdate => 'Actualizacion';
  @override
  String get labelWhatsNew => 'Que hay de nuevo';
  @override
  String get labelLater => 'Despues';
  @override
  String get labelUpdate => 'Actualizar';
  @override
  String get labelUnsubscribe => 'Anular';
  @override
  String get labelAudioFeatures => 'Mejoras de Audio';
  @override
  String get labelVolumeBoost => 'Aumento de Volumen';
  @override
  String get labelNormalizeAudio => 'Normalizar Audio';
  @override
  String get labelSegmentedDownload => 'Descarga Segmentada';
  @override
  String get labelEnableSegmentedDownload => 'Activar Descarga Segmentada';
  @override
  String get labelEnableSegmentedDownloadDescription => 'This will download the whole audio file and then split it into the various enabled segments (or audio tracks) from the list below';
  @override
  String get labelCreateMusicPlaylist => 'Crear Lista de Reproduccion';
  @override
  String get labelCreateMusicPlaylistDescription => 'Crea una lista de reproduccion automaticamente despues de completar la descarga.';
  @override
  String get labelApplyTags => 'Aplicar Etiquetas y Caratulas';
  @override
  String get labelApplyTagsDescription => 'Extraer la informacion de cada cancion con MusicBrainz';
  @override
  String get labelLoading => 'Cargando';
  @override
  String get labelMusicDownloadDescription => 'Selecciona la calidad, descarga y convierte solo el audio';
  @override
  String get labelVideoDownloadDescription =>  'Selecciona un video de la lista y descarga';
  @override
  String get labelInstantDescription => 'Descarga instantaneamente como audio';
  @override
  String get labelInstant => 'Instantaneo';
  @override
  String get labelCurrentQuality => 'Calidad Actual';
  @override
  String get labelFastStreamingOptions => 'Opciones de Stream Rapidas';
  @override
  String get labelStreamingOptions => 'Opciones de Stream';
  @override
  String get labelComments => 'Comentarios';
  @override
  String get labelPinned => 'Anclado';
  @override
  String get labelLikedByAuthor => 'Le gusto al Autor';
  @override
  String get labelDescription => 'Descripcion';
  @override
  String get labelViews => 'Vistas';
  @override
  String get labelPlayingNextIn => 'Reproduciento en';
  @override
  String get labelPlayNow => 'Reproducir Ahora';
  @override
  String get labelLoadingPlaylist => 'Cargando lista de reproduccion';
  @override
  String get labelPlaylistReachedTheEnd => 'Termino la lista de reproduccion';
  @override
  String get labelLiked => 'Me gusta';
  @override
  String get labelLike => 'Me gusta';
  @override
  String get labelVideoRemovedFromFavorites => 'Video removido de favoritos';
  @override
  String get labelVideoAddedToFavorites => 'Video añadido a favoritos';
  @override
  String get labelPopupMode => 'Modo Ventana';
  @override
  String get labelDownloaded => 'Descargado';
  @override
  String get labelShowPlaylist => 'Mostrar lista de reproduccion';
  @override
  String get labelCreatePlaylist => 'Crear lista de reproduccion';
  @override
  String get labelAddVideoToPlaylist => 'Añadir video a lista de reproduccion';
  @override
  String get labelBackupDescription => 'Respalda todos tus datos locales en un solo archivo que puedes usar luego para restaurar tus datos';
  @override
  String get labelBackupCreated => 'Respaldo Creado';
  @override
  String get labelBackupRestored => 'Respaldo Restaurado';
  @override
  String get labelRestoreDescription => 'Restaura todos tus datos usando un archivo de respaldo';
  @override
  String get labelChannelSuggestions => 'Recomendacion de Canales';
  @override
  String get labelFetchingChannels => 'Cargando Canales';
  @override
  String get labelShareVideo => 'Compartir Video';
  @override
  String get labelShareDescription => 'Compartir con amigos o otras plataformas';
  @override
  String get labelRemoveFromPlaylists => 'Remover lista de reproduccion';
  @override
  String get labelThisActionCannotBeUndone => 'Esta accion no se puede revertir';
  @override
  String get labelAddVideoToPlaylistDescription => 'Añadir a nuevo o existente lista de reproduccion';
  @override
  String get labelAddToPlaylists => 'Añadir a lista de reproduccion';
  @override
  String get labelEditableOnceSaved => 'Puede ser editado una vez guardado';
  @override
  String get labelPlaylistRemoved => 'Removida lista de reproduccion';
  @override
  String get labelPlaylistSaved => 'Guardada lista de reproduccion';
  @override
  String get labelRemoveFromFavorites => 'Remover de favoritos';
  @override
  String get labelRemoveFromFavoritesDescription => 'Remover este video de favoritos';
  @override
  String get labelSaveToFavorites => 'Guardan en favoritos';
  @override
  String get labelSaveToFavoritesDescription => 'Añadir este video a tu lista de favoritos';
  @override
  String get labelSharePlaylist => 'Compartir lista de reproduccion';
  @override
  String get labelRemoveThisVideoFromThisList => 'Remover este video de la lista';
  @override
  String get labelEqualizer => 'Ecualizador';
  @override
  String get labelLoudnessEqualizationGain => 'Ganancia de Volumen';
  @override
  String get labelSliders => 'Controles';
  @override
  String get labelSave => 'Guardar';
  @override
  String get labelPlaylistName => 'Nombre de lista de reproduccion';
  @override
  String get labelCreateVideoPlaylist => 'Crear lista de reproduccion de videos';
  @override
  String get labelSearchFilters => 'Filtros de busqueda';
  @override
  String get labelAddToPlaylistDescription => 'Añadir a nuevo o existente lista de reproduccion';
  @override
  String get labelShareSong => 'Compartir Musica';
  @override
  String get labelShareSongDescription => 'Comparte con tus amigos o otras plataformas';
  @override
  String get labelEditTagsDescription => 'Abre el editor de etiquetas y caratula';
  @override
  String get labelContains => 'Contiene';
  @override
  String get labelPlaybackSpeed => 'Velocidad de reproduccion';
}
