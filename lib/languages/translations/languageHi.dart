import 'package:songtube/languages/languages.dart';

class LanguageHi extends Languages {
  // Introduction Screens
  @override
  String get labelAppWelcome => "आपका स्वागत है";
  @override
  String get labelStart => "शुरू";
  @override
  String get labelSkip => "छोड़ें";
  @override
  String get labelNext => "आगे";
  @override
  String get labelExternalAccessJustification =>
      "आपके वीडियो और संगीत को सेव करने के लिए आपके बाह्य संग्रहण का उपयोग करने की आवश्यकता है";
  @override
  String get labelAppCustomization => "कस्टमाइज़ेशन";
  @override
  String get labelSelectPreferred => "अपना पसंदीदा चयन करें";
  @override
  String get labelConfigReady => "कॉन्फ़िग तैयार";
  @override
  String get labelIntroductionIsOver => "परिचय समाप्त हो गया है";
  @override
  String get labelEnjoy => "आनंद लें";
  @override
  String get labelGoHome => "घर जाएं";

  // Bottom Navigation Bar
  @override
  String get labelHome => "होम";
  @override
  String get labelDownloads => "डाउनलोड";
  @override
  String get labelMedia => "मीडिया";
  @override
  String get labelYouTube => "यूट्यूब";
  @override
  String get labelMore => "अधिक";

  // Home Screen
  @override
  String get labelQuickSearch => "त्वरित खोज...";
  @override
  String get labelTagsEditor => "टैग्स संपादक";
  @override
  String get labelEditArtwork => "कला संपादित करें";
  @override
  String get labelDownloadAll => "सभी को डाउनलोड करें";
  @override
  String get labelLoadingVideos => "वीडियो लोड हो रहा है...";
  @override
  String get labelHomePage => "होम पेज";
  @override
  String get labelTrending => "ट्रेंडिंग";
  @override
  String get labelFavorites => "पसंदीदा";
  @override
  String get labelWatchLater => "बाद में देखें";

  // Video Options Menu
  @override
  String get labelCopyLink => "लिंक कॉपी करें";
  @override
  String get labelAddToFavorites => "पसंदीदा में जोड़ें";
  @override
  String get labelAddToWatchLater => "बाद में देखने के लिए जोड़ें";
  @override
  String get labelAddToPlaylist => "प्लेलिस्ट में जोड़ें";

  // Downloads Screen
  @override
  String get labelQueued => "कतार में";
  @override
  String get labelDownloading => "डाउनलोड हो रहा है";
  @override
  String get labelConverting => "रूपांतरित कर रहा है";
  @override
  String get labelCancelled => "रद्द";
  @override
  String get labelCompleted => "पूर्ण";

  // Download Status/Error Messages
  @override
  String get labelDownloadQueued => "डाउनलोड कतार में";
  @override
  String get labelDownloadAcesssDenied => "पहुंच अस्वीकृत";
  @override
  String get labelClearingExistingMetadata =>
      "मौजूदा मेटाडेटा को साफ कर रहा है...";
  @override
  String get labelWrittingTagsAndArtwork => "टैग और कला लिख रहा है...";
  @override
  String get labelSavingFile => "फ़ाइल सहेज रहा है...";
  @override
  String get labelAndroid11FixNeeded =>
      "त्रुटि, Android 11 फिक्स आवश्यक है, सेटिंग्स की जाँच करें";
  @override
  String get labelErrorSavingDownload =>
      "आपका डाउनलोड सहेजा नहीं जा सका, अनुमतियाँ जाँचें";
  @override
  String get labelDownloadingVideo => "वीडियो डाउनलोड हो रहा है...";
  @override
  String get labelDownloadingAudio => "ऑडियो डाउनलोड हो रहा है...";
  @override
  String get labelGettingAudioStream => "ऑडियो स्ट्रीम प्राप्त कर रहा है...";
  @override
  String get labelAudioNoDataRecieved => "ऑडियो स्ट्रीम प्राप्त नहीं हो सका";
  @override
  String get labelDownloadStarting => "डाउनलोड शुरू हो रहा है...";
  @override
  String get labelDownloadCancelled => "डाउनलोड रद्द कर दिया गया है";
  @override
  String get labelAnIssueOcurredConvertingAudio =>
      "ऑडियो कन्वर्ट करने में समस्या आई";
  @override
  String get labelPatchingAudio => "ऑडियो पैच कर रहे हैं...";

