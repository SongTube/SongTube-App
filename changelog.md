# SongTube 6.4.5:

- General
    * Fixed videos not loading
    * Fixed clipboard (crashing the app on special cases)

# SongTube 6.4.3:

- General
    * Fixed videos not loading

# SongTube 6.4.2:

- UI & UX:
    * Small UI Improvements

- General:
    * Fixed videos not loading

- Languages:
    * Added Kurdish Language (Thanks to @CYAXXX and @baho_20)

# SongTube 6.4.1:

- Hotfix for Crash issue

# SongTube 6.4.0:

- Audio Only Switch:
    * You can now switch between Video and Audio only on the Video Page
    * When Audio Only is enabled, you can exit the app and control the music on the notifications bar

- UI & UX:
    * Small Download menu re-design for a cleaner look and feel
    * Tags Editor page has been re-designed
    * Tags Results from MusicBrainz have been re-designed
    * Increased Lyrics size and transition animation on Music Player
    * Improved UI & UX Consistency

- General:
    * Improved MusicBrainz Auto-Tagger data fetching
    * You can now edit the Artwork in the Tags Results page before saving
    * Current playing songs correctly update their tags if it were modified
    * Fixed some issues with Audio Tagging and Downloads
    * Fixed videos not loading on the video page
    * You can now share you music from Music or Downloads
    * Fixed Audio-Tagger failing on edge cases and filter out illegal search symbols

- Languages:
    * Added Italian Language (Thanks @alpha4041)
    * Added Japanese Language (Thanks @HiSubway)

# SongTube 6.3.0:

- Playlists & Music Screen:
    * You can now create Playlists using your Music!
    * All music on all Tabs should now load instantly after the first time
    * New Playlists Tab
    * New Albums Tab
    * New Artists Tab
    * New Genres Tab

- New In-App Equalizer
    * New button on the Music Player to open up the Equalizer
    * Supports Loudness Equalization Gain
    * Supports 6 Band Equalizer
    * Loudness Equalization & Equalizer can be Enabled/Disabled

- Subscriptions:
    * You can now subscribe to Channels
    * Replaced Youtube Music Tab with Channels
    * Added Plus button on Channel Screen to Discover new Channels
    * Channels screen will show your subscriptions feed by selected Filter (Default by Date)

- Segmented Downloads:
    * Segmented downloads is now a new download option inside the Audio Download Menu.
    * Videos with Chapters can be downloaded and splitted into separated audio files named Segments
    * New Audio Download menu allow each Segment to have their own tags
    * New Audio Download menu has a button to automatically retrieve all Segments Tags (useful for Mixes)

- Youtube Video Player:
    * Prioritize video initialization for faster video load time
    * Added button to show Video Description and Chapters
    * Videos should now switch between Qualities and load faster
    * Moved auto-play button to the Video Player
    * Video Player now shows the Chapter name while seeking above Progress Bar
    * Tweaked Comments tile to save a bit of space
    * New collapse animation when scrolling down the suggested videos

- Settings:
    * Added option to pause you Watch History
    * Added option to Enable/Disable Autoplay upon opening a video
    * Added option to set maximum simultaneous downloads
    * Added option to Enable/Disable Home SearchBar Text Correction

- Screen & Pages:
    * All content retrieved from Youtube now uses the user default Location
    * Replaced Youtube Music Tab with a new Channels Screen
    * Tweaked a bit the UI for consistency
    * Fused Floating Video/Music Widget with the app Bottom Navigation Bar
    * Re-Designed Channel Page
    * You can now delete individual videos on your Watch History page
    * Moved local videos to a new page on accesible from Library Screen
    
- Languages:
    * Added German language (Thanks @Paduu29)
    * Added Bengali language (Thanks @pieas-asif)
    * Added Ukrainian language (Thanks @redman-dev29)
    * Updated Somali language

- General:
    * Improved Videos thumbnails quality
    * Optimized downloader a bit
    * Fixed Music Player resuming music if it was interrupted
    * Fixes for Picture in Picture mode
    * Extracting Tags Automatically or Manually should now be more accurate
    * Getting song's lyrics should work better
    * Fixed Download audio menu tags when downloading outside video page

