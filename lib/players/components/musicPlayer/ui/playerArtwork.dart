// Dart
import 'dart:io';

// Flutter
import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/mediaProvider.dart';
import 'package:songtube/provider/preferencesProvider.dart';

class PlayerArtwork extends StatelessWidget {
  final File image;
  final Color textColor;
  final bool expandArtwork;
  PlayerArtwork({
    @required this.image,
    @required this.textColor,
    @required this.expandArtwork,
  });
  @override
  Widget build(BuildContext context) {
    MediaProvider mediaProvider = Provider.of<MediaProvider>(context);
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        prefs.musicPlayerArtworkRoundCorners),
      child: GestureDetector(
        onTap: () => mediaProvider.showLyrics = !mediaProvider.showLyrics,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 250),
              opacity: mediaProvider.showLyrics
                ? 0.0 : 1.0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: expandArtwork
                  ? _artwork(context)
                  : AspectRatio(
                      aspectRatio: 1,
                      child: _artwork(context),
                    )
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              child: mediaProvider.showLyrics 
                ? mediaProvider.currentLyrics == null
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          textColor
                        ),
                      )
                    )
                  : mediaProvider.currentLyrics == ""
                    ? Center(
                        child: Text(
                          "No Subtitles Found\n"
                          "Try changing your Tags",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textColor
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [textColor, Colors.transparent],
                            ).createShader(Rect.fromLTRB(0, rect.height-40, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [textColor, Colors.transparent],
                              ).createShader(Rect.fromLTRB(0, 0, 0, 20));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                child: Text(
                                  "\n" +
                                  mediaProvider.currentLyrics +
                                  "\n",
                                  textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 18,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w600
                                    ),
                                ),
                              ),
                            ),
                          )
                        ),
                      )
                : Container(),
            )
          ],
        ),
      )
    );
  }

  Widget _artwork(BuildContext context) {
    PreferencesProvider prefs = Provider.of<PreferencesProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          prefs.musicPlayerArtworkRoundCorners),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(
              prefs.musicPlayerArtworkRoundCorners),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withOpacity(0.2),
                offset: Offset(0,0), //(x,y)
                blurRadius: 14.0,
                spreadRadius: 2.0 
              )
            ],
          ),
          child: ImageFade(
            image: image == null
              ? AssetImage('assets/images/artworkPlaceholder_big.png')
              : FileImage(image),
            fadeDuration: Duration(milliseconds: 400),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}