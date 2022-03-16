import 'package:songtube/internal/languages.dart';

class LanguageCn extends Languages {
  // Introduction Screens
  @override
  String get labelAppWelcome => "欢迎使用";
  @override
  String get labelStart => "开始";
  @override
  String get labelSkip => "跳过";
  @override
  String get labelNext => "下一个";
  @override
  String get labelExternalAccessJustification => "请授予内存权限以储存视频和音乐";
  @override
  String get labelAppCustomization => "客制化";
  @override
  String get labelSelectPreferred => "请选择喜欢的";
  @override
  String get labelConfigReady => "配置已保存";
  @override
  String get labelIntroductionIsOver => "简介到此结束";
  @override
  String get labelEnjoy => "希望您喜欢";
  @override
  String get labelGoHome => "回到主页";

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
  String get labelQuickSearch => "搜索...";
  @override
  String get labelTagsEditor => "标签编辑器";
  @override
  String get labelEditArtwork => "编辑封面图";
  @override
  String get labelDownloadAll => "下载全部";
  @override
  String get labelLoadingVideos => "正在缓冲视频...";
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
  String get labelAddToFavorites => "加入收藏";
  @override
  String get labelAddToWatchLater => "加入稍后观看";
  @override
  String get labelAddToPlaylist => "加入播放列表";

  // Downloads Screen
  @override
  String get labelQueued => "等待列表";
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
  String get labelDownloadQueued => "等待下载";
  @override
  String get labelDownloadAcesssDenied => "拒绝访问";
  @override
  String get labelClearingExistingMetadata => "正在清除元数据...";
  @override
  String get labelWrittingTagsAndArtwork => "正在填写标签和封面图...";
  @override
  String get labelSavingFile => "正在保存文件...";
  @override
  String get labelAndroid11FixNeeded => "异常, 需使用安卓11补丁, 请检查设置";
  @override
  String get labelErrorSavingDownload => "无法保存下载, 请检查权限";
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
  String get labelPatchingAudio => "正在补丁音频...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "启用音频转换";
  @override
  String get labelGainControls => "增益控制";
  @override
  String get labelVolume => "音量";
  @override
  String get labelBassGain => "低音增益";
  @override
  String get labelTrebleGain => "高音增益";
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
  String get labelNoMediaYet => "无媒体";
  @override
  String get labelNoMediaYetJustification => "这里将显示所有媒体";
  @override
  String get labelSearchMedia => "搜索媒体...";
  @override
  String get labelDeleteSong => "删除歌曲";
  @override
  String get labelNoPermissionJustification => "请授予内存权限以查看媒体";
  @override
  String get labelGettingYourMedia => "正在获取媒体...";
  @override
  String get labelEditTags => "编辑标签";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "搜索YouTube...";

  // More Screen
  @override
  String get labelSettings => "设置";
  @override
  String get labelDonate => "捐款";
  @override
  String get labelLicenses => "许可";
  @override
  String get labelChooseColor => "选择颜色";
  @override
  String get labelTheme => "主题";
  @override
  String get labelUseSystemTheme => "跟随系统主题";
  @override
  String get labelUseSystemThemeJustification => "打开/关闭自动跟随系统主题";
  @override
  String get labelEnableDarkTheme => "启用深色主题";
  @override
  String get labelEnableDarkThemeJustification => "默认启用深色主题";
  @override
  String get labelEnableBlackTheme => "启用黑色主题";
  @override
  String get labelEnableBlackThemeJustification => "启用全黑主题";
  @override
  String get labelAccentColor => "强调色";
  @override
  String get labelAccentColorJustification => "自定义强调色";
  @override
  String get labelAudioFolder => "音频文件夹";
  @override
  String get labelAudioFolderJustification => "选择文件夹保存音频下载";
  @override
  String get labelVideoFolder => "视频文件夹";
  @override
  String get labelVideoFolderJustification => "选择文件夹保存视频下载";
  @override
  String get labelAlbumFolder => "专辑文件夹";
  @override
  String get labelAlbumFolderJustification => "为每个专辑创建文件夹";
  @override
  String get labelDeleteCache => "删除缓存";
  @override
  String get labelDeleteCacheJustification => "清理SongTube缓存";
  @override
  String get labelAndroid11Fix => "安卓11补丁";
  @override
  String get labelAndroid11FixJustification => "修复安卓10 & 11的下载问题";
  @override
  String get labelBackup => "备份";
  @override
  String get labelBackupJustification => "备份媒体库";
  @override
  String get labelRestore => "恢复";
  @override
  String get labelRestoreJustification => "恢复媒体库";
  @override
  String get labelBackupLibraryEmpty => "媒体库无内容";
  @override
  String get labelBackupCompleted => "备份完成";
  @override
  String get labelRestoreNotFound => "找不到可恢复的备份";
  @override
  String get labelRestoreCompleted => "恢复完成";
  @override
  String get labelCacheIsEmpty => "无缓存";
  @override
  String get labelYouAreAboutToClear => "即将清除";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "标题";
  @override
  String get labelEditorArtist => "艺人";
  @override
  String get labelEditorGenre => "体裁";
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
  String get labelAndroid11Detected => "检测出安卓10/11";
  @override
  String get labelAndroid11DetectedJustification =>
      "为确保下载功能能正常运行于安卓10/11, " +
      "请暂且授予所有的内存权限。" +
      "这是暂且的方案, " +
      "未来更新后将不再需要。此补丁也可于设置中启用";

  // Music Player
  @override
  String get labelPlayerSettings => "播放器设置";
  @override
  String get labelExpandArtwork => "展开封面图";
  @override
  String get labelArtworkRoundedCorners => "圆角封面图";
  @override
  String get labelPlayingFrom => "播放始于";
  @override
  String get labelBlurBackground => "虚化背景";

  // Video Page
  @override
  String get labelTags => "标签";
  @override
  String get labelRelated => "相关的";
  @override
  String get labelAutoPlay => "自动播放";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible => "不兼容此音乐格式";
  @override
  String get labelNotSpecified => "未指定";
  @override
  String get labelPerformAutomaticTagging => "执行自动标签";
  @override
  String get labelSelectTagsfromMusicBrainz => "从MusicBrainz选择标签";
  @override
  String get labelSelectArtworkFromDevice => "从设备选择封面图";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "加入Telegram频道!";
  @override
  String get labelJoinTelegramJustification =>
      "喜欢SongTube吗? 欢迎加入我们的Telegram频道!" +
      "任何更新, 资讯, 开发相关资讯, 群组链接, 及其他社交媒体链接都将在里面公布。" +
      "\n\n" +
      "如果您遇到了问题, 或是有任何相关建议, " +
      "请通过频道里的群组链家加入群组, 然后告诉我们吧! 但是请注意，" +
      "只能以英语沟通哦, 感谢!";
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
  String get labelEmpty => "空空如也";
  @override
  String get labelCalculating => "计算中";
  @override
  String get labelCleaning => "清理中";
  @override
  String get labelCancel => "取消";
  @override
  String get labelGeneral => "通用";
  @override
  String get labelRemove => "清除";
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
