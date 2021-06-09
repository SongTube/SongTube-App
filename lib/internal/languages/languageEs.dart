import 'package:songtube/internal/languages.dart';

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
}
