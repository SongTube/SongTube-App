import 'package:songtube/languages/languages.dart';

class LanguageCs extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Vítejte v";
  @override
  String get labelStart => "Začít";
  @override
  String get labelSkip => "Přeskočit";
  @override
  String get labelNext => "Další";
  @override
  String get labelExternalAccessJustification =>
    "Potřebuje přístup k vašemu externímu úložišti pro ukládání všech " +
    "vašich videí a hudby";
  @override
  String get labelAppCustomization => "Přizpůsobení";
  @override
  String get labelSelectPreferred => "Vyberte své preferované";
  @override
  String get labelConfigReady => "Konfigurace připravena";
  @override
  String get labelIntroductionIsOver => "Úvod je u konce";
  @override
  String get labelEnjoy => "Užijte si";
  @override 
  String get labelGoHome => "Domovská stránka";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Domů";
  @override
  String get labelDownloads => "Stahování";
  @override
  String get labelMedia => "Média";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Další";

  // Home Screen
  @override
  String get labelQuickSearch => "Rychlé hledání...";
  @override
  String get labelTagsEditor => "Editor\nštítků";
  @override
  String get labelEditArtwork => "Upravit\nobal";
  @override
  String get labelDownloadAll => "Stáhnout vše";
  @override 
  String get labelLoadingVideos => "Načítání videí...";
  @override
  String get labelHomePage => "Domovská stránka";
  @override
  String get labelTrending => "Trendy";
  @override
  String get labelFavorites => "Oblíbené";
  @override
  String get labelWatchLater => "Přehrát později";

  // Video Options Menu
  @override
  String get labelCopyLink => "Zkopírovat odkaz";
  @override
  String get labelAddToFavorites => "Přidat do oblíbených";
  @override
  String get labelAddToWatchLater => "Přidat do Přehrát později";
  @override
  String get labelAddToPlaylist => "Přidat do playlistu";

  // Downloads Screen
  @override
  String get labelQueued => "Ve frontě";
  @override
  String get labelDownloading => "Stahování";
  @override
  String get labelConverting => "Konvertování";
  @override
  String get labelCancelled => "Zrušeno";
  @override
  String get labelCompleted => "Dokončeno";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Stahování přidáno do fronty";
  @override
  String get labelDownloadAcesssDenied => "Přístup zamítnut";
  @override
  String get labelClearingExistingMetadata => "Mazání existujících metadat...";
  @override
  String get labelWrittingTagsAndArtwork => "Zapisování štítků a obalu...";
  @override
  String get labelSavingFile => "Ukládání souboru...";
  @override
  String get labelAndroid11FixNeeded => "Chyba, je potřeba oprava pro Android 11, viz nastavení";
  @override
  String get labelErrorSavingDownload => "Nepodařilo se uložit vaše stahování, zkontrolujte oprávnění";
  @override
  String get labelDownloadingVideo => "Stahování videa...";
  @override
  String get labelDownloadingAudio => "Stahování zvuku...";
  @override
  String get labelGettingAudioStream => "Načítání audio streamu...";
  @override
  String get labelAudioNoDataRecieved => "Nepodařilo se načíst audio stream";
  @override
  String get labelDownloadStarting => "Spouštění stahování...";
  @override
  String get labelDownloadCancelled => "Stahování zrušeno";
  @override
  String get labelAnIssueOcurredConvertingAudio => "Proces konvertování selhal";
  @override
  String get labelPatchingAudio => "Záplatování zvuku...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Povolit konvertování zvuku";
  @override
  String get labelGainControls => "Ovládání zesílení";
  @override
  String get labelVolume => "Hlasitost";
  @override
  String get labelBassGain => "Zesílení basů";
  @override
  String get labelTrebleGain => "Zesílení výšek";
  @override
  String get labelSelectVideo => "Vyberat video";
  @override
  String get labelSelectAudio => "Vybrat zvuk";
  @override
  String get labelGlobalParameters => "Globální nastavení";

  // Media Screen
  @override
  String get labelMusic => "Hudba";
  @override
  String get labelVideos => "Videa";
  @override
  String get labelNoMediaYet => "Zatím žádná média";
  @override
  String get labelNoMediaYetJustification => "Všechna vaše média " +
    "budou zobrazena zde";
  @override
  String get labelSearchMedia => "Hledat média...";
  @override
  String get labelDeleteSong => "Odstranit skladbu";
  @override
  String get labelNoPermissionJustification => "Zobrazte svá média" + "\n" +
    "udělením přístupu k úložišti";
  @override
  String get labelGettingYourMedia => "Načítání médií...";
  @override
  String get labelEditTags => "Upravit štítky";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Hledat na YouTube...";

  // More Screen
  @override
  String get labelSettings => "Nastavení";
  @override
  String get labelDonate => "Přispějte";
  @override
  String get labelLicenses => "Licence";
  @override
  String get labelChooseColor => "Vyberte barvu";
  @override
  String get labelTheme => "Téma";
  @override
  String get labelUseSystemTheme => "Použít systémové téma";
  @override
  String get labelUseSystemThemeJustification =>
    "Povolit/zakázat automatické téma";
  @override
  String get labelEnableDarkTheme => "Povolit tmavé téma";
  @override
  String get labelEnableDarkThemeJustification =>
    "Použít tmavé téma jako výchozí";
  @override
  String get labelEnableBlackTheme => "Povolit černé téma";
  @override
  String get labelEnableBlackThemeJustification =>
    "Povolit čistě černé téma";
  @override
  String get labelAccentColor => "Obarvení";
  @override
  String get labelAccentColorJustification => "Přizpůsobit barvu aplikace";
  @override
  String get labelAudioFolder => "Složka zvuku";
  @override
  String get labelAudioFolderJustification => "Vyberte složku pro " +
    "stahování zvuku";
  @override
  String get labelVideoFolder => "Složka videí";
  @override
  String get labelVideoFolderJustification => "Vyberte složku pro " +
    "stahování videí";
  @override
  String get labelAlbumFolder => "Složka alb";
  @override
  String get labelAlbumFolderJustification => "Vytvořit složku pro album každé skladby";
  @override
  String get labelDeleteCache => "Vymazat mezipaměť";
  @override
  String get labelDeleteCacheJustification => "Vymazat mezipaměť SongTube";
  @override
  String get labelAndroid11Fix => "Oprava pro Android 11";
  @override
  String get labelAndroid11FixJustification => "Opraví problémy se stahováním na " +
    "Androidu 10 a 11";
  @override
  String get labelBackup => "Záloha";
  @override
  String get labelBackupJustification => "Zálohujte svou knihovnu médií";
  @override
  String get labelRestore => "Obnovit";
  @override
  String get labelRestoreJustification => "Obnovte svou knihovnu médií";
  @override
  String get labelBackupLibraryEmpty => "Vaše knihovna je prázdná";
  @override
  String get labelBackupCompleted => "Záloha dokončena";
  @override
  String get labelRestoreNotFound => "Obnovení nenalezeno";
  @override
  String get labelRestoreCompleted => "Obnovení dokončeno";
  @override
  String get labelCacheIsEmpty => "Mezipaměť je prázdná";
  @override
  String get labelYouAreAboutToClear => "Chystáte se vymazat";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Název";
  @override
  String get labelEditorArtist => "Umělec";
  @override
  String get labelEditorGenre => "Žánr";
  @override
  String get labelEditorDisc => "Disk";
  @override
  String get labelEditorTrack => "Skladba";
  @override
  String get labelEditorDate => "Datum";
  @override
  String get labelEditorAlbum => "Album";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Detekován Android 10 nebo 11";
  @override
  String get labelAndroid11DetectedJustification => "Pro zajištění správné " +
    "funkčnosti stahování v této aplikaci může být na Androidu 10 a 11 vyžadován " +
    "přístup ke všem souborům. Toto bude v nadcházejících aktualizacích dočasné " +
    "a volitelné. Tuto opravu lze také použít v nastavení.";

  // Music Player
  @override
  String get labelPlayerSettings => "Nastavení přehrávače";
  @override
  String get labelExpandArtwork => "Rozšířit obal";
  @override
  String get labelArtworkRoundedCorners => "Zaoblené rohy obalu";
  @override
  String get labelPlayingFrom => "Přehrávání z";
  @override
  String get labelBlurBackground => "Rozmazat pozadí";

  // Video Page
  @override
  String get labelTags => "Štítky";
  @override
  String get labelRelated => "Souvistející";
  @override
  String get labelAutoPlay => "Automatické přehrávání";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formát zvuku není kompatibilní";
  @override
  String get labelNotSpecified => "Neurčeno";
  @override
  String get labelPerformAutomaticTagging => 
    "Provést automatické tagování";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Vybrat tagy z MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Vybrat obal ze zařízení";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Připojte se na náš Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Líbí se vám SongTube? Připojte se do našeho Telegram kanálu! Najdete tam " +
    "aktualizace, informace, vývoj, odkaz na skupinu a další sociální odkazy." +
    "\n\n" +
    "Pokud máte v hlavě problém nebo dobré doporučení, připojte se do naší " +
    "skupiny z kanálu a napište to tam! Nezapomeňte ale prosím, že " +
    "můžete mluvit pouze anglicky. Díky!";
  @override
  String get labelRemindLater => "Připomenout později";

  // Common Words (One word labels)
  @override
  String get labelExit => "Opustit";
  @override
  String get labelSystem => "Systém";
  @override
  String get labelChannel => "Kanál";
  @override
  String get labelShare => "Sdílet";
  @override
  String get labelAudio => "Zvuk";
  @override
  String get labelVideo => "Video";
  @override
  String get labelDownload => "Stáhnout";
  @override
  String get labelBest => "Nejlepší";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Verze";
  @override
  String get labelLanguage => "Jazyk";
  @override
  String get labelGrant => "Udělit";
  @override
  String get labelAllow => "Povolit";
  @override
  String get labelAccess => "Přístup";
  @override
  String get labelEmpty => "Prázdné";
  @override
  String get labelCalculating => "Vypočítávání";
  @override
  String get labelCleaning => "Mazání";
  @override
  String get labelCancel => "Zrušit";
  @override
  String get labelGeneral => "Obecné";
  @override
  String get labelRemove => "Odebrat";
  @override
  String get labelJoin => "Připojit se";
  @override
  String get labelNo => "Ne";
  @override
  String get labelLibrary => "Knihovna";
  @override
  String get labelCreate => "Vytvořit";
  @override
  String get labelPlaylists => "Playlisty";
  @override
  String get labelQuality => "Kvalita";
  @override
  String get labelSubscribe => "Odebírat";

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
