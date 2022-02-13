import 'package:songtube/internal/languages.dart';

class LanguageFr extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Bienvenue dans";
  @override
  String get labelStart => "Commencer";
  @override
  String get labelSkip => "Passer";
  @override
  String get labelNext => "Suivant";
  @override
  String get labelExternalAccessJustification =>
    "A besoin d'accéder à votre stockage externe pour sauvegarder toutes les données. " +
    "vos vidéos et musiques";
  @override
  String get labelAppCustomization => "Personnalisation";
  @override
  String get labelSelectPreferred => "Sélectionnez vos préférences";
  @override
  String get labelConfigReady => "Prêt à configurer";
  @override
  String get labelIntroductionIsOver => "L'introduction est terminée";
  @override
  String get labelEnjoy => "Profitez";
  @override 
  String get labelGoHome => "Go Home";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Home";
  @override
  String get labelDownloads => "Téléchargements";
  @override
  String get labelMedia => "Média";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Plus";

  // Home Screen
  @override
  String get labelQuickSearch => "Recherche rapide...";
  @override
  String get labelTagsEditor => "Tags\nEditeur";
  @override
  String get labelEditArtwork => "Modifier\nArtwork";
  @override
  String get labelDownloadAll => "Télécharger tout";
  @override 
  String get labelLoadingVideos => "Chargement vidéo...";
  @override
  String get labelHomePage => "Home Page";
  @override
  String get labelTrending => "Tendance";
  @override
  String get labelFavorites => "Favorits";
  @override
  String get labelWatchLater => "Regarder plus tard";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copier le lien";
  @override
  String get labelAddToFavorites => "Ajouter aux favorits";
  @override
  String get labelAddToWatchLater => "Ajouter à regarder plus tard";
  @override
  String get labelAddToPlaylist => "Ajouter à une Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "File d'attente";
  @override
  String get labelDownloading => "Téléchargement";
  @override
  String get labelConverting => "Convertion";
  @override
  String get labelCancelled => "Annulé";
  @override
  String get labelCompleted => "Terminé";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Télécharger la file d'attente";
  @override
  String get labelDownloadAcesssDenied => "Accès refusé";
  @override
  String get labelClearingExistingMetadata => "Nettoyer les métadonnées existantes...";
  @override
  String get labelWrittingTagsAndArtwork => "Écrire les étiquettes & Artwork...";
  @override
  String get labelSavingFile => "Sauvegarde du fichier...";
  @override
  String get labelAndroid11FixNeeded => "Erreur, Android 11 Correction nécessaire, vérifier les paramètres";
  @override
  String get labelErrorSavingDownload => "Impossible d'enregistrer votre téléchargement, vérifiez les autorisations.";
  @override
  String get labelDownloadingVideo => "Téléchargement de la vidéo...";
  @override
  String get labelDownloadingAudio => "Téléchargement de l'audio...";
  @override
  String get labelGettingAudioStream => "Obtention du flux audio...";
  @override
  String get labelAudioNoDataRecieved => "Impossible d'obtenir un flux audio";
  @override
  String get labelDownloadStarting => "Démarrage du téléchargement...";
  @override
  String get labelDownloadCancelled => "Télécharger annulé";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Échec du processus de conversion";
  @override
  String get labelPatchingAudio => "Raccordement de l'audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Activer la conversion audio";
  @override
  String get labelGainControls => "Contrôles du gain";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Gain des basses";
  @override
  String get labelTrebleGain => "Gain des aigus";
  @override
  String get labelSelectVideo => "Sélectionnez la vidéo";
  @override
  String get labelSelectAudio => "Sélectionnez Audio";
  @override
  String get labelGlobalParameters => "Paramètres généraux";

  // Media Screen
  @override
  String get labelMusic => "Musiques";
  @override
  String get labelVideos => "Vidéos";
  @override
  String get labelNoMediaYet => "Aucun média pour le moment";
  @override
  String get labelNoMediaYetJustification => "Tous vos médias " +
    "seront montrés ici";
  @override
  String get labelSearchMedia => "Recherche de médias...";
  @override
  String get labelDeleteSong => "Supprimer la chanson";
  @override
  String get labelNoPermissionJustification => "Visualisez vos médias par" + "\n" +
    "Accorder l'autorisation d'accès au stockage";
  @override
  String get labelGettingYourMedia => "Obtenir votre média...";
  @override
  String get labelEditTags => "Modifier les étiquettes";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Recherche YouTube...";

  // More Screen
  @override
  String get labelSettings => "Paramètres";
  @override
  String get labelDonate => "Faire un don";
  @override
  String get labelLicenses => "Licences";
  @override
  String get labelChooseColor => "Choisissez la couleur";
  @override
  String get labelTheme => "Thème";
  @override
  String get labelUseSystemTheme => "Utiliser le thème du système";
  @override
  String get labelUseSystemThemeJustification =>
    "Activer/Désactiver le thème automatique";
  @override
  String get labelEnableDarkTheme => "Activer le thème sombre";
  @override
  String get labelEnableDarkThemeJustification =>
    "Utiliser le thème sombre par défaut";
  @override
  String get labelEnableBlackTheme => "Activer le thème noir";
  @override
  String get labelEnableBlackThemeJustification =>
    "Activez le thème Noir pur";
  @override
  String get labelAccentColor => "Couleur principale";
  @override
  String get labelAccentColorJustification => "Personnaliser la couleur principale";
  @override
  String get labelAudioFolder => "Dossier audio";
  @override
  String get labelAudioFolderJustification => "Choisissez un dossier pour " +
    "Téléchargements audio";
  @override
  String get labelVideoFolder => "Dossier vidéo";
  @override
  String get labelVideoFolderJustification => "Choisissez un dossier pour " +
    "Téléchargements de vidéos";
  @override
  String get labelAlbumFolder => "Dossier d'album";
  @override
  String get labelAlbumFolderJustification => "Créer un dossier pour chaque album de chansons";
  @override
  String get labelDeleteCache => "Supprimer le cache";
  @override
  String get labelDeleteCacheJustification => "Vider le cache de SongTube";
  @override
  String get labelAndroid11Fix => "Correction d'Android 11";
  @override
  String get labelAndroid11FixJustification => "Correction des problèmes de téléchargement sur " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Sauvegarde";
  @override
  String get labelBackupJustification => "Sauvegarde de votre médiathèque";
  @override
  String get labelRestore => "Restaurer";
  @override
  String get labelRestoreJustification => "Restaurer votre médiathèque";
  @override
  String get labelBackupLibraryEmpty => "Votre médiathèque est vide";
  @override
  String get labelBackupCompleted => "Sauvegarde terminée";
  @override
  String get labelRestoreNotFound => "Restauration non trouvée";
  @override
  String get labelRestoreCompleted => "Restauration terminée";
  @override
  String get labelCacheIsEmpty => "Le cache est vide";
  @override
  String get labelYouAreAboutToClear => "Vous êtes sur le point d'effacer";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titre";
  @override
  String get labelEditorArtist => "Artiste";
  @override
  String get labelEditorGenre => "Genre";
  @override
  String get labelEditorDisc => "Disque";
  @override
  String get labelEditorTrack => "Piste";
  @override
  String get labelEditorDate => "Date";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 ou 11 détecté";
  @override
  String get labelAndroid11DetectedJustification => "Pour garantir la bonne " +
    "fonctionnement des téléchargements de cette app, sur Android 10 et 11, l'accès à tous les " +
    "L'autorisation du stockage peut être nécessaire, mais elle sera temporelle et non requise. " +
    "sur les futures mises à jour. Vous pouvez également appliquer cette correction dans les paramètres.";

  // Music Player
  @override
  String get labelPlayerSettings => "Paramètres du lecteur";
  @override
  String get labelExpandArtwork => "Élargir l'Artwork";
  @override
  String get labelArtworkRoundedCorners => "Artwork angles arrondis";
  @override
  String get labelPlayingFrom => "Jouer à partir de";
  @override
  String get labelBlurBackground => "Flou de l'arrière-plan";

  // Video Page
  @override
  String get labelTags => "Étiquettes";
  @override
  String get labelRelated => "Voir aussi";
  @override
  String get labelAutoPlay => "Lecture automatique";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Format audio non compatible";
  @override
  String get labelNotSpecified => "Non précisée";
  @override
  String get labelPerformAutomaticTagging => 
    "Effectuer un étiquetage automatique";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Sélectionner les tags de MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "SSélectionner l'Artwork depuis l'appareil";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Rejoindre le canal Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Vous aimez SongTube ? Rejoignez la chaîne Telegram ! Vous y trouverez " +
    "Mises à jour, informations, développement, lien de groupe et autres liens sociaux." +
    "\n\n" +
    "Au cas où vous auriez une question ou une recommandation à formuler, " +
    "s'il vous plaît, rejoignez le groupe depuis le canal et notez-le ! Mais gardez à l'esprit " +
    "vous ne pouvez parler qu'en anglais, merci !";
  @override
  String get labelRemindLater => "Rappeler plus tard";

  // Common Words (One word labels)
  @override
  String get labelExit => "Sortie";
  @override
  String get labelSystem => "Système";
  @override
  String get labelChannel => "Chaîne";
  @override
  String get labelShare => "Partager";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Vidéo";
  @override
  String get labelDownload => "Téléchargement";
  @override
  String get labelBest => "Meilleur";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Version";
  @override
  String get labelLanguage => "Langue";
  @override
  String get labelGrant => "Accord";
  @override
  String get labelAllow => "Autoriser";
  @override
  String get labelAccess => "Accès";
  @override
  String get labelEmpty => "Vide";
  @override
  String get labelCalculating => "Calcul en cours";
  @override
  String get labelCleaning => "Nettoyage";
  @override
  String get labelCancel => "Annulé";
  @override
  String get labelGeneral => "Général";
  @override
  String get labelRemove => "Supprimer";
  @override
  String get labelJoin => "Rejoindre";
  @override
  String get labelNo => "Non";
  @override
  String get labelLibrary => "Médiathèque";
  @override
  String get labelCreate => "Créer";
  @override
  String get labelPlaylists => "Playlists";
  @override
  String get labelQuality => "Qualité";
  @override
  String get labelSubscribe => "S'abonner";
}