import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/languages/languages.dart';
import 'package:songtube/ui/animations/show_up.dart';
import 'package:songtube/ui/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({
    required this.onNextPage,
    Key? key }) : super(key: key);
  final Function() onNextPage;

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  // Switching to next page, using this boolean to animated this page exit
  bool switchingToNextPage = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: switchingToNextPage ? 0 : 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // NewPipe Extractor Credits and Language
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(Uri.parse('https://github.com/TeamNewPipe/NewPipeExtractor'), mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.all(16).copyWith(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            MdiIcons.youtube,
                            size: 40,
                            color: Colors.white
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: smallTextStyle(context).copyWith(color: Colors.white.withOpacity(0.8)),
                            children: [
                              TextSpan(
                                text: "${Languages.of(context)!.labelPoweredBy}\n",
                              ),
                              TextSpan(
                                text: "NewPipe Extractor",
                                style: subtitleTextStyle(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold)
                              )
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                _createLanguageDropDown(context),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                DateTime.now().month == 12
                  ? 'assets/images/logo_christmas.png'
                  : 'assets/images/logo.png'
              )
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${Languages.of(context)!.labelAppWelcome.toLowerCase()}\n",
                    style: textStyle(context).copyWith(color: Colors.white.withOpacity(0.8))
                  ),
                  TextSpan(
                    text: "SongTube",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      letterSpacing: 2,
                      color: Colors.white
                    ),
                  )
                ]
              ),
            ),
            const Spacer(),
            // Get Started Button
            ShowUpTransition(
              delay: const Duration(milliseconds: 200),
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
                  child: Text(Languages.of(context)!.labelGetStarted, style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _createLanguageDropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 8),
      child: DropdownButton<LanguageData>(
        alignment: Alignment.centerRight,
        iconSize: 26,
        hint: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            Localizations.localeOf(context).languageCode.toUpperCase(),
            style: textStyle(context).copyWith(color: Colors.white, fontWeight: FontWeight.w900)
          ),
        ),
        icon: const SizedBox(),
        onChanged: (LanguageData? language) {
          if (language == null) return;
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
                      color: Theme.of(context).textTheme.bodyText1!.color
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