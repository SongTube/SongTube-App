# SongTube 5.3.0:

- Fixed "Join Telegram" dialog text color
- Implemented MusicBrainz for Music Tagging
- Blur Background toggle is now back for Music Player
- MusicPlayer now preloads previous and next songs Artworks (Which makes song skip smoother)
- Replaced "Delete Song" dialog in Media's Songs with a better Popup Menu
- You can now change Tags & Artwork on any song in your Media
- Black theme is now fully black
- Implemented Lyrics (One tap on the MusicPlayer Artwork to load it)

# SongTube 5.2.0:

- Small Home Screen re-design
- Added real Tabs in the Home Screen
- More roundness to the UI
- Improved Dark Theme
- Improved Video/Channel exit animation
- Added Product Sans for some fonts
- Added "Current Playlist" button to the Music Player
- Video Page "AutoPlay" setting is now persistent
- Video's audio writting is now done almost instantly
- Youtube Stream Player small improvements
- Fixed video's menu text color

# SongTube 5.0.0:

- Fixed an issue where the device songs will not load if there a corrupt song
- Deleted "Navigate" Screen
- Home Screen will now show YouTube Videos
- Home Screen now has Tabs for Trending, Music, Favorites and Watch Later
- Implemented Favorites Videos
- Implemented Watch Later Videos
- Home Screen will now show last search results
- Home Screen search results load time slightly improved
- Added new Video Page with Related Videos
- Replaced Youtube iFrame Player with a custom Video Player (Faster and responsive)
- Added more Blur UI on pages transitions and Music Player
- Added an option on Settings to disable Blur UI Style
- You can now Tap on Channels to view latest Uploads
- New smooth animations on Video/Channel Opening
- Fixed download issues on Android 10 & 11
- Fixed Audio/Video saving on SDCard (I hope)
- Fixed low quality Artworks on Songs from Videos with higher quality artworks available
- Music Player now has smoother animations on Song transition
- Added a new Option in Settings to fix Android 11 Downloads
- Added a new Dialog to invite the user to join Telegram Channel
- Increased Bass & Treble gains at Download Menu
- All videos from the Home Screen will have a menu (three dots menu) to:
    * Share Video
    * Copy Link
    * Download
    * Save to Favorites
    * Save to Watch Later
- Audio/Video can now be downloaded without opening the video (three dots menu)
- Implemented new Downloads Menu which will has:
    * All Audio Options
    * More Details about each Audio Option
    * Best Audio Suggestion
    * Re-Organized Audio Filters Modifiers
    * CheckBox to enable Conversion
    * Menu to change Audio Conversion Format
    * Re-Organized Video Download Menu
    * More Details about each Video Option
- Audios will now not be converted if it is not necesary
- Implemented support for Updates check (Using Github REST API)
- Added new Disclaimer for Liability
- Implemented support for Multi-Languages:
    * English
    * Spanish
    * Portuguese (Thanks to RickyM7)
    * Igbo (Thanks to enweazudaniel)
    * Indonesian (Thanks to Hafitz Setya)
    * Turkish (Thanks to Barış Kırmızı)
- Desaturated Accent Colors on Dark/Black Theme (a little)
- MusicPlayer Artwork Rounded Corners is now customizable

# SongTube 4.0.0:

- Reverted from audioplayers to just_audio on a better implementation
- AudioService is now Pre-Loaded on App lunch
- Current queue is now not updated innecessarily when tapping a Song
- Re-designed the Music Player collapsed Panel
- Reduced BottomNavigationBar Icons & Text Size by a little
- Media default tab is now Music Tab
- Added a new OptionsMenuDialog for MusicTab and DownloadsTab three dots Menu
- Implement a Search Bar in Media Screen that works on Music and Downloads TAb
- Download Object and Process has been improved
- Small UI Touch to Settings
- Fixed Setting's "Delete Cache" option
- Removed Youtube Player ability to reproduce videos on background (To be better implemented later)
- Fixed Link sharing to SongTube from other Apps
- Implemented Search History for Youtube Search Bars
- Added Audio/Video leading icon in Downloads from Downloads Screen and Media DownloadsTab
- Improved SearchBar design from Navigate Screen
- DatabaseService will now try extract the Artwork from downloads with FFmpeg
- Fixed Downloads backup restore on cases where the Download has modified Artwork
- Converted ListView from Media MusicTab with an AnimatedList
- Redesigned Navigate Screen with channel icon bellow Video Thumbnail
- Navigate Screen now has "infinite" scrolling, it will likely never run out of results
- Navigate Screen now shows Playlists
- Implemented Full support for Playlist Download
- Fixed issue causing Download Button to keep loading on forever
- Redesigned Downloads Screen with Queue, Completed & Cancelled Tabs
- Divided Download Screen QueueTab in 3 Lists, "Queued", "Downloading" and "Converting" lists
- Download Screen Lists are now Animated
- Improved Shimmers Pages effect
- Removed "- Topic" string from Channels name
- Improved some Fonts

# SongTube 3.3.0:

- Reworked MusicPlayer with Customization Options
- Improved Songs Thumbnail and Artwork Quality
- Fixed some Songs not using the correct Thumbnail/Artwork
- Added a new "Album Folder" that organizes your song downloads by song album name in your download path.
- Fixed Artwork flickering in the MusicPlayer Notification
- UI Look/Animations Improvements
- Updated YoutubeExplode Library (A few videos that weren't loading now loads)
- Improved Video loading Speed

# SongTube 3.0.0:

- Fixed Restore/Backup Options
- Fixed default downloads folder not getting created
- Fixed issue which allowed to set audio/video downloads folder to null
- README.md Updated
- Removed unused Variables/Imports
- Added Package string_validator (to check if text is url)
- Implemented QuickSearch on the App's HomeScreen
- Implemented custom-animated searchBar
- Added package keyboard_visibility (To check if keyboard is visible)
- Changed (almost) all the App's UI BorderRadius of Containers and Images from 20 to 10
- Added Shimmer to SearchPage
- Removed Floating Widget for Music
- Implemented an Slidable Bar above the BottomNavigationBar for Now Playing Music
- Forked youtube_player_flutter and modified to allow Background Playback
- Changed Native language from Java to Kotlin
- Song Artwork is now Cut in a square before applying it to a Song
- Song Artwork can now be changed before downloading (From Gallery, for now)
- Added Package rxdart to replace StreamControllers with BehaviorSubjects
- Changed Library Navigation to TabBarView (With swipe to switch pages disabled)
- Video Page is now dismissible to the right, doing this will return you to the HomePage QuickSearch
- Download list is now reversed to show recent downloads first
- Make sure our Audio/Video folders exist, if they don't then create them recursively
- Implemented a new Introduction Page for those who installs the App for the first time
- The App now doesn't force Storage Permissions, instead, asks for it when needed
- Adjusted almost all the App's UI to have a more plain design and softer shadows
- Download Page now only shows ongoing and finished downloads
- Implemented new "Media" page where you can find all your device Songs, Videos, and Downloads by the App
- Improved the App's AudioPlayer Service
- Implemented an In-App Video Player
- Replaced Youtube WebView Page with a Custom SearchPage that is faster and more customizable
- Fixed issues in Android 8 and bellow about Settings not persisting or black screen
- Implemented a Color Picker (In settings) that allows you to change the whole App's AccentColor
- Improved/Added new Animations on the whole App
- Added and Optimized the Songs Thumbnails & Artwork generator
- Changed the App SplashScreen Logo
- Enabled DayNight Theme (Allows the SplashArt to theme itself based on the System Theme)
- Fixed (almost) all bugs and Improved stability