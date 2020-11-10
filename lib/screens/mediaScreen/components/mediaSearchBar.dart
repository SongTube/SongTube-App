import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';

class MediaSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function onClear;
  MediaSearchBar({
    @required this.textController,
    @required this.focusNode,
    @required this.onChanged,
    @required this.onClear
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight*0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Theme(
          data: ThemeData(primaryColor: Theme.of(context).accentColor),
          child: Stack(
            children: [
              TextField(
                keyboardType: TextInputType.url,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 14
                ),
                focusNode: focusNode,
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14.0),
                  prefixIcon: Icon(EvaIcons.searchOutline, size: 22, color: Colors.red),
                  hintText: Languages.of(context).labelSearchMedia,
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
                onChanged: (String searchQuery) => onChanged(searchQuery),
                onSubmitted: (searchQuery) {
                  FocusScope.of(context).unfocus();
                }
              ),
              Align(
                alignment: Alignment.centerRight,
                child: textController.text != ""
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                        color: Theme.of(context).iconTheme.color
                      ),
                      onPressed: onClear
                    )
                  : Container(),
              )
            ],
          ),
        ),
      )
    );
  }
}