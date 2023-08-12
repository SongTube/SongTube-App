import 'package:songtube/languages/languages.dart';

class LanguageZhCN extends Languages {

  // Introduction Screens
  @override
  String get labelAppWelcome => "欢迎来到";
  @override
  String get labelStart => "开始";
  @override
  String get labelSkip => "跳过";
  @override
  String get labelNext => "下一步";
  @override
  String get labelExternalAccessJustification =>
    "需要授权外部存储权限以保存 " +
    "你的视频与音乐";
  @override
  String get labelAppCustomization => "外观定制";
  @override
  String get labelSelectPreferred => "选择你喜欢的";
  @override
  String get labelConfigReady => "配置完成";
  @override
  String get labelIntroductionIsOver => "介绍到这路就结束了";
  @override
  String get labelEnjoy => "开始享受";
  @override 
  String get labelGoHome => "进入主页";

  // Bottom Navigation Bar
  @override
  String get labelHome => "主页";
  @override
  String get labelDownloads => "下载";
  @override
  String get labelMedia => "媒体";
  @override
  String get labelYouTube => "YouTube";
  @override
  String get labelMore => "更多";

  // Home Screen
  @override
  String get labelQuickSearch => "快速搜索...";
  @override
  String get labelTagsEditor => "编辑标签";
  @override
  String get labelEditArtwork => "编辑封面";
  @override
  String get labelDownloadAll => "下载全部";
  @override 
  String get labelLoadingVideos => "正在加载视频...";
  @override
  String get labelHomePage => "主页";
  @override
  String get labelTrending => "热门";
  @override
  String get labelFavorites => "收藏";
  @override
  String get labelWatchLater => "稍后观看";

  // Video Options Menu
  @override
  String get labelCopyLink => "复制链接";
  @override
  String get labelAddToFavorites => "添加至收藏";
  @override
  String get labelAddToWatchLater => "添加至稍后观看";
  @override
  String get labelAddToPlaylist => "添加至播放列表";

  // Downloads Screen
  @override
  String get labelQueued => "队列";
  @override
  String get labelDownloading => "下载中";
  @override
  String get labelConverting => "转换中";
  @override
  String get labelCancelled => "已取消";
  @override
  String get labelCompleted => "已完成";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "下载队列";
  @override
  String get labelDownloadAcesssDenied => "访问被拒绝";
  @override
  String get labelClearingExistingMetadata => "正在清除元数据...";
  @override
  String get labelWrittingTagsAndArtwork => "正在写入标签与封面...";
  @override
  String get labelSavingFile => "正在保存文件...";
  @override
  String get labelAndroid11FixNeeded => "错误，Android 11 需要修复，请检查设置";
  @override
  String get labelErrorSavingDownload => "不能保存已下载的文件，请检查权限";
  @override
  String get labelDownloadingVideo => "正在下载视频...";
  @override
  String get labelDownloadingAudio => "正在下载音频...";
  @override
  String get labelGettingAudioStream => "正在获取音频流...";
  @override
  String get labelAudioNoDataRecieved => "无法获取音频流";
  @override
  String get labelDownloadStarting => "开始下载...";
  @override
  String get labelDownloadCancelled => "下载已取消";
  @override
  String get labelAnIssueOcurredConvertingAudio => "转换失败";
  @override
  String get labelPatchingAudio => "正在应用音频补丁...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "启用音频转换";
  @override
  String get labelGainControls => "增益控制";
  @override
  String get labelVolume => "音量";
  @override
  String get labelBassGain => "低频增益";
  @override
  String get labelTrebleGain => "高频增益";
  @override
  String get labelSelectVideo => "选择视频";
  @override
  String get labelSelectAudio => "选择音频";
  @override
  String get labelGlobalParameters => "全局参数";

