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
  String get labelNoFavoriteVideos => 'Sem Vídeos Favoritos';
  @override
  String get labelNoFavoriteVideosDescription => 'Procure e salve vídeos favoritos. Eles aparecerão aqui.';
  @override
  String get labelNoSubscriptions => 'Sem inscrições';
  @override
  String get labelNoSubscriptionsDescription => 'Aperte no botão acima para mostrar canais sugeridos!';
  @override
  String get labelNoPlaylists => 'Sen Playlists';
  @override
  String get labelNoPlaylistsDescription => 'Procure e salve playlists e vídeos favoritos. Eles aparecerão aqui.';
  @override
  String get labelSearch => 'Busca';
  @override
  String get labelSubscriptions => 'Inscrições';
  @override
  String get labelNoDownloadsCanceled => 'Sem Downloads Cancelados';
  @override
  String get labelNoDownloadsCanceledDescription => 'Boas notícias! Mas, se você cancelar ou algum erro acontecer em um download, você pode ver aqui';
  @override
  String get labelNoDownloadsYet => 'Sem Downloads Ainda';
  @override
  String get labelNoDownloadsYetDescription => 'Vá para o início, busque algo para baixar ou aguarde na sua fila de espera!';
  @override
  String get labelYourQueueIsEmpty => 'Lista de tarefas vazia.';
  @override
  String get labelYourQueueIsEmptyDescription => 'Vá para o início e busque algo para baixar!';
  @override
  String get labelQueue => 'Fila';
  @override
  String get labelSearchDownloads => 'Buscar Downloads';
  @override
  String get labelWatchHistory => 'Histórico de Exibição';
  @override
  String get labelWatchHistoryDescription => 'Relembre quais vídeos você assistiu.';
  @override
  String get labelBackupAndRestore => 'Backup & Restauração';
  @override
  String get labelBackupAndRestoreDescription => 'Salve ou restaure seus dados locais';
  @override
  String get labelSongtubeLink => 'SongTube Link';
  @override
  String get labelSongtubeLinkDescription => 'Permita ao navegador do SongTube a detectar seu dispositivo, aperte e segure para saber mais';
  @override
  String get labelSupportDevelopment => 'Apoiar Desenvolvimento';
  @override
  String get labelSocialLinks => 'Links de Redes Sociais';
  @override
  String get labelSeeMore => 'Veja mais';
  @override
  String get labelMostPlayed => 'Mais assistidos';
  @override
  String get labelNoPlaylistsYet => 'Sem Playlists Ainda.';
  @override
  String get labelNoPlaylistsYetDescription => 'Você pode criar uma playlist das músicas, álbuns, artistas e conteúdo recente';
  @override
  String get labelNoSearchResults => 'Sem resultados para a busca';
  @override
  String get labelSongResults => 'Resultados para músicas';
  @override
  String get labelAlbumResults => 'Resultados para  álbum';
  @override
  String get labelArtistResults => 'Resultados para artistas';
  @override
  String get labelSearchAnything => 'Busque qualquer coisa';
  @override
  String get labelRecents => 'Recentes';
  @override
  String get labelFetchingSongs => 'Encontrar Songs';
  @override
  String get labelPleaseWaitAMoment => 'Por favor, aguarde um momento';
  @override
  String get labelWeAreDone => 'Tudo finalizado';
  @override
  String get labelEnjoyTheApp => 'Aproveite o \nAplicativo';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube está de volta com um visual limpo e cheio de melhorias, se divirta ouvindo suas músicas!';
  @override
  String get labelLetsGo => 'Vamos lá!';
  @override
  String get labelPleaseWait => 'Por favor aguarde';
  @override
  String get labelPoweredBy => 'Desenvolvido por';
  @override
  String get labelGetStarted => 'Comece por aqui';
  @override
  String get labelAllowUsToHave => 'Nos conceda permissão';
  @override
  String get labelStorageRead => 'Armazenamento\nLeitura';
  @override
  String get labelStorageReadDescription => 'Isso era analisar suas músicas, extrair miniaturas de alta qualidade e personalizar suas músicas.';
  @override
  String get labelContinue => 'Continuar';
  @override
  String get labelAllowStorageRead => 'Permita a Leitura do Armazenamento';
  @override
  String get labelSelectYourPreferred => 'Selecione sua preferência';
  @override
  String get labelLight => 'Claro';
  @override
  String get labelDark => 'Escuro';
  @override
  String get labelSimultaneousDownloads => 'Downloads Simultâneos';
  @override
  String get labelSimultaneousDownloadsDescription => 'Defina a quantidade de downloads que podem ocorrer simultaneamente';
  @override
  String get labelItems => 'Itens';
  @override
  String get labelInstantDownloadFormat => 'Download Instantâneo';
  @override
  String get labelInstantDownloadFormatDescription => 'Altere o formato de áudio para downloads instantâneos';
  @override
  String get labelCurrent => 'Atual';
  @override
  String get labelPauseWatchHistory => 'Pausar Histórico de Exibição';
  @override
  String get labelPauseWatchHistoryDescription => 'Enquanto suspenso, os vídeos não serão salvos no histórico de exibição.';
  @override
  String get labelLockNavigationBar => 'Travar Barra de Navegação';
  @override
  String get labelLockNavigationBarDescription => 'Proiba a barra de navegação de se exibir e ocultar de forma automática ao rolar.';
  @override
  String get labelPictureInPicture => 'Picture in Picture';
  @override
  String get labelPictureInPictureDescription => 'Ative o modo PiP automaticamente ao navegar para o Início durante a exibição de um vídeo';
  @override
  String get labelBackgroundPlaybackAlpha => 'Continue a tocar em plano de fundo (Alpha)';
  @override
  String get labelBackgroundPlaybackAlphaDescription => 'Ative/Desative a função de tocar em plano de fundo. Devido a limitações do plugin, apenas o vídeo atual pode ser tocado em plano de fundo';
  @override
  String get labelBlurBackgroundDescription => 'Adicione uma miniatura borrada da capa do álbum ao fundo do player';
  @override
  String get labelBlurIntensity => 'Intensidade do desfoque';
  @override
  String get labelBlurIntensityDescription => 'Altera a intensidade do desfoque da capa do álbum';
  @override
  String get labelBackdropOpacity => 'Opacidade do plano de fundo';
  @override
  String get labelBackdropOpacityDescription => 'Mude a opacidade da coloração do plano de fundo';
  @override
  String get labelArtworkShadowOpacity => 'Opacidade da sombra na arte de capa';
  @override
  String get labelArtworkShadowOpacityDescription => 'Altere a intensidade de sombra na arte de capa no player';
  @override
  String get labelArtworkShadowRadius => 'Raio da Sombra na Arte de Capa';
  @override
  String get labelArtworkShadowRadiusDescription => 'Altere o raio da sombra na arte de capa no player';
  @override
  String get labelArtworkScaling => 'Escala da Arte de Capa';
  @override
  String get labelArtworkScalingDescription => 'Recorte a arte de capa e plano de fundo no player de música';
  @override
  String get labelBackgroundParallax => 'Parallax de Plano de Fundo';
  @override
  String get labelBackgroundParallaxDescription =>  'Ative/Desative o efeito parallax de plano de fundo';
  @override
  String get labelRestoreThumbnails => 'Restaure miniaturas';
  @override
  String get labelRestoreThumbnailsDescription => 'Forçar processo de geração de miniaturas de arte de capa';
  @override
  String get labelRestoringArtworks => 'Restaurando arte de capa';
  @override
  String get labelRestoringArtworksDone => 'Restauração de arte de capa concluído';
  @override
  String get labelHomeScreen => 'Tela de Início';
  @override
  String get labelHomeScreenDescription => 'Mude a tela de início ao entrar no app';
  @override
  String get labelDefaultMusicPage => 'Página Padrão de Música';
  @override
  String get labelDefaultMusicPageDescription => 'Mudar página padrão de Música';
  @override
  String get labelAbout => 'Sobre';
  @override
  String get labelConversionRequired => 'Conversão Requerida';
  @override
  String get labelConversionRequiredDescription =>  'O formato de música é incompatível com as tags de edição do ID3. O aplicativo irá converter essa música para AAC (m4a) automaticamente para resolver esse problema.';
  @override
  String get labelPermissionRequired => 'Permissão Requerida';
  @override
  String get labelPermissionRequiredDescription => 'O acesso total a arquivos é necessário para o SongTube editar qualquer música no seu dispositivo';
  @override
  String get labelApplying => 'Aplicando';
  @override
  String get labelConvertingDescription => 'Re-codificando essa música para o formato AAC (m4a)';
  @override
  String get labelWrittingTagsAndArtworkDescription => 'Aplicando novas tags para essa música';
  @override
  String get labelApply => 'Aplicar';
  @override
  String get labelSongs => 'Músicas';
  @override
  String get labelPlayAll => 'Tocar todas';
  @override
  String get labelPlaying => 'Tocando';
  @override
  String get labelPages => 'Páginas';
  @override
  String get labelMusicPlayer => 'Player de Música';
  @override
  String get labelClearWatchHistory => 'Limpar Histórico de Exibição';
  @override
  String get labelClearWatchHistoryDescription =>  'Você está prestes a limpar o seu historico de exibição, essa ação não pode ser desfeita, deseja continuar?';
  @override
  String get labelDelete => 'Deletar';
  @override
  String get labelAppUpdate => 'Atualização do App';
  @override
  String get labelWhatsNew => 'Novidades';
  @override
  String get labelLater => 'Depois';
  @override
  String get labelUpdate => 'Atualizar';
  @override
  String get labelUnsubscribe => 'Cancelar Inscrição';
  @override
  String get labelAudioFeatures => 'Funcionalidades de Áudio';
  @override
  String get labelVolumeBoost => 'Boost de Volume';
  @override
  String get labelNormalizeAudio => 'Normalizar Áudio';
  @override
  String get labelSegmentedDownload => 'Downloads Segmentados';
  @override
  String get labelEnableSegmentedDownload => 'Habilitar Download Segmentados';
  @override
  String get labelEnableSegmentedDownloadDescription => 'Isso irá baixar o arquivo inteiro, e depois dividir em vários segmentos (ou canais de áudio) da lista abaixo';
  @override
  String get labelCreateMusicPlaylist => 'Criar Playlist de Música';
  @override
  String get labelCreateMusicPlaylistDescription => 'Criar playlist de música de todos os downloads e partes de áudios salvos';
  @override
  String get labelApplyTags => 'Aplicar Tags';
  @override
  String get labelApplyTagsDescription => 'Extrair tags de todos os segmentos de MusicBrainz';
  @override
  String get labelLoading => 'Carregando';
  @override
  String get labelMusicDownloadDescription => 'Selecionar qualidade, converter e baixar apenas áudio';
  @override
  String get labelVideoDownloadDescription =>  'Escolha uma qualidade de vídeo da lista para baixar';
  @override
  String get labelInstantDescription => 'Comece já a baixar como música';
  @override
  String get labelInstant => 'Instantâneo';
  @override
  String get labelCurrentQuality => 'Qualidade Atual';
  @override
  String get labelFastStreamingOptions => 'Opções de Transmissão Rápida';
  @override
  String get labelStreamingOptions => 'Opções de Transmissão';
  @override
  String get labelComments => 'Comentários';
  @override
  String get labelPinned => 'Fixado';
  @override
  String get labelLikedByAuthor => 'Curtido pelo Autor';
  @override
  String get labelDescription => 'Descrição';
  @override
  String get labelViews => 'Exibições';
  @override
  String get labelPlayingNextIn => 'Tocando próxima em';
  @override
  String get labelPlayNow => 'Tocando Agora';
  @override
  String get labelLoadingPlaylist => 'Carregando Playlist';
  @override
  String get labelPlaylistReachedTheEnd => 'A playlist chegou ao fim';
  @override
  String get labelLiked => 'Curtiu';
  @override
  String get labelLike => 'Curtir';
  @override
  String get labelVideoRemovedFromFavorites => 'Vídeo removido dos favoritos';
  @override
  String get labelVideoAddedToFavorites => 'Vídeo adicionado aos favoritos';
  @override
  String get labelPopupMode => 'Modo Janela';
  @override
  String get labelDownloaded => 'Baixados';
  @override
  String get labelShowPlaylist => 'Mostrar Playlist';
  @override
  String get labelCreatePlaylist => 'Criar Playlist';
  @override
  String get labelAddVideoToPlaylist => 'Adicionar vídeo a playlist';
  @override
  String get labelBackupDescription => 'Faça backup de todos seus dados locais em um arquivo único para poder restaurar depois';
  @override
  String get labelBackupCreated => 'Backup Criado';
  @override
  String get labelBackupRestored => 'Backup Restaurado';
  @override
  String get labelRestoreDescription => 'Restaure todos os seus dados de um arquivo backup';
  @override
  String get labelChannelSuggestions => 'Canais Sugeridos';
  @override
  String get labelFetchingChannels => 'Canais Resultantes';
  @override
  String get labelShareVideo => 'Vídeo Compartilhado';
  @override
  String get labelShareDescription => 'Compartilhe com seus amigos ou em outras plataformas';
  @override
  String get labelRemoveFromPlaylists => 'Remover da playlist';
  @override
  String get labelThisActionCannotBeUndone => 'Essa ação não pode ser desfeita';
  @override
  String get labelAddVideoToPlaylistDescription => 'Adicionar vídeo a nova ou existente playlist';
  @override
  String get labelAddToPlaylists => 'Adicionar a playlists';
  @override
  String get labelEditableOnceSaved => 'Mudanças salvas';
  @override
  String get labelPlaylistRemoved => 'Playlist Removida';
  @override
  String get labelPlaylistSaved => 'Playlist Salva';
  @override
  String get labelRemoveFromFavorites => 'Removido dos favoritos';
  @override
  String get labelRemoveFromFavoritesDescription => 'Remover esse video de seus favoritos';
  @override
  String get labelSaveToFavorites => 'Salvar nos favoritos';
  @override
  String get labelSaveToFavoritesDescription => 'Adicionar vídeo na sua lista de favoritos';
  @override
  String get labelSharePlaylist => 'Compartilhar Playlist';
  @override
  String get labelRemoveThisVideoFromThisList => 'Remover essa vídeo da lista';
  @override
  String get labelEqualizer => 'Equalizador';
  @override
  String get labelLoudnessEqualizationGain => 'Curva de Ganho de Equalização';
  @override
  String get labelSliders => 'Cartões';
  @override
  String get labelSave => 'Salvar';
  @override
  String get labelPlaylistName => 'Nome da Playlist';
  @override
  String get labelCreateVideoPlaylist => 'Criar Playlist de Vídeos';
  @override
  String get labelSearchFilters => 'Filtros de Busca';
  @override
  String get labelAddToPlaylistDescription => 'Adicionar a nova ou existente playlist';
  @override
  String get labelShareSong => 'Compartilhar Música';
  @override
  String get labelShareSongDescription => 'Compartilhar com amigos ou outras plataformas';
  @override
  String get labelEditTagsDescription => 'Abra as tags da ID3 e editor de capa';
  @override
  String get labelContains => 'Contém';
  @override
  String get labelPlaybackSpeed => 'Velocidade de Reprodução';
}
