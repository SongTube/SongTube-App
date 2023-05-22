import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/providers/ui_provider.dart';
import 'package:songtube/ui/animations/show_up.dart';

class ThemeIntroPage extends StatefulWidget {
  const ThemeIntroPage({
    required this.onNextPage,
    Key? key }) : super(key: key);
  final Function() onNextPage;

  @override
  State<ThemeIntroPage> createState() => _ThemeIntroPageState();
}

class _ThemeIntroPageState extends State<ThemeIntroPage> {

  // Switching to next page, using this boolean to animated this page exit
  bool switchingToNextPage = false;

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = Provider.of(context);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: switchingToNextPage ? 0 : 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // App Name
          const SizedBox(height: 90),
          ShowUpTransition(
            child: Text(
              Languages.of(context)!.labelSelectYourPreferred,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ShowUpTransition(
            child: Text(
              Languages.of(context)!.labelTheme,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w800,
                fontSize: 56,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ShowUpTransition(
              delay: const Duration(milliseconds: 200),
              child: PageView(
                onPageChanged: (index) {
                  switch (index) {
                    case 0:
                      uiProvider.updateThemeMode(ThemeMode.system);
                      break;
                    case 1:
                      uiProvider.updateThemeMode(ThemeMode.light);
                      break;
                    case 2:
                      uiProvider.updateThemeMode(ThemeMode.dark);
                      break;
                    default:
                      uiProvider.updateThemeMode(ThemeMode.system);
                      break;
                  }
                },
                controller: PageController(viewportFraction: 0.8, initialPage: initialPage(uiProvider.themeMode)),
                scrollDirection: Axis.horizontal,
                children: [
                  // System Theme
                  _themeTile(ThemeMode.system),
                  // White Theme
                  _themeTile(ThemeMode.light),
                  // Dark Theme
                  _themeTile(ThemeMode.dark),
                  
                ],
              ),
            )
          ),
          // Next Button
          ShowUpTransition(
            delay: const Duration(milliseconds: 400),
            child: InkWell(
              onTap: () async {
                setState(() {
                  switchingToNextPage = true;
                });
                await Future.delayed(const Duration(milliseconds: 200));
                widget.onNextPage();
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 32),
                padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 32, right: 32
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(Languages.of(context)!.labelContinue, style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _themeTile(ThemeMode mode) {
    UiProvider uiProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        uiProvider.updateThemeMode(mode);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 24),
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 16,
                  spreadRadius: 0.2,
                  color: Theme.of(context).shadowColor
                )
              ]
            ),
            child: Image.asset(
              mode == ThemeMode.system
                ? 'assets/images/systemPreview.png'
                : mode == ThemeMode.light
                  ? 'assets/images/lightPreview.png'
                  : 'assets/images/darkPreview.png'
            ),
          ),
          const SizedBox(height: 16),
          AnimatedSwitcher(
            key: UniqueKey(),
            duration: const Duration(milliseconds: 200),
            child: Text(
              mode == ThemeMode.system
                ? Languages.of(context)!.labelSystem
                : mode == ThemeMode.light
                  ? Languages.of(context)!.labelLight
                  : Languages.of(context)!.labelDark,
              style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    );
  }

  int initialPage(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
    }
  }

}