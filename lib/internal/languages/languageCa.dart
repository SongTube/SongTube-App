import 'package:songtube/internal/languages.dart';

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
}