# SongTube 6.2.0:

- Advanced Playlist Download:
    * New playlist menu where you can choose what to download
    * You can change each video download type from audio to video or viseversa
    * You can change all videos to audio/video download type
    * You can select the quality for all the videos to be downloaded

- Youtube Video Player:
    * Picture in Picture is now supported!
    * The player will now remember the chosen quality
    * Videos should now load faster
    * Video Player now shows current streaming quality text

- In-App updates support:
    * You can now install download/install an update inside the app
    * The app will check for updates on startup
    * Redesigned updates UI

- General:
    * Youtube Music screen can now be hidden from Settings
    * Fixed download saving issues on some devices
    * Fixed download saving to SDCard
    * Tags Editor retrieves higher quality Artwork
    * Music Player background now shows behing system Navigation Bar
    * Added a "Copy error" button on cancelled downloads (if needed)
    * Setting's Audio/Video download path option now shows current path
    * Fixed app crash when disabling audio conversion

# SongTube 6.0.0:

- Playlist Creation/Management Support:
    * First implementation of custom Playlists
    * You can now create new Playlists and add Videos to created Playlists
    * You can now save playlists from your search results

- Youtube Video Player:
    * Re-designed Video Player with much better looking UI
    * Added support for changing streaming quality
    * Added support for double tap to fast back or forward (10s)
    * Added support for vertical drag to change screen brightness (left side, only in fullscreen)
    * Added support for vertical drag to change media volume (right side, only in fullscreen)
    * Related videos are now actually related to the video you are watching
    * Added a button to open video comments!

- YouTube Extractor:
    * Replaced youtube_explode_dart with newpipe_extractor
    * Loading speed for Search, Channels, Videos, etc, has dramatically improved
    * Search will now show Channels as results!
    
- Screens & Pages:
    * Added new Music Screen! You can now search for Music only.
    * Home Screen now shows Trending Videos on app start (No more weird videos)
    * Added a new page for all your saved Playlists! Accesible on Library Screen
    * Consistency between Screens & Pages have been improved
    * Updated and Re-designed the About us Page

- UI Experience:
    * Added a new and smoother transition animation between pages
    * Improved Search show/hide animation from the Home Screen
    * Pages opening animation have been improved
    * Blur UI Style fixed (Pages now properly makes use of it)
    * Optimized Sliding Panel open/close perfomance (for Videos/Music)
    * Fixed issues where the Collapsed Panel would not respond
    * UI is now more smooth in general

- Languages:
    * Added Arabic language (Thanks @JOOD_TECH)
    * Added Somali language (Thanks @nadiration)

- General:
    * Fixed all issues related to Channels and Playlists
    * Added more Shimmer Effects
    * Added an empty indicator wherever it is needed
    * Improved SplashArt Image (Goodbye blurred logo)
    * Switched to GPLv3 license


# SongTube 5.6.0:

- Imported Product Sans font
- Added missing translations
- Added Russian Language (Thanks @yxur_bruh)
- Video Player Portrait/Fullscreen transition is smoother
- App NavigationBar and AppBar can now hide/shows on scroll
- Improved SplashArt
- Added support for Background Playback
- Blur UI Style disable by default (causes lag)
- Improved design consistency between screens/pages
- Improved SearchBar behavior
- Implemented typeahead suggestions on Youtube SearchBar
- Moved Download page from Media screen to Downloads screen
- Added Audio Normalization checkbox on Audio download panel
- MusicPlayer collapsed panel now expands on Tap
- Made some IconButtons in the UI easier to Tap
- Tags Editor will no longer show up on unsupported audio files
- Added new Library screen that replaces old More screen
- Implemented Search History on Library screen
- Implemented Playlist support in the same Video page
- Deleted old Playlist page
- DownloadMenu has new button to Download all Related/Playlist videos
- Video Page is now a Slidable Panel (Like the MusicPlayer)
- Added a new "About us" page at Library screen
- Fixed MusicBrainz API results weird characters
- Added Video duration to search results
- Implemented support for fast Reverse & Forward on Youtube Player

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