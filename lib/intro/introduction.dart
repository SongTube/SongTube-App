// Flutter
import 'package:floating_dots/floating_dots.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/internal/languages.dart';

// Internal
import 'package:songtube/intro/components/introPermissions.dart';
import 'package:songtube/intro/components/introReady.dart';
import 'package:songtube/intro/components/introTheme.dart';
import 'package:songtube/intro/components/introWelcome.dart';
import 'package:songtube/provider/configurationProvider.dart';

// Packages
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {

  TabController _controller;
  int _selectedIndex = 0;

  // IntroWelcome Widget
  Widget introWelcome;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      IntroWelcome(
        onNext: () => setState(() {
          _selectedIndex += 1; _controller.index = _selectedIndex;
        })
      ),
      IntroPermissions(),
      IntroTheme(),
      IntroReady(
        onEnd: () {
          Provider.of<ConfigurationProvider>(context, listen: false).preferences.saveShowIntroductionPages(false);
          Navigator.pushReplacementNamed(context, 'homeScreen');
        },
      )
    ];
    // Create TabController for getting the index of current tab
    _controller = TabController(length: screens.length, vsync: this);
    _controller.animation.addListener(() {
      int value = _controller.animation.value.round();
      if (value != _selectedIndex)
        setState(() => _selectedIndex = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Brightness _systemBrightness = Theme.of(context).brightness;
      Brightness _statusBarBrightness = _systemBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
      Brightness _themeBrightness = _systemBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: _statusBarBrightness,
          statusBarIconBrightness: _statusBarBrightness,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: _themeBrightness
        ),
      );
    });
    // Background color with some transparency
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7);
    // Introduction body
    Widget _body() {
      return Column(
        children: [
          // Main Body
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: screens,
              ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Skip Introduction
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: _selectedIndex == 3 ? SizedBox() : TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          Languages.of(context).labelSkip,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
                          ),
                        ),
                        onPressed: () {
                          Provider.of<ConfigurationProvider>(context, listen: false).preferences.saveShowIntroductionPages(false);
                          Navigator.pushReplacementNamed(context, 'homeScreen');
                        },
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: screens.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        margin: EdgeInsets.only(left: 8, right: 8),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: _selectedIndex == index
                            ? Theme.of(context).accentColor
                            : Theme.of(context).iconTheme.color.withOpacity(0.08)
                        ),
                      ),
                    );
                  },
                ),
                // Go to next Page
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  child: _selectedIndex == 1 || _selectedIndex == 2 ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          Languages.of(context).labelNext,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7),
                          ),
                        ),
                        onPressed: _selectedIndex < _controller.length-1
                          ? () => setState(() {
                              _selectedIndex += 1; _controller.index = _selectedIndex;
                            })
                          : null
                      ),
                    ),
                  ) : Container()
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      );
    }
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: _body())
    );
  }
}