  // Media Screen
  @override
  String get labelMusic => "音乐";
  @override
  String get labelVideos => "视频";
  @override
  String get labelNoMediaYet => "还没有媒体";
  @override
  String get labelNoMediaYetJustification => "这里将显示你的所有媒体";
  @override
  String get labelSearchMedia => "搜索媒体...";
  @override
  String get labelDeleteSong => "删除歌曲";
  @override
  String get labelNoPermissionJustification => "授予权限以查看媒体";
  @override
  String get labelGettingYourMedia => "正在获取媒体...";
  @override
  String get labelEditTags => "编辑标签";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "搜索 YouTube...";

  // More Screen
  @override
  String get labelSettings => "设置";
  @override
  String get labelDonate => "捐赠";
  @override
  String get labelLicenses => "许可协议";
  @override
  String get labelChooseColor => "选择颜色";
  @override
  String get labelTheme => "主体";
  @override
  String get labelUseSystemTheme => "跟随系统";
  @override
  String get labelUseSystemThemeJustification =>
    "启用/禁用 跟随系统主题";
  @override
  String get labelEnableDarkTheme => "启用深色主题";
  @override
  String get labelEnableDarkThemeJustification =>
    "默认启用深色主题";
  @override
  String get labelEnableBlackTheme => "启用黑色主题";
  @override
  String get labelEnableBlackThemeJustification =>
    "启用纯黑色主题";
  @override
  String get labelAccentColor => "主色调";
  @override
  String get labelAccentColorJustification => "定制主色调";
  @override
  String get labelAudioFolder => "音频文件夹";
  @override
  String get labelAudioFolderJustification => "将下载的音频保存至";
  @override
  String get labelVideoFolder => "视频文件夹";
  @override
  String get labelVideoFolderJustification => "将下载的视频保存至";
  @override
  String get labelAlbumFolder => "专辑文件夹";
  @override
  String get labelAlbumFolderJustification => "为每个专辑创建独立的文件夹";
  @override
  String get labelDeleteCache => "清除缓存";
  @override
  String get labelDeleteCacheJustification => "清除 SongTube 缓存";
  @override
  String get labelAndroid11Fix => "Android 11 修复";
  @override
  String get labelAndroid11FixJustification => "修复 Android 10 & 11 的下载问题";
  @override
  String get labelBackup => "备份";
  @override
  String get labelBackupJustification => "备份你的媒体库";
  @override
  String get labelRestore => "恢复";
  @override
  String get labelRestoreJustification => "恢复你的媒体库";
  @override
  String get labelBackupLibraryEmpty => "媒体库为空";
  @override
  String get labelBackupCompleted => "备份完成";
  @override
  String get labelRestoreNotFound => "找不到可恢复的备份";
  @override
  String get labelRestoreCompleted => "恢复完成";
  @override
  String get labelCacheIsEmpty => "缓存为空";
  @override
  String get labelYouAreAboutToClear => "即将清除";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "标题";
  @override
  String get labelEditorArtist => "艺人";
  @override
  String get labelEditorGenre => "类型";
  @override
  String get labelEditorDisc => "唱片";
  @override
  String get labelEditorTrack => "曲目";
  @override
  String get labelEditorDate => "日期";
  @override
  String get labelEditorAlbum => "专辑";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "检查到系统为 Android 10 或 11";
  @override
  String get labelAndroid11DetectedJustification => "为了确保本应用正常下载" +
    "需要请求访问所有文件夹的权限 " +
    "这将是暂时性的，可能会在未来的更新中修复 " +
    "你也可以在设置中应用此修复。";

  // Music Player
  @override
  String get labelPlayerSettings => "播放器设置";
  @override
  String get labelExpandArtwork => "展开封面图";
  @override
  String get labelArtworkRoundedCorners => "圆角封面图";
  @override
  String get labelPlayingFrom => "播放来自";
  @override
  String get labelBlurBackground => "模糊背景";

