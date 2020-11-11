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
    "Necesita acceder a tu memoria External para guardar " +
    "tus Videos y Musica";
  @override
  String get labelAppCustomization => "Personalización";
  @override
  String get labelSelectPreferred => "Selecciona tu favorito";
  @override
  String get labelConfigReady => "Configuración Lista";
  @override
  String get labelIntroductionIsOver => "La Introduccion ha terminado";
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
  String get labelAndroid11FixNeeded => "Se necesita el Parche para Android 11, revisa Configuración";
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
  String get labelDownloadStarting => "Descarga Comenzando...";
  @override
  String get labelDownloadCancelled => "Descarga Cancelada";
  @override
  String get labelAnIssueOcurredConvertingAudio => "El convertidor falló";
  @override
  String get labelPatchingAudio => "Parcheando el Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Activar conversion de audio";
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

  // Media Screen
  @override
  String get labelMusic => "Musica";
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
  String get labelBackupLibraryEmpty => "Tu libraría esta vacía";
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

}