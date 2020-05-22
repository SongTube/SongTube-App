import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DonateScreen extends StatefulWidget {
  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {

  // Local Variables
  bool _showThanks = false;

  Widget openWebView(cont) {
    return Expanded(
      child: WebView(
        initialUrl: "https://paypal.me/artixo",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showThanks == true ? 1.0 : 0.0,
            child: Container(
              height: screenHeight,
              width: screenWidth,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: kToolbarHeight*1.8),
                      Icon(Icons.favorite, size: 150, color: Colors.redAccent),
                      SizedBox(height: 10),
                      Container(
                        width: screenWidth*0.6,
                        child: Text(
                          "Thanks",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25)
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: _showThanks == false ? 1.0 : 0.0,
            child: Container(
              height: screenHeight,
              width: screenWidth,
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Container(height: kToolbarHeight*1.8),
                      Icon(Icons.favorite, size: 150, color: Colors.redAccent),
                      SizedBox(height: 10),
                      Container(
                        width: screenWidth*0.6,
                        child: Text("No act of kindness is ever wasted, " +
                        "this app is free and will forever be. " +
                        "If you like my work and want to donate, it will be really appreciated..!",
                        textAlign: TextAlign.center),
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        onTap: () async {
                          setState(() => _showThanks = true);
                          await Future.delayed(Duration(milliseconds: 1800), () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return openWebView(context);
                              }
                            );
                          });
                          await Future.delayed(Duration(milliseconds: 300), () {
                            setState(() => _showThanks = false);
                          });
                        },
                        child: Container(
                          width: screenWidth*0.25,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text("Donate", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}