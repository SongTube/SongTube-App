import 'package:songtube/internal/languages.dart';

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
  String get labelAppCustomization => "Personalização";
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
  String get labelAccess => "Acessar";
  @override
  String get labelEmpty => "Vazio";
  @override
  String get labelCalculating => "Calculando";
  @override
  String get labelCleaning => "Limpando";
  @override
  String get labelCancel => "Cancelar";

}