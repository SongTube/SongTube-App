import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "About us",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.license,
              color: Colors.green),
            onPressed: () {
              showLicensePage(
                applicationName: config.appName,
                applicationIcon: Image.asset('assets/images/ic_launcher.png', height: 50, width: 50),
                applicationVersion: config.appVersion,
                context: context
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: ListView(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width*0.15,
                    ),
                  ),
                ),
                SizedBox(width: 32),
                Text(
                  "SongTube",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Product Sans'
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
                children: [
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Airis Team",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Product Sans'
                  ),
                ),
                SizedBox(width: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 10, 28),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 10, 28),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    padding: EdgeInsets.all(12),
                    child: Image.asset(
                      'assets/images/airis.png',
                      width: MediaQuery.of(context).size.width*0.15,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "We are a Development Team dedicated to professional software "
              "solutions.\n\nContact us to know more about the best Web "
              "and Mobile services we can offer you.",
              style: TextStyle(
                fontSize: 14
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            // Artx Email
            ListTile(
              onTap: () {
                launch('mailto:artx4dev@gmail.com');
              },
              leading: Icon(
                EvaIcons.emailOutline,
                color: Colors.red,
                size: 28,
              ),
              title: Text(
                "Email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                )
              ),
              subtitle: Text(
                "artx4dev@gmail.com",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
            ),
            // Airis Email
            ListTile(
              onTap: () {
                launch('mailto:airisdevgroup@gmail.com');
              },
              leading: Image.asset(
                'assets/images/airis.png',
                width: MediaQuery.of(context).size.width*0.09,
              ),
              title: Text(
                "Airis Email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                )
              ),
              subtitle: Text(
                "airisdevgroup@gmail.com",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}