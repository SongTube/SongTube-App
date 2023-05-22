import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_fade/image_fade.dart';
import 'package:line_icons/line_icons.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/internal/http_server.dart';
import 'package:songtube/internal/models/backup_model.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/screens/watch_history.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/sheets/backup_restore.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeLibrary extends StatefulWidget {
  const HomeLibrary({Key? key}) : super(key: key);

  @override
  State<HomeLibrary> createState() => _HomeLibraryState();
}

class _HomeLibraryState extends State<HomeLibrary> {

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Theme.of(context).brightness),
        title: Text(Languages.of(context)!.labelLibrary, style: bigTextStyle(context).copyWith(fontSize: 24)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              UiUtils.pushRouteAsync(context, const ConfigurationScreen());
            },
            icon: Icon(Iconsax.setting, color: Theme.of(context).primaryColor)
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            if (CacheUtils.watchHistory.isNotEmpty)
            SizedBox(
              height: 210,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 4),
                itemCount: CacheUtils.watchHistory.length.clamp(0, 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final video = CacheUtils.watchHistory[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: InfoItemRenderer(infoItem: video, expandItem: true)
                    ),
                  );
                },
              ),
            ),
            if (CacheUtils.watchHistory.isNotEmpty)
            const SizedBox(height: 12),
            if (CacheUtils.watchHistory.isNotEmpty)
            Divider(height: 1, thickness: 1.5, color: Theme.of(context).dividerColor.withOpacity(0.08)),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(LineIcons.history, color: Theme.of(context).primaryColor)),
                title: Text(Languages.of(context)!.labelWatchHistory, style: subtitleTextStyle(context, bold: true)),
                subtitle: Text(Languages.of(context)!.labelWatchHistoryDescription, style: smallTextStyle(context, opacity: 0.8)),
                onTap: () async {
                  await UiUtils.pushRouteAsync(context, const WatchHistoryPage());
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                leading: SizedBox(
                  height: double.infinity,
                  child: Icon(Iconsax.save_2, color: Theme.of(context).primaryColor)),
                title: Text(Languages.of(context)!.labelBackupAndRestore, style: subtitleTextStyle(context, bold: true)),
                subtitle: Text(Languages.of(context)!.labelBackupAndRestoreDescription, style: smallTextStyle(context, opacity: 0.8)),
                onTap: () async {
                  await showModalBottomSheet(context: internalNavigatorKey.currentContext!, backgroundColor: Colors.transparent, isScrollControlled: true, builder: (context) {
                    return const BackupRestoreSheet();
                  });
                  setState(() {});
                },
              ),
            ),
            GestureDetector(
              onLongPress: () {
                // Show more information about SongTube Link
      
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: CheckboxListTile(
                  title: Text(Languages.of(context)!.labelSongtubeLink, style: subtitleTextStyle(context, bold: true)),
                  subtitle: Text(Languages.of(context)!.labelSongtubeLinkDescription, style: smallTextStyle(context, opacity: 0.8)),
                  value: linkServer != null,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) async {
                    if (linkServer != null) {
                      await LinkServer.close();
                    } else {
                      await LinkServer.initialize();
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://paypal.me/artixo"));
                },
                leading: const SizedBox(
                  height: double.infinity,
                  child: Icon(
                    EvaIcons.heart,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                title: Text(
                  Languages.of(context)!.labelDonate,
                  textAlign: TextAlign.start,
                  style: subtitleTextStyle(context, bold: true)
                ),
                subtitle: Text(
                  Languages.of(context)!.labelSupportDevelopment,
                  style: smallTextStyle(context, opacity: 0.8)
                ),
              ),
            ),
            _socialIcons(),
            const SizedBox(height: (kToolbarHeight*1.5)+16)
          ],
        ),
      ),
    );
  }

  Widget _socialIcons() {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(Languages.of(context)!.labelSocialLinks, style: subtitleTextStyle(context, bold: true)),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () => launchUrl(Uri.parse("https://t.me/songtubechannel")),
              child: Image.asset('assets/images/telegram.png')
            ),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse("https://github.com/SongTube")),
              child: Image.asset('assets/images/github.png')
            ),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse("https://facebook.com/songtubeapp/")),
              child: Image.asset('assets/images/facebook.png')
            ),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse("https://instagram.com/songtubeapp")),
              child: Image.asset('assets/images/instagram.png')
            ),
          ],
        ),
      ),
    );
  }

}