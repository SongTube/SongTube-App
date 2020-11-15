// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Brightness _themeBrightness = Theme.of(context).brightness;
    Brightness _systemBrightness = Theme.of(context).brightness;
    Brightness _statusBarBrightness = _systemBrightness == Brightness.light
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
    return Scaffold(
      body: Column(
        children: [
          // Main Body
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
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
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text(
                        Languages.of(context).labelSkip,
                        style: TextStyle(
                          fontFamily: 'YTSans',
                          fontSize: 15,
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
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          Languages.of(context).labelNext,
                          style: TextStyle(
                            fontFamily: 'YTSans',
                            fontSize: 15,
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
          )
        ],
      ),
    );
  }
}