  // Video Page
  @override
  String get labelTags => "标签";
  @override
  String get labelRelated => "相关的";
  @override
  String get labelAutoPlay => "自动播放";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible =>
    "不兼容此音频格式";
  @override
  String get labelNotSpecified => "未指定";
  @override
  String get labelPerformAutomaticTagging => 
    "执行自动标签";
  @override
  String get labelSelectTagsfromMusicBrainz => 
    "从MusicBrainz选择标签";
  @override
  String get labelSelectArtworkFromDevice =>
    "从设备中选择封面图";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "加入 Telegram 频道！";
  @override
  String get labelJoinTelegramJustification =>
    "你喜欢 SongTube吗？ 欢迎加入我们的 Telegram 频道！ 你可以在这里找到 " +
    "关于 更新，信息，开发，群组链接 以及其他资讯！" +
    "\n\n" +
    "如果你有任何问题，意见或建议 " +
    "请通过频道内的连接加入我们的群组，告诉我们！ " +
    "但请注意，只能通过英语交流，非常感谢！";
  @override
  String get labelRemindLater => "稍后提醒";

  // Common Words (One word labels)
  @override
  String get labelExit => "退出";
  @override
  String get labelSystem => "系统";
  @override
  String get labelChannel => "频道";
  @override
  String get labelShare => "分享";
  @override
  String get labelAudio => "音频";
  @override
  String get labelVideo => "视频";
  @override
  String get labelDownload => "下载";
  @override
  String get labelBest => "精选";
  @override
  String get labelPlaylist => "播放列表";
  @override
  String get labelVersion => "版本";
  @override
  String get labelLanguage => "语言";
  @override
  String get labelGrant => "授予";
  @override
  String get labelAllow => "允许";
  @override
  String get labelAccess => "访问";
  @override
  String get labelEmpty => "这里什么都没有";
  @override
  String get labelCalculating => "计算中";
  @override
  String get labelCleaning => "清理中";
  @override
  String get labelCancel => "取消";
  @override
  String get labelGeneral => "通用";
  @override
  String get labelRemove => "删除";
  @override
  String get labelJoin => "加入";
  @override
  String get labelNo => "不";
  @override
  String get labelLibrary => "库";
  @override
  String get labelCreate => "创建";
  @override
  String get labelPlaylists => "播放列表";
  @override
  String get labelQuality => "品质";
  @override
  String get labelSubscribe => "订阅";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => '没有已收藏的视频';
  @override
  String get labelNoFavoriteVideosDescription => '这里将会出现已收藏的视频';
  @override
  String get labelNoSubscriptions => '没有已订阅的内容';
  @override
  String get labelNoSubscriptionsDescription => '点击上面的按钮显示推荐的频道！';
  @override
  String get labelNoPlaylists => '没有播放列表';
  @override
  String get labelNoPlaylistsDescription => '这里将会出现已保存的视频或播放列表';
  @override
  String get labelSearch => '搜索';
  @override
  String get labelSubscriptions => '订阅';
  @override
  String get labelNoDownloadsCanceled => '没有已取消的下载任务';
  @override
  String get labelNoDownloadsCanceledDescription => '好消息！如果您取消下载或下载时出现问题，您可以从这里查看';
  @override
  String get labelNoDownloadsYet => '没有已下载的内容';
  @override
  String get labelNoDownloadsYetDescription => '可以搜索一些你感兴趣的内容并下载，他们将会出现在此处';
  @override
  String get labelYourQueueIsEmpty => '你的队列为空';
  @override
  String get labelYourQueueIsEmptyDescription => '可以尝试搜索并下载您感兴趣的内容';
  @override
  String get labelQueue => '队列';
  @override
  String get labelSearchDownloads => '搜索下载的内容';
  @override
  String get labelWatchHistory => '查看历史记录';
  @override
  String get labelWatchHistoryDescription => '查看你已经看过的视频';
  @override
  String get labelBackupAndRestore => '备份与恢复';
  @override
  String get labelBackupAndRestoreDescription => '保存或恢复你的本地数据';
  @override
  String get labelSongtubeLink => 'SongTube 链接';
  @override
  String get labelSongtubeLinkDescription => '允许SongTube浏览器扩展检测此设备，长按了解更多信息';
  @override
  String get labelSupportDevelopment => '开发与支持';
  @override
  String get labelSocialLinks => '社交账户链接';
  @override
  String get labelSeeMore => '查看更多';
  @override
  String get labelMostPlayed => '最多播放';
  @override
  String get labelNoPlaylistsYet => '还没有播放列表';
  @override
  String get labelNoPlaylistsYetDescription => '您可以根据最近的作品、音乐、专辑或艺术家创建播放列表';
  @override
  String get labelNoSearchResults => '没有搜索结果';
  @override
  String get labelSongResults => '歌曲的搜索结果';
  @override
  String get labelAlbumResults => '专辑的搜索结果';
  @override
  String get labelArtistResults => '艺术家的搜索结果';
  @override
  String get labelSearchAnything => '搜索任何内容';
  @override
  String get labelRecents => '最近的';
  @override
  String get labelFetchingSongs => '正在扫描歌曲';
  @override
  String get labelPleaseWaitAMoment => '请稍等';
  @override
  String get labelWeAreDone => '已完成';
  @override
  String get labelEnjoyTheApp => '使用愉快';
  @override
  String get labelSongtubeIsBackDescription => 'SongTube 已回归！更干净的外观和一系列功能，尽情享受音乐吧！';
  @override
  String get labelLetsGo => '开始吧';
  @override
  String get labelPleaseWait => '请稍等';
  @override
  String get labelPoweredBy => 'Powered by';
  @override
  String get labelGetStarted => '开始';
  @override
  String get labelAllowUsToHave => '允许我们获取';
  @override
  String get labelStorageRead => '访问\n存储';
  @override
  String get labelStorageReadDescription => '这将扫描您的音乐，提取高质量的艺术品，并允许您个性化您的音乐';
  @override
  String get labelContinue => '继续';
  @override
  String get labelAllowStorageRead => '允许访问存储';
  @override
  String get labelSelectYourPreferred => '选择您的首选';
  @override
  String get labelLight => '亮';
  @override
  String get labelDark => '暗';
  @override
  String get labelSimultaneousDownloads => '多线程下载';
  @override
  String get labelSimultaneousDownloadsDescription => '设置同时允许下载的内容数量';
  @override
  String get labelItems => '项目';
  @override
  String get labelInstantDownloadFormat => '即时下载';
  @override
  String get labelInstantDownloadFormatDescription => '更改即时下载的音频格式';
  @override
  String get labelCurrent => '当前的';
  @override
  String get labelPauseWatchHistory => '暂停记录播放历史';
  @override
  String get labelPauseWatchHistoryDescription => '暂停时，播放的历史记录不会保存到历史记录列表中';
  @override
  String get labelLockNavigationBar => '锁定导航栏';
  @override
  String get labelLockNavigationBarDescription => '锁定导航栏，使其不会在滚动时自动隐藏和显示';
  @override
  String get labelPictureInPicture => '画中画';
  @override
  String get labelPictureInPictureDescription => '观看视频时点击主页按钮自动进入画中画模式';
  @override
  String get labelBackgroundPlaybackAlpha => '背景播放（实验性）';
  @override
  String get labelBackgroundPlaybackAlphaDescription => '切换背景播放功能。由于插件的限制，只能在后台播放当前视频';
  @override
  String get labelBlurBackgroundDescription => '开启播放界面背景模糊';
  @override
  String get labelBlurIntensity => '模糊强度';
  @override
  String get labelBlurIntensityDescription => '调整播放界面背景模糊强度';
  @override
  String get labelBackdropOpacity => '背景不透明度';
  @override
  String get labelBackdropOpacityDescription => '更改背景不透明度';
  @override
  String get labelArtworkShadowOpacity => '更改封面阴影不透明度';
  @override
  String get labelArtworkShadowOpacityDescription => '更改音乐播放器的封面阴影强度';
  @override
  String get labelArtworkShadowRadius => '封面阴影半径';
  @override
  String get labelArtworkShadowRadiusDescription => '更改音乐播放器的封面阴影半径';
  @override
  String get labelArtworkScaling => '封面缩放';
  @override
  String get labelArtworkScalingDescription => '调整音乐播放器的封面和背景图像的缩放';
  @override
  String get labelBackgroundParallax => '背景视差';
  @override
  String get labelBackgroundParallaxDescription =>  '启用或禁用背景图像视差效果';
  @override
  String get labelRestoreThumbnails => '恢复缩略图';
  @override
  String get labelRestoreThumbnailsDescription => '强制生成封面略缩图';
  @override
  String get labelRestoringArtworks => '恢复封面';
  @override
  String get labelRestoringArtworksDone => '恢复封面完成';
  @override
  String get labelHomeScreen => '主页';
  @override
  String get labelHomeScreenDescription => '打开App时更改默认显示的页面';
  @override
  String get labelDefaultMusicPage => '进入音乐页面时默认显示的选项卡页面';
  @override
  String get labelDefaultMusicPageDescription => '更改音乐页面的默认选项卡页面';
  @override
  String get labelAbout => '关于';
  @override
  String get labelConversionRequired => '需要转换';
  @override
  String get labelConversionRequiredDescription =>  '此歌曲格式与ID3标签编辑器不兼容。该应用程序将自动将此音乐文件转换为AAC（m4a）以解决此问题。';
  @override
  String get labelPermissionRequired => '需要权限';
  @override
  String get labelPermissionRequiredDescription => 'SongTube 编辑设备上的任何歌曲都需要所有文件访问权限';
  @override
  String get labelApplying => '应用中';
  @override
  String get labelConvertingDescription => '将这首歌重新编码为AAC（m4a）格式';
  @override
  String get labelWrittingTagsAndArtworkDescription => '为此歌曲设置新标签';
  @override
  String get labelApply => '应用';
  @override
  String get labelSongs => '歌曲';
  @override
  String get labelPlayAll => '播放所有';
  @override
  String get labelPlaying => '播放中';
  @override
  String get labelPages => '页面';
  @override
  String get labelMusicPlayer => '音乐播放器';
  @override
  String get labelClearWatchHistory => '清除播放历史记录';
  @override
  String get labelClearWatchHistoryDescription =>  '您即将删除所有观看播放记录视频，此操作无法撤消，是否继续？';
  @override
  String get labelDelete => '删除';
  @override
  String get labelAppUpdate => 'App 更新';
  @override
  String get labelWhatsNew => '新增功能';
  @override
  String get labelLater => '稍后';
  @override
  String get labelUpdate => '更新';
  @override
  String get labelUnsubscribe => '取消订阅';
  @override
  String get labelAudioFeatures => '音频功能';
  @override
  String get labelVolumeBoost => '音量提升';
  @override
  String get labelNormalizeAudio => '规格化音频';
  @override
  String get labelSegmentedDownload => '分段下载';
  @override
  String get labelEnableSegmentedDownload => '启用分段下载';
  @override
  String get labelEnableSegmentedDownloadDescription => '这将下载整个音频文件，然后从下面的列表中将其拆分为各种启用的片段（或音轨）';
  @override
  String get labelCreateMusicPlaylist => '创建音乐播放列表';
  @override
  String get labelCreateMusicPlaylistDescription => '从所有下载和保存的音频片段创建音乐播放列表';
  @override
  String get labelApplyTags => '应用标签';
  @override
  String get labelApplyTagsDescription => '从MusicBrainz中提取所有片段的标签';
  @override
  String get labelLoading => '加载中';
  @override
  String get labelMusicDownloadDescription => '选择质量，转换并只下载音频';
  @override
  String get labelVideoDownloadDescription =>  '从列表中选择视频质量并下载';
  @override
  String get labelInstantDescription => '立即开始下载音乐';
  @override
  String get labelInstant => '即时';
  @override
  String get labelCurrentQuality => '当前质量';
  @override
  String get labelFastStreamingOptions => '快速流媒体选项';
  @override
  String get labelStreamingOptions => '流选项';
  @override
  String get labelComments => '评论';
  @override
  String get labelPinned => '固定';
  @override
  String get labelLikedByAuthor => '作者喜欢的';
  @override
  String get labelDescription => '描述';
  @override
  String get labelViews => '查看';
  @override
  String get labelPlayingNextIn => '接下来播放';
  @override
  String get labelPlayNow => '现在播放';
  @override
  String get labelLoadingPlaylist => '正在加载播放列表';
  @override
  String get labelPlaylistReachedTheEnd => '播放列表已结束';
  @override
  String get labelLiked => '喜欢';
  @override
  String get labelLike => '喜欢';
  @override
  String get labelVideoRemovedFromFavorites => '将视频从收藏夹中移除';
  @override
  String get labelVideoAddedToFavorites => '视频已添加至收藏夹';
  @override
  String get labelPopupMode => '弹出模式';
  @override
  String get labelDownloaded => '已下载';
  @override
  String get labelShowPlaylist => '显示播放列表';
  @override
  String get labelCreatePlaylist => '创建播放列表';
  @override
  String get labelAddVideoToPlaylist => '将视频添加到播放列表';
  @override
  String get labelBackupDescription => '将所有本地数据备份到一个文件中，以便以后进行恢复';
  @override
  String get labelBackupCreated => '创建的备份';
  @override
  String get labelBackupRestored => '备份恢复';
  @override
  String get labelRestoreDescription => '从备份文件中恢复所有数据';
  @override
  String get labelChannelSuggestions => '推荐的频道';
  @override
  String get labelFetchingChannels => '加载频道';
  @override
  String get labelShareVideo => '分享视频';
  @override
  String get labelShareDescription => '分享给朋友或分享至其他平台';
  @override
  String get labelRemoveFromPlaylists => '从播放列表移除';
  @override
  String get labelThisActionCannotBeUndone => '此操作不能撤消';
  @override
  String get labelAddVideoToPlaylistDescription => '添加到现有或新的视频播放列表';
  @override
  String get labelAddToPlaylists => '添加到播放列表';
  @override
  String get labelEditableOnceSaved => '保存后可编辑';
  @override
  String get labelPlaylistRemoved => '播放列表已删除';
  @override
  String get labelPlaylistSaved => '播放列表已保存';
  @override
  String get labelRemoveFromFavorites => '从收藏夹中删除';
  @override
  String get labelRemoveFromFavoritesDescription => '从收藏夹中移除此视频';
  @override
  String get labelSaveToFavorites => '保存到收藏夹';
  @override
  String get labelSaveToFavoritesDescription => '将视频添加到您的收藏列表中';
  @override
  String get labelSharePlaylist => '分享播放列表';
  @override
  String get labelRemoveThisVideoFromThisList => '从这个列表中移除这个视频';
  @override
  String get labelEqualizer => '均衡器';
  @override
  String get labelLoudnessEqualizationGain => '响度均衡增益';
  @override
  String get labelSliders => '滑块';
  @override
  String get labelSave => '保存';
  @override
  String get labelPlaylistName => '播放列表名称';
  @override
  String get labelCreateVideoPlaylist => '创建视频播放列表';
  @override
  String get labelSearchFilters => '搜索过滤器';
  @override
  String get labelAddToPlaylistDescription => '添加到现有或新播放列表';
  @override
  String get labelShareSong => '分享歌曲';
  @override
  String get labelShareSongDescription => '将歌曲分享给朋友或分享至其他平台';
  @override
  String get labelEditTagsDescription => '打开ID3标签和封面编辑器';
  @override
  String get labelContains => '包含';
  @override
  String get labelPlaybackSpeed => '回放速度';
}