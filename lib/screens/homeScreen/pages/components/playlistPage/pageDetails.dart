import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:songtube/ui/components/textfieldTile.dart';

class PlaylistPageDetails extends StatelessWidget {
  final String title;
  final String author;
  final TextEditingController albumController;
  PlaylistPageDetails({
    @required this.title,
    @required this.albumController,
    @required this.author
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Theme.of(context).cardColor
                ),
                child: Icon(
                  MdiIcons.playlistMusicOutline,
                  color: Theme.of(context).iconTheme.color
                )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video Title
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 4, top: 12),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyText1.color
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Video Author
                    Padding(
                      padding: const EdgeInsets.only(right: 16, bottom: 8),
                      child: Text(
                        author ?? "Youtube",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                          fontFamily: "Varela",
                          fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 150,
                  child: TextFieldTile(
                  textController: albumController,
                  icon: EvaIcons.bookOpenOutline,
                  inputType: TextInputType.text,
                  labelText: "Album",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}