  // Download Menu
  @override
  String get labelEnableAudioConversion => "ऑडियो कन्वर्शन सक्षम करें";
  @override
  String get labelGainControls => "गेन कंट्रोल्स";
  @override
  String get labelVolume => "वॉल्यूम";
  @override
  String get labelBassGain => "बास गेन";
  @override
  String get labelTrebleGain => "ट्रेबल गेन";
  @override
  String get labelSelectVideo => "वीडियो चुनें";
  @override
  String get labelSelectAudio => "ऑडियो चुनें";
  @override
  String get labelGlobalParameters => "ग्लोबल पैरामीटर्स";

  // Media Screen
  @override
  String get labelMusic => "संगीत";
  @override
  String get labelVideos => "वीडियो";
  @override
  String get labelNoMediaYet => "अभी तक कोई मीडिया नहीं";
  @override
  String get labelNoMediaYetJustification =>
      "आपका सभी मीडिया यहाँ दिखाया जाएगा";
  @override
  String get labelSearchMedia => "मीडिया खोजें...";
  @override
  String get labelDeleteSong => "गाना हटाएं";
  @override
  String get labelNoPermissionJustification =>
      "अपने मीडिया को देखें\nस्टोरेज अनुमति प्रदान करके";
  @override
  String get labelGettingYourMedia => "आपका मीडिया मिल रहा है...";
  @override
  String get labelEditTags => "टैग संपादित करें";

  // Navigate Screen
  @override
  String get labelSearchYoutube => "YouTube खोजें...";

  // More Screen
  @override
  String get labelSettings => "सेटिंग्स";
  @override
  String get labelDonate => "दान करें";
  @override
  String get labelLicenses => "लाइसेंस";
  @override
  String get labelChooseColor => "रंग चुनें";
  @override
  String get labelTheme => "थीम";
  @override
  String get labelUseSystemTheme => "सिस्टम थीम का उपयोग करें";
  @override
  String get labelUseSystemThemeJustification =>
      "स्वचालित थीम सक्षम/अक्षम करें";
  @override
  String get labelEnableDarkTheme => "डार्क थीम सक्षम करें";
  @override
  String get labelEnableDarkThemeJustification =>
      "डार्क थीम को डिफ़ॉल्ट रूप से उपयोग करें";
  @override
  String get labelEnableBlackTheme => "ब्लैक थीम सक्षम करें";
  @override
  String get labelEnableBlackThemeJustification => "प्योर ब्लैक थीम सक्षम करें";
  @override
  String get labelAccentColor => "ऐक्सेंट कलर";
  @override
  String get labelAccentColorJustification => "ऐक्सेंट कलर कस्टमाइज़ करें";
  @override
  String get labelAudioFolder => "ऑडियो फ़ोल्डर";
  @override
  String get labelAudioFolderJustification =>
      "ऑडियो डाउनलोड के लिए एक फ़ोल्डर चुनें";
  @override
  String get labelVideoFolder => "वीडियो फ़ोल्डर";
  @override
  String get labelVideoFolderJustification =>
      "वीडियो डाउनलोड के लिए एक फ़ोल्डर चुनें";
  @override
  String get labelAlbumFolder => "एल्बम फ़ोल्डर";
  @override
  String get labelAlbumFolderJustification =>
      "प्रत्येक गाने के एल्बम के लिए एक फ़ोल्डर बनाएं";
  @override
  String get labelDeleteCache => "कैश हटाएं";
  @override
  String get labelDeleteCacheJustification => "सॉन्गट्यूब कैश को साफ करें";
  @override
  String get labelAndroid11Fix => "Android 11 फ़िक्स";
  @override
  String get labelAndroid11FixJustification =>
      "Android 10 और 11 पर डाउनलोड समस्याओं को ठीक करता है";
  @override
  String get labelBackup => "बैकअप";
  @override
  String get labelBackupJustification => "अपनी मीडिया लाइब्रेरी का बैकअप बनाएं";
  @override
  String get labelRestore => "पुनर्स्थापन";
  @override
  String get labelRestoreJustification =>
      "अपनी मीडिया लाइब्रेरी को पुनर्स्थापित करें";
  @override
  String get labelBackupLibraryEmpty => "आपकी लाइब्रेरी खाली है";
  @override
  String get labelBackupCompleted => "बैकअप पूरा हुआ";
  @override
  String get labelRestoreNotFound => "पुनर्स्थापन नहीं मिला";
  @override
  String get labelRestoreCompleted => "पुनर्स्थापन पूरा हुआ";
  @override
  String get labelCacheIsEmpty => "कैश खाली है";
  @override
  String get labelYouAreAboutToClear => "आपके बारे में है कि आप साफ कर रहे हैं";

