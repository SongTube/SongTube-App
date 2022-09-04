// Flutter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/provider/configurationProvider.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

// UI
import 'package:songtube/ui/animations/showUp.dart';

enum ThemeSelected { System, Light, Dark }

class IntroTheme extends StatefulWidget {
  @override
  _IntroThemeState createState() => _IntroThemeState();
}

class _IntroThemeState extends State<IntroTheme> {
  
  // Currently Selected Theme
  ThemeSelected theme;

  @override
  void initState() {
    super.initState();
    theme = ThemeSelected.System;
  }

  @override
  Widget build(BuildContext context) {
    ConfigurationProvider config = Provider.of<ConfigurationProvider>(context);
    void checkTheme() {
      if (config.preferences.getSystemThemeEnabled() == true) {
        theme = ThemeSelected.System;
      } else if (
        config.preferences.getSystemThemeEnabled() == false &&
        config.preferences.getDarkThemeEnabled() == false
      ) {
        theme = ThemeSelected.Light;
      } else {
        theme = ThemeSelected.Dark;
      }
    }
    checkTheme();
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShowUpTransition(
            duration: Duration(milliseconds: 600),
            forward: true,
            slideSide: SlideFromSlide.LEFT,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          EvaIcons.colorPaletteOutline,
                          size: 40,
                          color: Colors.red
                        ),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyText1.color
                        ),
                        children: [
                          TextSpan(
                            text: "App "
                          ),
                          TextSpan(
                            text: Languages.of(context).labelAppCustomization,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
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
            slideSide: SlideFromSlide.BOTTOM,
            duration: Duration(milliseconds: 600),
            forward: true,
            child: Container(
              width: MediaQuery.of(context).size.width*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/appTheme.png'),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyText1.color
                        ),
                        children: [
                          TextSpan(
                            text: Languages.of(context).labelSelectPreferred + "\n"
                          ),
                          TextSpan(
                            text: Languages.of(context).labelTheme + "!",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w700
                            )
                          )
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 32),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 30, right: 15),
                    child: ShowUpTransition(
                      duration: Duration(milliseconds: 600),
                      delay: Duration(milliseconds: 600),
                      forward: true,
                      slideSide: SlideFromSlide.BOTTOM,
                      child: GestureDetector(
                        onTap: () {
                          config.systemThemeEnabled = true;
                          config.darkThemeEnabled = false;
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.all(8),
                          duration: Duration(milliseconds: 150),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.System
                              ? Theme.of(context).accentColor
                              : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.08),
                                offset: Offset(0,0),
                                spreadRadius: 0.01,
                                blurRadius: 20.0
                              )
                            ]
                          ),
                          child: Center(
                            child: Text(
                              Languages.of(context).labelSystem,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: theme == ThemeSelected.System
                                  ? Colors.white
                                  : Theme.of(context).textTheme.bodyText1.color,
                                fontWeight: FontWeight.w700,
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ShowUpTransition(
                      duration: Duration(milliseconds: 600),
                      delay: Duration(milliseconds: 700),
                      forward: true,
                      slideSide: SlideFromSlide.BOTTOM,
                      child: GestureDetector(
                        onTap: () {
                          config.systemThemeEnabled = false;
                          config.darkThemeEnabled = false;
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.all(8),
                          duration: Duration(milliseconds: 150),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.Light
                              ? Theme.of(context).accentColor
                              : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.08),
                                offset: Offset(0,0),
                                spreadRadius: 0.01,
                                blurRadius: 20.0
                              )
                            ]
                          ),
                          child: Center(
                            child: Text(
                              "Light",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: theme == ThemeSelected.Light
                                  ? Colors.white
                                  : Theme.of(context).textTheme.bodyText1.color,
                                fontWeight: FontWeight.w700,
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 30),
                    child: ShowUpTransition(
                      duration: Duration(milliseconds: 600),
                      delay: Duration(milliseconds: 800),
                      forward: true,
                      slideSide: SlideFromSlide.BOTTOM,
                      child: GestureDetector(
                        onTap: () {
                          config.systemThemeEnabled = false;
                          config.darkThemeEnabled = true;
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.all(8),
                          duration: Duration(milliseconds: 150),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme == ThemeSelected.Dark
                              ? Theme.of(context).accentColor
                              : Theme.of(context).cardColor.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.08),
                                offset: Offset(0,0),
                                spreadRadius: 0.01,
                                blurRadius: 20.0
                              )
                            ]
                          ),
                          child: Center(
                            child: Text(
                              "Dark",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: theme == ThemeSelected.Dark
                                  ? Colors.white
                                  : Theme.of(context).textTheme.bodyText1.color,
                                fontWeight: FontWeight.w700,
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}