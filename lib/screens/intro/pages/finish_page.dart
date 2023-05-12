import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:songtube/providers/media_provider.dart';
import 'package:songtube/ui/animations/show_up.dart';

class FinishIntroPage extends StatefulWidget {
  const FinishIntroPage({
    required this.onIntroFinish,
    Key? key }) : super(key: key);
  final Function() onIntroFinish;

  @override
  State<FinishIntroPage> createState() => _FinishIntroPageState();
}

class _FinishIntroPageState extends State<FinishIntroPage> {
  
  // Switching to next page, using this boolean to animated this page exit
  bool switchingToNextPage = false;

  // After 10s, allow the user to go to the homescreen even if his
  // list of songs has not completely loaded yet
  bool forceSkipMediaFetch = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        forceSkipMediaFetch = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of(context);
    bool isLoading = mediaProvider.fetchMediaRunning && !forceSkipMediaFetch;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: switchingToNextPage ? 0 : 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // App Name
            const SizedBox(height: 90),
            ShowUpTransition(
              child: Text(
                'We are done',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ShowUpTransition(
              child: Text(
                'Enjoy the\nApp!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 56,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            // Current Text
            ShowUpTransition(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'SongTube is back with a cleaner look and set of features, have fun with your music!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // Finish Button
            ShowUpTransition(
              delay: const Duration(milliseconds: 400),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    switchingToNextPage = true;
                  });
                  await Future.delayed(const Duration(milliseconds: 200));
                  widget.onIntroFinish();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 32, right: 32
                  ),
                  decoration: BoxDecoration(
                    color: !isLoading ? Theme.of(context).primaryColor : Colors.black,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: !isLoading
                    ? Text('Let\'s Go', style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ))
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor))),
                          const SizedBox(width: 16),
                          Text('Please wait...', style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ))
                        ]
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}