  // Tags Editor TextFields
  @override
  String get labelEditorTitle => "शीर्षक";
  @override
  String get labelEditorArtist => "कलाकार";
  @override
  String get labelEditorGenre => "शैली";
  @override
  String get labelEditorDisc => "डिस्क";
  @override
  String get labelEditorTrack => "ट्रैक";
  @override
  String get labelEditorDate => "तारीख";
  @override
  String get labelEditorAlbum => "एल्बम";

  // Android 10 or 11 Detected Dialog
  @override
  String get labelAndroid11Detected => "Android 10 या 11 का पता लगा";
  @override
  String get labelAndroid11DetectedJustification =>
      "इस एप्लिकेशन डाउनलोड की सही कार्रवाई के लिए, Android 10 और 11 पर, सभी फ़ाइलों की पहुँच की अनुमति की जरूरत हो सकती है, यह अस्थायी होगा और भविष्य के अपडेट्स पर आवश्यक नहीं होगा। आप इसे सेटिंग्स में भी सुधार सकते हैं।";

  // Music Player
  @override
  String get labelPlayerSettings => "प्लेयर सेटिंग्स";
  @override
  String get labelExpandArtwork => "कला को बढ़ाएँ";
  @override
  String get labelArtworkRoundedCorners => "कला के गोल कोने";
  @override
  String get labelPlayingFrom => "से चला रहा है";
  @override
  String get labelBlurBackground => "पृष्ठभूमि को धुंधला करें";

  // Video Page
  @override
  String get labelTags => "टैग";
  @override
  String get labelRelated => "संबंधित";
  @override
  String get labelAutoPlay => "ऑटोप्ले";

  // Tags Pages
  @override
  String get labelAudioFormatNotCompatible => "ऑडियो फ़ॉर्मेट संगत नहीं है";
  @override
  String get labelNotSpecified => "उल्लेख नहीं किया गया";
  @override
  String get labelPerformAutomaticTagging => "स्वचालित टैगिंग करें";
  @override
  String get labelSelectTagsfromMusicBrainz => "म्यूजिकब्रेन्स से टैग चुनें";
  @override
  String get labelSelectArtworkFromDevice => "डिवाइस से कला चुनें";

  // Telegram Join Channel Dialog
  @override
  String get labelJoinTelegramChannel => "टेलीग्राम चैनल में शामिल हों!";
  @override
  String get labelJoinTelegramJustification =>
      "क्या आपको सॉन्गट्यूब पसंद है? कृपया टेलीग्राम चैनल में शामिल हों! " +
      "यहाँ आप अपडेट्स, जानकारी, विकास, समूह लिंक और अन्य सोशल लिंक पा सकते हैं।" +
      "\n\n" +
      "यदि आपके पास कोई समस्या है या आपके दिमाग में कोई शानदार सुझाव है, " +
      "तो कृपया चैनल से समूह में शामिल हों और यह लिखें! लेकिन ध्यान रखें " +
      "कि आप केवल अंग्रेजी में बात कर सकते हैं, धन्यवाद!";
  @override
  String get labelRemindLater => "बाद में याद दिलाएं";

