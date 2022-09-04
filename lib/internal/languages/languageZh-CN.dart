import 'package:songtube/internal/languages.dart';

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
  String get labelRestore => "回复";
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
}