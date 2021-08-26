import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';
import 'package:string_validator/string_validator.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoArtworkEditor extends StatelessWidget {
  final Function onArtworkTap;
  final String artworkUrl;
  VideoArtworkEditor({
    required this.onArtworkTap,
    required this.artworkUrl
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(10)
            ),
            color: Theme.of(context).cardColor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(color: Theme.of(context).cardColor, width: 4)
                ),
                child: Center(
                  child: Icon(EvaIcons.musicOutline),
                ),
              ),
              Container(
                width: 50,
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  Languages.of(context)!.labelTagsEditor,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: onArtworkTap as void Function()?,
          child: Container(
            padding: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(25)
              ),
              color: Theme.of(context).cardColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  margin: EdgeInsets.only(right: 8),
                  child: Text(
                    Languages.of(context)!.labelEditArtwork,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: FadeInImage(
                          fadeInDuration: Duration(milliseconds: 300),
                          placeholder: MemoryImage(kTransparentImage),
                          image: (isURL(artworkUrl)
                            ? NetworkImage(artworkUrl)
                            : FileImage(File(artworkUrl))) as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
                        color: Theme.of(context).cardColor.withOpacity(0.4)
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: Icon(EvaIcons.editOutline, size: 18, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}