  // Common Words (One word labels)
  @override
  String get labelExit => "बाहर निकलें";
  @override
  String get labelSystem => "सिस्टम";
  @override
  String get labelChannel => "चैनल";
  @override
  String get labelShare => "साझा करें";
  @override
  String get labelAudio => "ऑडियो";
  @override
  String get labelVideo => "वीडियो";
  @override
  String get labelDownload => "डाउनलोड";
  @override
  String get labelBest => "सर्वश्रेष्ठ";
  @override
  String get labelPlaylist => "प्लेलिस्ट";
  @override
  String get labelVersion => "संस्करण";
  @override
  String get labelLanguage => "भाषा";
  @override
  String get labelGrant => "अनुमति दें";
  @override
  String get labelAllow => "अनुमति";
  @override
  String get labelAccess => "पहुँच";
  @override
  String get labelEmpty => "खाली";
  @override
  String get labelCalculating => "गणना हो रही है";
  @override
  String get labelCleaning => "सफाई";
  @override
  String get labelCancel => "रद्द करें";
  @override
  String get labelGeneral => "सामान्य";
  @override
  String get labelRemove => "हटाएं";
  @override
  String get labelJoin => "शामिल हों";
  @override
  String get labelNo => "नहीं";
  @override
  String get labelLibrary => "लाइब्रेरी";
  @override
  String get labelCreate => "बनाएं";
  @override
  String get labelPlaylists => "प्लेलिस्ट";
  @override
  String get labelQuality => "गुणवत्ता";
  @override
  String get labelSubscribe => "सब्सक्राइब";

