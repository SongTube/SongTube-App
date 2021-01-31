import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "About us",
          style: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Theme.of(context).textTheme.bodyText1.color
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width*0.25,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 24, top: 16),
                  child: Text(
                    "SongTube is an Open Source app for media downloading or "
                    "streaming, designed and developed as a beautiful, "
                    "fast and functional alternative to other Youtube Clients.\n\n"
                    "This app is, and will always be provided for you for free "
                    "and without Ads.",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 24, top: 16),
                  child: Text(
                    "Airis is a new Development Group and we will "
                    "do any kind of software based development, professionally."
                    "\n\nYou can contact us and we will deliver any Web Page, API, "
                    "Mobile App or anything software related with the best "
                    "looking, functional and care for you.",
                    style: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/airis.png',
                  width: MediaQuery.of(context).size.width*0.25,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
            leading: Icon(
              EvaIcons.emailOutline,
              color: Colors.red,
              size: 36,
            ),
            title: Text(
              "Email",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
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
          SizedBox(height: 16),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
            leading: Icon(
              EvaIcons.phoneOutline,
              color: Colors.blue,
              size: 36,
            ),
            title: Text(
              "Phone Number",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                fontFamily: 'Product Sans',
                color: Theme.of(context).textTheme.bodyText1.color
              )
            ),
            subtitle: Text(
              "+584143521458",
              style: TextStyle(
                fontFamily: 'Product Sans',
                color: Theme.of(context).textTheme.bodyText1.color
              ),
            ),
          ),
          SizedBox(height: 8),
          Divider(),
          SizedBox(height: 8),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AboutPage();
              }));
            },
            title: Center(
              child: Text(
                "Licenses",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                )
              ),
            ),
            subtitle: Center(
              child: Text(
                "All Packages & Plugins Licenes",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}