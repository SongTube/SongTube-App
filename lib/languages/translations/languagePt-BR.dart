import 'package:songtube/languages/languages.dart';

class LanguagePtBr extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "Bem-vindo ao";
  @override
  String get labelStart => "Começar";
  @override
  String get labelSkip => "Pular";
  @override
  String get labelNext => "Próximo";
  @override
  String get labelExternalAccessJustification =>
    "Precisa acessar sua Memória Externa para salvar " +
    "seus Vídeos e Músicas";
  @override
  String get labelAppCustomization => "Personalizado";
  @override
  String get labelSelectPreferred => "Selecione seu favorito";
  @override
  String get labelConfigReady => "Configuração Pronta";
  @override
  String get labelIntroductionIsOver => "A introdução terminou";
  @override
  String get labelEnjoy => "Aproveite";
  @override 
  String get labelGoHome => "Ir para Início";

  // Bottom Navigation Bar
  @override
  String get labelHome => "Início";
  @override
  String get labelDownloads => "Downloads";
  @override
  String get labelMedia => "Mídia";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "Mais";

  // Home Screen
  @override
  String get labelQuickSearch => "Busca Rápida...";
  @override
  String get labelTagsEditor => "Editor de\nTags";
  @override
  String get labelEditArtwork => "Editor de\nCapa";
  @override
  String get labelDownloadAll => "Baixar Tudo";
  @override 
  String get labelLoadingVideos => "Carregando Vídeos...";
  @override
  String get labelHomePage => "Página Inicial";
  @override
  String get labelTrending => "Em Alta";
  @override
  String get labelFavorites => "Favoritos";
  @override
  String get labelWatchLater => "Assistir Mais Tarde";

  // Video Options Menu
  @override
  String get labelCopyLink => "Copiar Link";
  @override
  String get labelAddToFavorites => "Adicionar aos Favoritos";
  @override
  String get labelAddToWatchLater => "Adicionar em Assistir Mais Tarde";
  @override
  String get labelAddToPlaylist => "Adicionar à Playlist";

  // Downloads Screen
  @override
  String get labelQueued => "Na Fila";
  @override
  String get labelDownloading => "Baixando";
  @override
  String get labelConverting => "Convertendo";
  @override
  String get labelCancelled => "Cancelado";
  @override
  String get labelCompleted => "Completo";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "Download na Fila";
  @override
  String get labelDownloadAcesssDenied => "Acesso Negado";
  @override
  String get labelClearingExistingMetadata => "Limpando Metadados Existentes...";
  @override
  String get labelWrittingTagsAndArtwork => "Adicionando Tags & Capa...";
  @override
  String get labelSavingFile => "Salvando Arquivo...";
  @override
  String get labelAndroid11FixNeeded => "Erro, uma correção para o Android 11 é necessária, verifique as Configurações";
  @override
  String get labelErrorSavingDownload => "Não foi possível salvar seu Download, verifique as Permissões";
  @override
  String get labelDownloadingVideo => "Baixando Vídeo...";
  @override
  String get labelDownloadingAudio => "Baixando Áudio...";
  @override
  String get labelGettingAudioStream => "Extraindo o Fluxo de Áudio...";
  @override
  String get labelAudioNoDataRecieved => "Não foi possível extrair o Fluxo de Áudio";
  @override
  String get labelDownloadStarting => "Download Começando...";
  @override
  String get labelDownloadCancelled => "Download Cancelado";
  @override
  String get labelAnIssueOcurredConvertingAudio => "A Conversão Falhou";
  @override
  String get labelPatchingAudio => "Empacotando Áudio...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "Ativar Conversão de Áudio";
  @override
  String get labelGainControls => "Controles de Ganho";
  @override
  String get labelVolume => "Volume";
  @override
  String get labelBassGain => "Ganho de Graves";
  @override
  String get labelTrebleGain => "Ganho de Agudos";
  @override
  String get labelSelectVideo => "Selecionar Vídeo";
  @override
  String get labelSelectAudio => "Selecionar Áudio";
  @override
  String get labelGlobalParameters => "Parâmetros globais";

  // Media Screen
  @override
  String get labelMusic => "Músicas";
  @override
  String get labelVideos => "Vídeos";
  @override
  String get labelNoMediaYet => "Nenhuma Mídia Ainda";
  @override
  String get labelNoMediaYetJustification => "Toda sua Mídia " +
    "será mostrada aqui";
  @override
  String get labelSearchMedia => "Buscar Mídia...";
  @override
  String get labelDeleteSong => "Excluir Música";
  @override
  String get labelNoPermissionJustification => "Veja sua Mídia Permitindo o" + "\n" +
    "Acesso à Memória Externa";
  @override
  String get labelGettingYourMedia => "Obtendo Mídia...";
  @override
  String get labelEditTags => "Editar Tags";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "Buscar no YouTube...";

  // More Screen
  @override
  String get labelSettings => "Configurações";
  @override
  String get labelDonate => "Doar";
  @override
  String get labelLicenses => "Licenças";
  @override
  String get labelChooseColor => "Escolher Cor";
  @override
  String get labelTheme => "Tema";
  @override
  String get labelUseSystemTheme => "Usar Tema do Sistema";
  @override
  String get labelUseSystemThemeJustification =>
    "Ativar/Desativar tema automático";
  @override
  String get labelEnableDarkTheme => "Ativar tema Escuro";
  @override
  String get labelEnableDarkThemeJustification =>
    "Usar tema escuro por padrão";
  @override
  String get labelEnableBlackTheme => "Ativar tema Preto";
  @override
  String get labelEnableBlackThemeJustification =>
    "Usar o tema Preto AMOLED";
  @override
  String get labelAccentColor => "Cor de Destaque";
  @override
  String get labelAccentColorJustification => "Personalizar a cor de Destaque";
  @override
  String get labelAudioFolder => "Pasta de Músicas";
  @override
  String get labelAudioFolderJustification => "Selecionar uma pasta para " +
    "baixar as Músicas";
  @override
  String get labelVideoFolder => "Pasta de Vídeos";
  @override
  String get labelVideoFolderJustification => "Selecionar uma pasta para " +
    "baixar os Vídeos";
  @override
  String get labelAlbumFolder => "Pasta de Álbuns";
  @override
  String get labelAlbumFolderJustification => "Criar uma pasta para cada Álbum " +
    "de suas Músicas";
  @override
  String get labelDeleteCache => "Excluir Cache";
  @override
  String get labelDeleteCacheJustification => "Limpar o Cache do SongTube";
  @override
  String get labelAndroid11Fix => "Correção para o Android 11";
  @override
  String get labelAndroid11FixJustification => "Corrigir os problemas de " +
    "download no Android 11";
  @override
  String get labelBackup => "Backup";
  @override
  String get labelBackupJustification => "Criar um backup de sua biblioteca de mídia";
  @override
  String get labelRestore => "Restaurar";
  @override
  String get labelRestoreJustification => "Restaurar sua biblioteca de mídia";
  @override
  String get labelBackupLibraryEmpty => "Sua Biblioteca está vazia";
  @override
  String get labelBackupCompleted => "Backup Completo";
  @override
  String get labelRestoreNotFound => "Backup não Encontrado";
  @override
  String get labelRestoreCompleted => "Backup Restaurado";
  @override
  String get labelCacheIsEmpty => "O Cache está Vazio";
  @override
  String get labelYouAreAboutToClear => "Você está prestes a limpar";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "Título";
  @override
  String get labelEditorArtist => "Artista";
  @override
  String get labelEditorGenre => "Gênero";
  @override
  String get labelEditorDisc => "Disco";
  @override
  String get labelEditorTrack => "Faixa";
  @override
  String get labelEditorDate => "Data";
  @override
  String get labelEditorAlbum => "Álbum";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 11 Detectado";
  @override
  String get labelAndroid11DetectedJustification => "Para assegurar o bom " +
    "funcionamento dos Downloads, no Android 10 e 11, a permissão para " +
    "acessar todos os Arquivos pode ser necessária, isso será " +
    "temporário e não será necessário em futuras atualizações. Você " +
    "também pode aplicar esta correção nas Configurações.";

  // Music Player
  @override
  String get labelPlayerSettings => "Configurações do Player";
  @override
  String get labelExpandArtwork => "Expandir Artwork";
  @override
  String get labelArtworkRoundedCorners => "Artwork com Cantos Arredondados";
  @override
  String get labelPlayingFrom => "Tocando a partir do";
  @override
  String get labelBlurBackground => "Desfocar Fundo";

  // Video Page
  @override
  String get labelTags => "Tags";
  @override
  String get labelRelated => "Relacionados";
  @override
  String get labelAutoPlay => "Tocar Automaticamente";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "Formato de Áudio Não Compatível";
  @override
  String get labelNotSpecified => "Não Especificado";
  @override
  String get labelPerformAutomaticTagging => 
    "Colocar Tags automaticamente";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "Selecionar Tags do MusicBrainz";
  @override
  String get labelSelectArtworkFromDevice =>
    "Selecionar Artwork do dispositivo";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "Junte-se ao Canal do Telegram!";
  @override
  String get labelJoinTelegramJustification =>
    "Você gosta do SongTube? Por favor, junte-se ao Canal do Telegram! Você vai encontrar " +
    "Atualizações, Informações, Desenvolvimento, Link do Grupo e outros links de redes sociais." +
    "\n\n" +
    "No caso de você ter um problema ou uma grande recomendação em sua mente, " +
    "por favor, junte-se ao Grupo do Canal e escreva-o! Mas tenha em mente " +
    "você só pode falar em inglês, obrigado!";
  @override
  String get labelRemindLater => "Lembre-me Mais Tarde";

  // Common Words (One word labels)
  @override
  String get labelExit => "Sair";
  @override
  String get labelSystem => "Sistema";
  @override
  String get labelChannel => "Canal";
  @override
  String get labelShare => "Compartilhar";
  @override
  String get labelAudio => "Áudio";
  @override
  String get labelVideo => "Vídeo";
  @override
  String get labelDownload => "Download";
  @override
  String get labelBest => "Melhor";
  @override
  String get labelPlaylist => "Playlist";
  @override
  String get labelVersion => "Versão";
  @override
  String get labelLanguage => "Idioma";
  @override
  String get labelGrant => "Conceder";
  @override
  String get labelAllow => "Permitir";
  @override
  String get labelAccess => "Acesso";
  @override
  String get labelEmpty => "Vazio";
  @override
  String get labelCalculating => "Calculando";
  @override
  String get labelCleaning => "Limpando";
  @override
  String get labelCancel => "Cancelar";
  @override
  String get labelGeneral => "Geral";
  @override
  String get labelRemove => "Remover";
  @override
  String get labelJoin => "Se Juntar";
  @override
  String get labelNo => "Não";
  @override
  String get labelLibrary => "Biblioteca";
  @override
  String get labelCreate => "Crio";
  @override
  String get labelPlaylists => "Playlists";
  @override
  String get labelQuality => "Qualidade";
  @override
  String get labelSubscribe => "Se inscrever";

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
