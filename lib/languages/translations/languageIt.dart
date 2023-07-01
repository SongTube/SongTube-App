import 'package:songtube/languages/languages.dart';

class LanguageIt extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Benvenuto a";
  @override
  String get labelStart => "Start";
  @override
  String get labelSkip => "Salta";
  @override
  String get labelNext => "Prossimo";
  @override
  String get labelExternalAccessJustification =>
    "Necessita l'accesso allo Spazio Esterno pee salvare tutti i " +
    "tuoi Video e la tua Musica";
  @override
  String get labelAppCustomization => "Personalizzazione";
  @override
  String get labelSelectPreferred => "Seleziona il tuo Preferito";
  @override
  String get labelConfigReady => "Configurazione Pronta";
  @override
  String get labelIntroductionIsOver => "L'introduzione è finita";
  @override
  String get labelEnjoy => "Enjoy";
  @override 
  String get labelGoHome => "Vai alla Home";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Home";
  @override
  String get labelDownloads => "Download";
  @override
  String get labelMedia => "Media";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Altro";

  // Home Screen
  @override
  String get labelQuickSearch => "Ricerca Rapida...";
  @override
  String get labelTagsEditor => "Tags\nEditor";
  @override
  String get labelEditArtwork => "Modifica\nArtwork";
  @override
  String get labelDownloadAll => "Scarica Tutto";
  @override 
  String get labelLoadingVideos => "Caricamento Video...";
  @override
  String get labelHomePage => "Pagina Home";
  @override
  String get labelTrending => "Di tendenza";
  @override
  String get labelFavorites => "Preferiti";
  @override
  String get labelWatchLater => "Guarda più Tardi";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copia Link";
  @override
  String get labelAddToFavorites => "Aggiungi ai preferiti";
  @override
  String get labelAddToWatchLater => "Aggiungi a Guarda più Tardi";
  @override
  String get labelAddToPlaylist => "Aggiungi alla Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "In coda";
  @override
  String get labelDownloading => "Scaricando";
  @override
  String get labelConverting => "Convertendo";
  @override
  String get labelCancelled => "Annullato";
  @override
  String get labelCompleted => "Completato";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download in coda";
  @override
  String get labelDownloadAcesssDenied => "Accesso Negato";
  @override
  String get labelClearingExistingMetadata => "Cancellazione dei Metadati esistenti...";
  @override
  String get labelWrittingTagsAndArtwork => "Scrivendo Tag & Artwork...";
  @override
  String get labelSavingFile => "Salvando File...";
  @override
  String get labelAndroid11FixNeeded => "Errore, Fix Android 11 necessario, controlla le Impostazioni";
  @override
  String get labelErrorSavingDownload => "Impossible salvare il tuo Download, controlla i Permessi";
  @override
  String get labelDownloadingVideo => "Scaricando Video...";
  @override
  String get labelDownloadingAudio => "Scaricando Audio...";
  @override
  String get labelGettingAudioStream => "Ottenendo Stream Audio...";
  @override
  String get labelAudioNoDataRecieved => "Impossibile ottenere Stream Audio";
  @override
  String get labelDownloadStarting => "Avviando Download...";
  @override
  String get labelDownloadCancelled => "Download Annullato";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Conversione Fallita";
  @override
  String get labelPatchingAudio => "Patching Audio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Abilita Conversione Audio";
  @override
  String get labelGainControls => "Controlli di Guadagno";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Guadagno Bassi";
  @override
  String get labelTrebleGain => "Guadagno Alti";
  @override
  String get labelSelectVideo => "Seleziona Video";
  @override
  String get labelSelectAudio => "Seleziona Audio";
  @override
  String get labelGlobalParameters => "Parametri globali";

  // Media Screen
  @override
  String get labelMusic => "Musica";
  @override
  String get labelVideos => "Video";
  @override
  String get labelNoMediaYet => "Ancora Nessun Media";
  @override
  String get labelNoMediaYetJustification => "Tutti i tuoi Media " +
    "verranno mostrati qui";
  @override
  String get labelSearchMedia => "Cerca Media...";
  @override
  String get labelDeleteSong => "Cancella Canzone";
  @override
  String get labelNoPermissionJustification => "Vedi i tuoi media Media" + "\n" +
    "Concedendo il permesso allo Spazio";
  @override
  String get labelGettingYourMedia => "Ottenendo i tuoi Media...";
  @override
  String get labelEditTags => "Modifica Tag";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Cerca YouTube...";

  // More Screen
  @override
  String get labelSettings => "Impostazioni";
  @override
  String get labelDonate => "Donazione";
  @override
  String get labelLicenses => "Licenze";
  @override
  String get labelChooseColor => "Scegli Colore";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Usa il Tema di Sistema";
  @override
  String get labelUseSystemThemeJustification =>
    "Abilita/Disabilita Tema automatico";
  @override
  String get labelEnableDarkTheme => "Abilita Tema Scuro";
  @override
  String get labelEnableDarkThemeJustification =>
    "Usa Tema Scuro di default";
  @override
  String get labelEnableBlackTheme => "Abilita Tema Nero";
  @override
  String get labelEnableBlackThemeJustification =>
    "Abilita Tema Nero Puro";
  @override
  String get labelAccentColor => "Colore accento";
  @override
  String get labelAccentColorJustification => "Personalizza colore accento";
  @override
  String get labelAudioFolder => "Cartella audio";
  @override
  String get labelAudioFolderJustification => "Scegli una cartella per " +
    "Download audio";
  @override
  String get labelVideoFolder => "Cartella video";
  @override
  String get labelVideoFolderJustification => "Scegli una cartella per " +
    "Download video";
  @override
  String get labelAlbumFolder => "Cartella Album";
  @override
  String get labelAlbumFolderJustification => "Crea una cartella per ogni Album delle canzoni";
  @override
  String get labelDeleteCache => "Elimina Cache";
  @override
  String get labelDeleteCacheJustification => "Pulisci Cache SongTube";
  @override
  String get labelAndroid11Fix => "Fix Android 11";
  @override
  String get labelAndroid11FixJustification => "Aggiusta i problemi dei Download in " +
    "Android 10 & 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Effetua un Backup della tua libreria media";
  @override
  String get labelRestore => "Ripristina";
  @override
  String get labelRestoreJustification => "Ripristina la tua libreria audio da un backup";
  @override
  String get labelBackupLibraryEmpty => "La tua Libreria è vuota";
  @override
  String get labelBackupCompleted => "Backup Completato";
  @override
  String get labelRestoreNotFound => "Ripristino non trovato";
  @override
  String get labelRestoreCompleted => "Ripristino Completato";
  @override
  String get labelCacheIsEmpty => "La Cache è Vuota";
  @override
  String get labelYouAreAboutToClear => "Stai per cancellare";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Titolo";
  @override
  String get labelEditorArtist => "Artista";
  @override
  String get labelEditorGenre => "Genere";
  @override
  String get labelEditorDisc => "Disco";
  @override
  String get labelEditorTrack => "Traccia";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 or 11 Rilevato";
  @override
  String get labelAndroid11DetectedJustification => "Per assicurare il corretto " +
    "funzionamento dei download di quest'app, su Android 10 e 11, il permesso " +
    "Accesso a Tutti i File potrebbe essere necessario. Questo è temporaneo e non richiesto " +
    "negli aggiornamenti futuri. Puoi anche applicare questo fix nelle impostazioni.";

  // Music Player
  @override
  String get labelPlayerSettings => "Impostazioni Player";
  @override
  String get labelExpandArtwork => "Espandi Artwork";
  @override
  String get labelArtworkRoundedCorners => "Angoli arrotondati dell'Artwork";
  @override
  String get labelPlayingFrom => "Riproducendo Da";
  @override
  String get labelBlurBackground => "Sfoca Sfondo";

  // Video Page
  @override
  String get labelTags => "Tag";
  @override
  String get labelRelated => "Correlati";
  @override
  String get labelAutoPlay => "AutoPlay";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formato audio non compatibile";
  @override
  String get labelNotSpecified => "Non specificato";
  @override
  String get labelPerformAutomaticTagging => 
    "Effettua Tagging Automatico";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Seleziona tag da MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Seleziona Artwork dal dispositivo";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Unisciti al canale Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Ti piace SongTube? Per favore entra nel Canale Telegram! Troverai " +
    "Aggiornamenti, Informazioni, Sviluppo, Link del Gruppo e altri link ai Social." +
    "\n\n" +
    "Nel caso abbia un problema o un bel suggerimento nella tua mente, " +
    "per favore entra nel gruppo dal canale e scrivilo! Ma tieni in mente " +
    "che puoi solo scrivere in inglese, grazie!";
  @override
  String get labelRemindLater => "Ricorda più Tardi";

  // Common Words (One word labels)
  @override
  String get labelExit => "Esco";
  @override
  String get labelSystem => "Sistema";
  @override
  String get labelChannel => "Canale";
  @override
  String get labelShare => "Condividi";
  @override
  String get labelAudio => "Audio";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Download";
  @override
  String get labelBest => "Migliore";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Versione";
  @override
  String get labelLanguage => "Lingua";
  @override
  String get labelGrant => "Concedi";
  @override
  String get labelAllow => "Consenti";
  @override
  String get labelAccess => "Accesso";
  @override
  String get labelEmpty => "Vuoto";
  @override
  String get labelCalculating => "Calcolando";
  @override
  String get labelCleaning => "Pulendo";
  @override
  String get labelCancel => "Annulla";
  @override
  String get labelGeneral => "Generale";
  @override
  String get labelRemove => "Rimuovi";
  @override
  String get labelJoin => "Unisciti";
  @override
  String get labelNo => "No";
  @override
  String get labelLibrary => "Libreria";
  @override
  String get labelCreate => "Crea";
  @override
  String get labelPlaylists => "Playlist";
  @override
  String get labelQuality => "Qualità";
  @override
  String get labelSubscribe => "Iscriviti";

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