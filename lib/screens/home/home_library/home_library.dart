import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/cache_utils.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/internal/http_server.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/main.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/screens/about.dart';
import 'package:songtube/screens/settings.dart';
import 'package:songtube/screens/watch_history.dart';
import 'package:songtube/ui/animations/animated_icon.dart';
import 'package:songtube/ui/info_item_renderer.dart';
import 'package:songtube/ui/sheets/backup_restore.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:songtube/ui/ui_utils.dart';
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
        title: Text(Languages.of(context)!.labelLibrary, style: bigTextStyle(context).copyWith(fontSize: 24, letterSpacing: 0.2)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Semantics(
            label: Languages.of(context)!.labelSettings,
            child: IconButton(
              onPressed: () {
                UiUtils.pushRouteAsync(context, const ConfigurationScreen());
              },
              icon: const AppAnimatedIcon(EvaIcons.settingsOutline)
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (CacheUtils.watchHistory.isNotEmpty)
            SizedBox(
              height: 210,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 4),
                itemCount: CacheUtils.watchHistory.length.clamp(0, 10),
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
            Divider(height: 12, thickness: 8, color: Theme.of(context).dividerColor.withOpacity(0.04)),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                leading: const AppAnimatedIcon(EvaIcons.clockOutline, size: 20),
                visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
                title: Text(Languages.of(context)!.labelWatchHistory, style: smallTextStyle(context, bold: true)),
                subtitle: Text(Languages.of(context)!.labelWatchHistoryDescription, style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)),
                onTap: () async {
                  await UiUtils.pushRouteAsync(context, const WatchHistoryPage());
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                leading: const AppAnimatedIcon(EvaIcons.archiveOutline, size: 20),
                visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
                title: Text(Languages.of(context)!.labelBackupAndRestore, style: smallTextStyle(context, bold: true)),
                subtitle: Text(Languages.of(context)!.labelBackupAndRestoreDescription, style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)),
                onTap: () async {
                  await UiUtils.showModal(
                    context: internalNavigatorKey.currentContext!,
                    modal: const BackupRestoreSheet(),
                  );
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListTile(
                onTap: () {
                  launchUrl(Uri.parse("https://paypal.me/artixo"), mode: LaunchMode.externalApplication);
                },
                visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
                leading: const AppAnimatedIcon(
                  EvaIcons.heartOutline,
                  size: 20,
                ),
                title: Text(
                  Languages.of(context)!.labelDonate,
                  textAlign: TextAlign.start,
                  style: smallTextStyle(context, bold: true)
                ),
                subtitle: Text(
                  Languages.of(context)!.labelSupportDevelopment,
                  style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
                ),
              ),
            ),
            _about(),
            GestureDetector(
              onLongPress: () {
                launchUrl(Uri.parse("https://github.com/SongTube/songtube_link_extension"), mode: LaunchMode.externalApplication);
              },
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: FutureBuilder(
                  future: NetworkInfo().getWifiIP(),
                  builder: (context, snapshot) {
                    return Consumer<MediaProvider>(
                      builder: (context, provider, _) {
                        return CheckboxListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Consumer<MediaProvider>(
                                  builder: (context, provider, _) {
                                    final greyscale = provider.currentColors.vibrant != accentColor;
                                    return Opacity(
                                      opacity: greyscale ? 0.8 : 1,
                                      child: Image.asset(
                                          greyscale
                                          ? 'assets/images/logo_bw.png'
                                          : 'assets/images/logo.png',
                                        height: 30, width: 30
                                      ),
                                    );
                                  }
                                ),
                                const SizedBox(width: 12),
                                Text(Languages.of(context)!.labelSongtubeLink, style: subtitleTextStyle(context, bold: true)),
                              ],
                            ),
                          ),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Languages.of(context)!.labelSongtubeLinkDescription, style: subtitleTextStyle(context, opacity: 0.6).copyWith(fontSize: 13)),
                              AnimatedSize(
                                duration: kAnimationDuration,
                                curve: kAnimationCurve,
                                child: Container(
                                  height: linkServer != null ? null : 0,
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Text('Device IP: ${snapshot.data}', style: subtitleTextStyle(context, opacity: 1).copyWith(fontSize: 13)),
                                  )),
                              ),
                            ],
                          ),
                          value: linkServer != null,
                          activeColor: provider.currentColors.vibrant,
                          onChanged: (value) async {
                            if (linkServer != null) {
                              await LinkServer.close();
                            } else {
                              await LinkServer.initialize();
                            }
                            setState(() {});
                          },
                        );
                      }
                    );
                  }
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
        child: Text(Languages.of(context)!.labelSocialLinks, style: headerTextStyle(context).copyWith(letterSpacing: 0.2)),
      ),
      contentPadding: EdgeInsets.zero,
      subtitle: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 12, right: 12, top: 16),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Semantics(
              label: 'Open telegram channel',
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse("https://t.me/songtubechannel"), mode: LaunchMode.externalApplication),
                child: Image.asset('assets/images/telegram.png')
              ),
            ),
            Semantics(
              label: 'Open github repository',
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse("https://github.com/SongTube"), mode: LaunchMode.externalApplication),
                child: Image.asset('assets/images/github.png')
              ),
            ),
            Semantics(
              label: 'Open facebook page',
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse("https://facebook.com/songtubeapp/"), mode: LaunchMode.externalApplication),
                child: Image.asset('assets/images/facebook.png')
              ),
            ),
            Semantics(
              label: 'Open instagram page',
              child: GestureDetector(
                onTap: () => launchUrl(Uri.parse("https://instagram.com/songtubeapp"), mode: LaunchMode.externalApplication),
                child: Image.asset('assets/images/instagram.png')
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _about() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: ListTile(
        onTap: () {
          UiUtils.pushRouteAsync(internalNavigatorKey.currentContext!, AboutPage());
        },
        visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
        leading: const AppAnimatedIcon(
          EvaIcons.questionMarkCircleOutline,
          size: 20,
        ),
        title: Text(
          Languages.of(context)!.labelAbout,
          textAlign: TextAlign.start,
          style: smallTextStyle(context, bold: true)
        ),
        subtitle: Text(
          "Licenses, Contact Info and more",
          style: smallTextStyle(context, opacity: 0.6).copyWith(fontSize: 12)
        ),
      ),
    );
  }

}