  // Other Translations
  @override
  String get labelNoFavoriteVideos => 'कोई पसंदीदा वीडियो नहीं';
  @override
  String get labelNoFavoriteVideosDescription =>
      'वीडियो खोजें और उन्हें पसंदीदा के रूप में सहेजें। वे यहाँ दिखाए जाएंगे';
  @override
  String get labelNoSubscriptions => 'कोई सदस्यता नहीं';
  @override
  String get labelNoSubscriptionsDescription =>
      'सुझाए गए चैनल दिखाने के लिए ऊपर दिए गए बटन पर टैप करें!';
  @override
  String get labelNoPlaylists => 'कोई प्लेलिस्ट नहीं';
  @override
  String get labelNoPlaylistsDescription =>
      'वीडियो या प्लेलिस्ट खोजें और उन्हें सहेजें। वे यहाँ दिखाए जाएंगे';
  @override
  String get labelSearch => 'खोजें';
  @override
  String get labelSubscriptions => 'सदस्यता';
  @override
  String get labelNoDownloadsCanceled => 'कोई डाउनलोड रद्द नहीं हुआ';
  @override
  String get labelNoDownloadsCanceledDescription =>
      'अच्छी खबर! लेकिन यदि आप डाउनलोड को रद्द करते हैं या कुछ गलत हो जाता है, तो आप यहाँ से जांच सकते हैं';
  @override
  String get labelNoDownloadsYet => 'अब तक कोई डाउनलोड नहीं हुआ है';
  @override
  String get labelNoDownloadsYetDescription =>
      'घर जाएं, कुछ डाउनलोड करने के लिए खोजें या कतार का इंतजार करें!';
  @override
  String get labelYourQueueIsEmpty => 'आपकी कतार खाली है';
  @override
  String get labelYourQueueIsEmptyDescription =>
      'घर जाएं और कुछ डाउनलोड करने के लिए खोजें!';
  @override
  String get labelQueue => 'कतार';
  @override
  String get labelSearchDownloads => 'डाउनलोड खोजें';
  @override
  String get labelWatchHistory => 'देखें इतिहास';
  @override
  String get labelWatchHistoryDescription =>
      'देखें कि आपने कौन-कौन से वीडियो देखे हैं';
  @override
  String get labelBackupAndRestore => 'बैकअप और बहाली';
  @override
  String get labelBackupAndRestoreDescription =>
      'अपने सभी स्थानीय डेटा को सहेजें या पुनर्स्थापित करें';
  @override
  String get labelSongtubeLink => 'सांगट्यूब लिंक';
  @override
  String get labelSongtubeLinkDescription =>
      'सांगट्यूब ब्राउज़र एक्सटेंशन को इस डिवाइस की पहचान करने की अनुमति दें, और अधिक जानने के लिए लॉन्ग प्रेस करें';
  @override
  String get labelSupportDevelopment => 'विकास का समर्थन करें';
  @override
  String get labelSocialLinks => 'सोशल लिंक्स';
  @override
  String get labelSeeMore => 'और देखें';
  @override
  String get labelMostPlayed => 'सबसे अधिक बजाया गया';
  @override
  String get labelNoPlaylistsYet => 'अबतक कोई प्लेलिस्ट नहीं है';
  @override
  String get labelNoPlaylistsYetDescription =>
      'आप अपने हाल की, संगीत, एल्बम या कलाकार से प्लेलिस्ट बना सकते हैं';
  @override
  String get labelNoSearchResults => 'कोई खोज परिणाम नहीं मिले';
  @override
  String get labelSongResults => 'गाने के परिणाम';
  @override
  String get labelAlbumResults => 'एल्बम के परिणाम';
  @override
  String get labelArtistResults => 'कलाकार के परिणाम';
  @override
  String get labelSearchAnything => 'कुछ भी खोजें';
  @override
  String get labelRecents => 'हाल की';
  @override
  String get labelFetchingSongs => 'गाने प्राप्त कर रहे हैं';
  @override
  String get labelPleaseWaitAMoment => 'कृपया कुछ समय प्रतीक्षा करें';
  @override
  String get labelWeAreDone => 'हम खत्म हो गए हैं';
  @override
  String get labelEnjoyTheApp => 'ऐप का आनंद लें';
  @override
  String get labelSongtubeIsBackDescription =>
      'सांगट्यूब साफ़ दिखने वाले एक नए लुक और सुविधाओं के साथ वापस है, अपने संगीत के साथ मौज करें!';
  @override
  String get labelLetsGo => 'चलो चलें';
  @override
  String get labelPleaseWait => 'कृपया प्रतीक्षा करें';
  @override
  String get labelPoweredBy => 'द्वारा संचालित';
  @override
  String get labelGetStarted => 'शुरू हो जाओ';
  @override
  String get labelAllowUsToHave => 'हमें होने दें';
  @override
  String get labelStorageRead => 'स्टोरेज पढ़ें';
  @override
  String get labelStorageReadDescription =>
      'यह आपके संगीत को स्कैन करेगा, उच्च गुणवत्ता वाली कला को निकालेगा और आपको अपने संगीत को व्यक्तिगत रूप से बनाने की अनुमति देगा';
  @override
  String get labelContinue => 'जारी रखें';
  @override
  String get labelAllowStorageRead => 'स्टोरेज पढ़ने की अनुमति दें';
  @override
  String get labelSelectYourPreferred => 'अपनी पसंदीदा को चुनें';
  @override
  String get labelLight => 'लाइट';
  @override
  String get labelDark => 'डार्क';
  @override
  String get labelSimultaneousDownloads => 'समय समय पर डाउनलोड';
  @override
  String get labelSimultaneousDownloadsDescription =>
      'बताएँ कि कितने डाउनलोड समय पर हो सकते हैं';
  @override
  String get labelItems => 'आइटम';
  @override
  String get labelInstantDownloadFormat => 'तत्काल डाउनलोड प्रारूप';
  @override
  String get labelInstantDownloadFormatDescription =>
      'तत्काल डाउनलोड के लिए ऑडियो प्रारूप बदलें';
  @override
  String get labelCurrent => 'वर्तमान';
  @override
  String get labelPauseWatchHistory => 'देखें इतिहास को रोकें';
  @override
  String get labelPauseWatchHistoryDescription =>
      'रोके जाने पर वीडियो स्वचालित रूप से देखे जाने वाले विवरण में सहेजे नहीं जाते हैं';
  @override
  String get labelLockNavigationBar => 'नेविगेश न बार को लॉक करें';
  @override
  String get labelLockNavigationBarDescription =>
      'नेविगेशन बार को स्क्रोल पर स्वचालित रूप से छुपने और दिखने से रोकता है';
  @override
  String get labelPictureInPicture => 'पिक्चर इन पिक्चर';
  @override
  String get labelPictureInPictureDescription =>
      'वीडियो देखते समय होम बटन पर टैप करने पर स्वचालित रूप से PiP मोड में प्रवेश करता है';
  @override
  String get labelBackgroundPlaybackAlpha => 'पृष्ठभूमि प्रवृत्ति (अल्फा)';
  @override
  String get labelBackgroundPlaybackAlphaDescription =>
      'पृष्ठभूमि प्रवृत्ति सुविधा को टॉगल करें। प्लगइन की सीमाओं के कारण, केवल मौजूदा वीडियो को पृष्ठभूमि में प्ले किया जा सकता है';
  @override
  String get labelBlurBackgroundDescription => 'धुंधला कला पृष्ठभूमि जोड़ें';
  @override
  String get labelBlurIntensity => 'धुंधलाप तीव्रता';
  @override
  String get labelBlurIntensityDescription =>
      'संगीत प्लेयर की कला पृष्ठभूमि की धुंधलाप तीव्रता बदलें';
  @override
  String get labelBackdropOpacity => 'बैकड्रॉप अस्पष्टता';
  @override
  String get labelBackdropOpacityDescription =>
      'रंगीन बैकड्रॉप की अस्पष्टता बदलें';
  @override
  String get labelArtworkShadowOpacity => 'कला की छाया अस्पष्टता';
  @override
  String get labelArtworkShadowOpacityDescription =>
      'संगीत प्लेयर की कला की छाया की अधिकता बदलें';
  @override
  String get labelArtworkShadowRadius => 'कला की छाया का त्रिज्य';
  @override
  String get labelArtworkShadowRadiusDescription =>
      'संगीत प्लेयर की कला की छाया का त्रिज्य बदलें';
  @override
  String get labelArtworkScaling => 'कला स्केलिंग';
  @override
  String get labelArtworkScalingDescription =>
      'संगीत प्लेयर की कला और पृष्ठभूमि छवियों को स्केल बाहर करें';
  @override
  String get labelBackgroundParallax => 'पृष्ठभूमि पैरालैक्स';
  @override
  String get labelBackgroundParallaxDescription =>
      'पृष्ठभूमि छवि पैरालैक्स प्रभाव को सक्षम/अक्षम करें';
  @override
  String get labelRestoreThumbnails => 'थंबनेल्स को पुनर्स्थापित करें';
  @override
  String get labelRestoreThumbnailsDescription =>
      'थंबनेल्स और कला उत्पन्न प्रक्रिया को मजबूत करें';
  @override
  String get labelRestoringArtworks => 'कला को पुनर्स्थापित कर रहा है';
  @override
  String get labelRestoringArtworksDone => 'कला को पुनर्स्थापित करना हो गया है';
  @override
  String get labelHomeScreen => 'होम स्क्रीन';
  @override
  String get labelHomeScreenDescription =>
      'जब आप एप्लिकेशन खोलते हैं, तो डिफ़ॉल्ट लैंडिंग स्क्रीन बदलें';
  @override
  String get labelDefaultMusicPage => 'डिफ़ॉल्ट संगीत पृष्ठ';
  @override
  String get labelDefaultMusicPageDescription =>
      'संगीत पृष्ठ के लिए डिफ़ॉल्ट पृष्ठ बदलें';
  @override
  String get labelAbout => 'के बारे में';
  @override
  String get labelConversionRequired => 'रूपांतरण आवश्यक है';
  @override
  String get labelConversionRequiredDescription =>
      'इस गाने का प्रारूप ID3 टैग संपादक के साथ असंगत है। ऐप इस समस्या को हल करने के लिए इस गाने को स्वचालित रूप से AAC (m4a) में कन्वर्ट करेगा।';
  @override
  String get labelPermissionRequired => 'अनुमति आवश्यक है';
  @override
  String get labelPermissionRequiredDescription =>
      'सभी फ़ाइल एक्सेस की अनुमति आवश्यक है ताकि SongTube आपके डिवाइस पर किसी भी गाने को संपादित कर सके';
  @override
  String get labelApplying => 'लागू हो रहा है';
  @override
  String get labelConvertingDescription =>
      'इस गाने को AAC (m4a) प्रारूप में पुनरकोडित कर रहा है';
  @override
  String get labelWrittingTagsAndArtworkDescription =>
      'इस गाने में नए टैग लागू कर रहा है';
  @override
  String get labelApply => 'लागू करें';
  @override
  String get labelSongs => 'गाने';
  @override
  String get labelPlayAll => 'सभी को चलाएं';
  @override
  String get labelPlaying => 'चल रहा है';
  @override
  String get labelPages => 'पृष्ठ';
  @override
  String get labelMusicPlayer => 'संगीत प्लेयर';
  @override
  String get labelClearWatchHistory => 'देखे गए इतिहास को साफ़ करें';
  @override
  String get labelClearWatchHistoryDescription =>
      'आप अपने सभी देखे गए वीडियो इतिहास को मिटाने वाले हैं, यह क्रिया पूर्ववत नहीं की जा सकती है, क्या आप आगे बढ़ना चाहेंगे?';
  @override
  String get labelDelete => 'हटाएं';
  @override
  String get labelAppUpdate => 'ऐप अपडेट';
  @override
  String get labelWhatsNew => 'नया क्या है';
  @override
  String get labelLater => 'बाद में';
  @override
  String get labelUpdate => 'अपडेट';
  @override
  String get labelUnsubscribe => 'सदस्यता रद्द करें';
  @override
  String get labelAudioFeatures => 'ऑडियो विशेषताएँ';
  @override
  String get labelVolumeBoost => 'आवृत्ति बढ़ाएं';
  @override
  String get labelNormalizeAudio => 'ऑडियो को सामान्य करें';
  @override
  String get labelSegmentedDownload => 'विभाजित डाउनलोड';
  @override
  String get labelEnableSegmentedDownload => 'विभाजित डाउनलोड सक्षम करें';
  @override
  String get labelEnableSegmentedDownloadDescription =>
      'यह पूरी ऑडियो फ़ाइल को डाउनलोड करेगा और फिर उसे नीचे सूची में सक्षम सभी सेगमेंट्स (या ऑडियो ट्रैक्स) में विभाजित करेगा';
  @override
  String get labelCreateMusicPlaylist => 'संगीत प्लेलिस्ट बनाएं';
  @override
  String get labelCreateMusicPlaylistDescription =>
      'सभी डाउनलोड और सहेजे गए ऑडियो सेगमेंट्स से संगीत प्लेलिस्ट बनाएं';
  @override
  String get labelApplyTags => 'टैग लागू करें';
  @override
  String get labelApplyTagsDescription =>
      'सभी सेगमेंट्स के लिए MusicBrainz से टैग निकालें';
  @override
  String get labelLoading => 'लोड हो रहा है';
  @override
  String get labelMusicDownloadDescription =>
      'क्वालिटी चुनें, ऑडियो को कनवर्ट और केवल ऑडियो डाउनलोड करें';
  @override
  String get labelVideoDownloadDescription =>
      'सूची से एक वीडियो क्वालिटी चुनें और इसे डाउनलोड करें';
  @override
  String get labelInstantDescription =>
      'तत्काल संगीत के रूप में डाउनलोड करना शुरू करें';
  @override
  String get labelInstant => 'तत्काल';
  @override
  String get labelCurrentQuality => 'वर्तमान गुणवत्ता';
  @override
  String get labelFastStreamingOptions => 'फास्ट स्ट्रीमिंग विकल्प';
  @override
  String get labelStreamingOptions => 'स्ट्रीमिंग विकल्प';
  @override
  String get labelComments => 'टिप्पणियाँ';
  @override
  String get labelPinned => 'पिन किया गया';
  @override
  String get labelLikedByAuthor => 'लेखक द्वारा पसंद किया गया';
  @override
  String get labelDescription => 'विवरण';
  @override
  String get labelViews => 'दृश्य';
  @override
  String get labelPlayingNextIn => 'अगले में चल रहा है';
  @override
  String get labelPlayNow => 'अब चलाएं';
  @override
  String get labelLoadingPlaylist => 'प्लेलिस्ट लोड हो रही है';
  @override
  String get labelPlaylistReachedTheEnd => 'प्लेलिस्ट अंत तक पहुँच गई है';
  @override
  String get labelLiked => 'पसंद';
  @override
  String get labelLike => 'पसंद';
  @override
  String get labelVideoRemovedFromFavorites =>
      'वीडियो को पसंदीदा से हटा दिया गया है';
  @override
  String get labelVideoAddedToFavorites => 'वीडियो को पसंदीदा में जोड़ा गया है';
  @override
  String get labelPopupMode => 'पॉपअप मोड';
  @override
  String get labelDownloaded => 'डाउनलोड किया गया';
  @override
  String get labelShowPlaylist => 'प्लेलिस्ट दिखाएं';
  @override
  String get labelCreatePlaylist => 'प्लेलिस्ट बनाएं';
  @override
  String get labelAddVideoToPlaylist => 'प्लेलिस्ट में वीडियो जोड़ें';
  @override
  String get labelBackupDescription =>
      'अपने सभी स्थानीय डेटा को एक एकल फ़ाइल में बैकअप बनाएं जो बाद में बहाल करने के लिए उपयोग किया जा सकता है';
  @override
  String get labelBackupCreated => 'बैकअप बनाया गया';
  @override
  String get labelBackupRestored => 'बैकअप पुनर्स्थापित हुआ';
  @override
  String get labelRestoreDescription =>
      'बैकअप फ़ाइल से अपना सभी डेटा पुनर्स्थापित करें';
  @override
  String get labelChannelSuggestions => 'चैनल सुझाव';
  @override
  String get labelFetchingChannels => 'चैनल ला रहा है';
  @override
  String get labelShareVideo => 'वीडियो साझा करें';
  @override
  String get labelShareDescription =>
      'दोस्तों या अन्य प्लेटफ़ॉर्म के साथ साझा करें';
  @override
  String get labelRemoveFromPlaylists => 'प्लेलिस्ट से हटाएं';
  @override
  String get labelThisActionCannotBeUndone =>
      'यह क्रिया पूर्ववत नहीं की जा सकती है';
  @override
  String get labelAddVideoToPlaylistDescription =>
      'मौजूदा या नई वीडियो प्लेलिस्ट में जोड़ें';
  @override
  String get labelAddToPlaylists => 'प्लेलिस्ट में जोड़ें';
  @override
  String get labelEditableOnceSaved => 'एक बार सहेजने के बाद संपादन योग्य';
  @override
  String get labelPlaylistRemoved => 'प्लेलिस्ट हटा दी गई';
  @override
  String get labelPlaylistSaved => 'प्लेलिस्ट सहेजी गई';
  @override
  String get labelRemoveFromFavorites => 'पसंदीदा से हटाएं';
  @override
  String get labelRemoveFromFavoritesDescription =>
      'इस वीडियो को अपने पसंदीदा से हटाएं';
  @override
  String get labelSaveToFavorites => 'पसंदीदा में सहेजें';
  @override
  String get labelSaveToFavoritesDescription =>
      'वीडियो को आपके पसंदीदा सूची में जोड़ें';
  @override
  String get labelSharePlaylist => 'प्लेलिस्ट साझा करें';
  @override
  String get labelRemoveThisVideoFromThisList =>
      'इस वीडियो को इस सूची से हटाएं';
  @override
  String get labelEqualizer => 'इक्वालाइज़र';
  @override
  String get labelLoudnessEqualizationGain => 'ध्वनि समता बढ़ावा';
  @override
  String get labelSliders => 'स्लाइडर्स';
  @override
  String get labelSave => 'सहेजें';
  @override
  String get labelPlaylistName => 'प्लेलिस्ट नाम';
  @override
  String get labelCreateVideoPlaylist => 'वीडियो प्लेलिस्ट बनाएं';
  @override
  String get labelSearchFilters => 'खोज फ़िल्टर';
  @override
  String get labelAddToPlaylistDescription =>
      'मौजूदा या नई प्लेलिस्ट में जोड़ें';
  @override
  String get labelShareSong => 'गाना साझा करें';
  @override
  String get labelShareSongDescription =>
      'दोस्तों या अन्य प्लेटफ़ॉर्म के साथ साझा करें';
  @override
  String get labelEditTagsDescription => 'ओपन ID3 टैग्स और आर्टवर्क संपादक';
  @override
  String get labelContains => 'शामिल है';
  @override
  String get labelPlaybackSpeed => 'प्लेबैक स्पीड';
}
