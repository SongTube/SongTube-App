import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

class CreatePlaylistSheet extends StatefulWidget {
  const CreatePlaylistSheet({ Key key }) : super(key: key);

  @override
  State<CreatePlaylistSheet> createState() => _CreatePlaylistSheetState();
}

class _CreatePlaylistSheetState extends State<CreatePlaylistSheet> {

  // Text Controller
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: kToolbarHeight*1.1,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_rounded,
                  color: Theme.of(context).iconTheme.color),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Languages.of(context).labelCreate + " " +
                      Languages.of(context).labelPlaylist,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 18,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 32)
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey[600].withOpacity(0.1),
          indent: 12,
          endIndent: 12
        ),
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: TextField(
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontSize: 14
            ),
            controller: nameController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.playlist_play, color: Theme.of(context).accentColor),
              contentPadding: EdgeInsets.all(14.0),
              hintText: Languages.of(context).labelEditorTitle,
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.4),
                fontSize: 14
              ),
              border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  width: 0, 
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  Languages.of(context).labelCancel,
                  style: TextStyle(
                    color: Theme.of(context).accentColor
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(width: 8),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: nameController.text.isNotEmpty && nameController.text.length > 3
                    ? Theme.of(context).accentColor
                    : Theme.of(context).scaffoldBackgroundColor,
                ),
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextButton(
                  child: Text(
                    Languages.of(context).labelCreate,
                    style: TextStyle(
                      color: nameController.text.isNotEmpty && nameController.text.length > 3
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyText1.color 
                            .withOpacity(0.4)
                    ),
                  ),
                  onPressed: nameController.text.isNotEmpty && nameController.text.length > 3
                    ? () => Navigator.pop(context, nameController.text)
                    : null
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        )
      ],
    );
  }
}