// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:songtube/internal/languages.dart';
import 'package:url_launcher/url_launcher.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

class IntroWelcome extends StatelessWidget {
  final Function onNext;
  IntroWelcome({
    this.onNext
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            ShowUpTransition(
              duration: Duration(milliseconds: 600),
              forward: true,
              slideSide: SlideFromSlide.BOTTOM,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AvatarGlow(
                      repeat: true,
                      endRadius: 120,
                      showTwoGlows: false,
                      glowColor: Theme.of(context).accentColor.withOpacity(0.1),
                      repeatPauseDuration: Duration(milliseconds: 400),
                      child: Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Theme.of(context).accentColor.withOpacity(0.1)
                        ),
                        child: Center(
                          child: Container(
                            height: 140,
                            width: 140,
                            child: Image.asset(
                              DateTime.now().month == 12
                                ? 'assets/images/logo_christmas.png'
                                : 'assets/images/logo.png'
                            )
                          ),
                        ),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'YTSans',
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyText1.color
                        ),
                        children: [
                          TextSpan(
                            text: Languages.of(context).labelAppWelcome.toLowerCase() + "\n",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22
                            )
                          ),
                          TextSpan(
                            text: "SongTube",
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 42,
                            )
                          )
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ShowUpTransition(
              forward: true,
              slideSide: SlideFromSlide.TOP,
              duration: Duration(milliseconds: 600),
              child: GestureDetector(
                onTap: () {
                  launch('https://github.com/TeamNewPipe/NewPipeExtractor');
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15, width: 15,
                              color: Colors.white,
                            ),
                            Icon(
                              MdiIcons.youtube,
                              size: 40,
                              color: Colors.red
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'YTSans',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.bodyText1.color
                          ),
                          children: [
                            TextSpan(
                              text: "Powered by\n",
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w600
                              )
                            ),
                            TextSpan(
                              text: "NewPipe Extractor",
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontFamily: 'Product Sans',
                                fontWeight: FontWeight.w600
                              )
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ShowUpTransition(
              forward: true,
              slideSide: SlideFromSlide.TOP,
              duration: Duration(milliseconds: 600),
              child: Align(
                alignment: Alignment.topRight,
                child: _createLanguageDropDown(context)
              ),
            )
          ],
        ),
        floatingActionButton: ShowUpTransition(
          delay: Duration(milliseconds: 600),
          duration: Duration(milliseconds: 600),
          forward: true,
          slideSide: SlideFromSlide.BOTTOM,
          child: Padding(
            padding: EdgeInsets.only(right: 16),
            child: FloatingActionButton.extended(
              backgroundColor: Theme.of(context).accentColor,
              label: Text(
                Languages.of(context).labelStart,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),
              ),
              onPressed: onNext,
            ),
          ),
        ),
      ),
    );
  }

  _createLanguageDropDown(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: DropdownButton<LanguageData>(
        alignment: Alignment.centerRight,
        iconSize: 26,
        hint: Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Text(
            Localizations.localeOf(context).languageCode.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Theme.of(context).textTheme.bodyText1.color
            ),
          ),
        ),
        icon: SizedBox(),
        onChanged: (LanguageData language) {
          changeLanguage(context, language.languageCode);
        },
        underline: DropdownButtonHideUnderline(child: Container()),
        items: supportedLanguages
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'YTSans',
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyText1.color
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
      ),
    );
  }
  
}