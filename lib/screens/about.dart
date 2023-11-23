import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/internal/global.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                const SizedBox(width: 4),
                IconButton(
                  icon: Icon(Iconsax.arrow_left, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "About us",
                    style: textStyle(context)
                  ),
                ),
                IconButton(
                  icon: const Icon(MdiIcons.license,
                    color: Colors.green),
                  onPressed: () {
                    showLicensePage(
                      applicationName: packageInfo.appName,
                      applicationIcon: Image.asset('assets/images/ic_launcher.png', height: 50, width: 50),
                      applicationVersion: packageInfo.version,
                      context: context
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width*0.24,
                    ),
                    const SizedBox(width: 32),
                    Text(
                      "SongTube",
                      style: bigTextStyle(context)
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: RichText(
                    text: TextSpan(
                      style: subtitleTextStyle(context),
                      children: const [
                        TextSpan(
                          text: "It's an Open Source app for media downloading "
                            "or streaming purposes\n\nMeant to be a beautiful, "
                            "fast and functional alternative to other Youtube "
                            "Clients, "
                        ),
                        TextSpan(
                          text: "it'll be forever free with no ads.",
                          style: TextStyle(
                            fontWeight: FontWeight.w700
                          )
                        )
                      ]
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Airis Team",
                      style: bigTextStyle(context)
                    ),
                    const SizedBox(width: 32),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 10, 28),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1), width: 2)
                      ),
                      child: Image.asset(
                        'assets/images/airis.png',
                        width: MediaQuery.of(context).size.width*0.24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: Text(
                    "We are a Development Team dedicated to professional software "
                    "solutions.\n\nContact us to know more about the best Web "
                    "and Mobile services we can offer you.",
                    style: subtitleTextStyle(context)
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                // Developers Information
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 32, right: 32),
                  onTap: () {
                    launchUrl(Uri.parse('https://linktr.ee/artxdev'));
                  },
                  leading: Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width*0.09,
                  ),
                  title: Text(
                    "Developer Info",
                    textAlign: TextAlign.start,
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  subtitle: Text(
                    "https://linktr.ee/artxdev",
                    style: smallTextStyle(context, opacity: 0.8)
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).iconTheme.color, size: 18),
                  ),
                ),
                // Artx Email
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 32, right: 32),
                  onTap: () {
                    launchUrl(Uri.parse('mailto:artx4dev@gmail.com'));
                  },
                  leading: Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width*0.09,
                  ),
                  title: Text(
                    "Support Email",
                    textAlign: TextAlign.start,
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  subtitle: Text(
                    "artx4dev@gmail.com",
                    style: smallTextStyle(context, opacity: 0.8)
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).iconTheme.color, size: 18),
                  ),
                ),
                // Airis Email
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 32, right: 32),
                  onTap: () {
                    launchUrl(Uri.parse('mailto:airisdevgroup@gmail.com'));
                  },
                  leading: Image.asset(
                    'assets/images/airis.png',
                    width: MediaQuery.of(context).size.width*0.09,
                  ),
                  title: Text(
                    "Airis Email",
                    textAlign: TextAlign.start,
                    style: subtitleTextStyle(context, bold: true)
                  ),
                  subtitle: Text(
                    "airisdevgroup@gmail.com",
                    style: smallTextStyle(context, opacity: 0.8)
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).iconTheme.color, size: 18),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}