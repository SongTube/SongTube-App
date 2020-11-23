import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class STSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSearch;
  final Function onBack;
  final Function onClear;
  final Function(String) onChanged;
  final Widget leadingIcon;
  final String searchHint;
  STSearchBar({
    @required this.controller,
    @required this.focusNode,
    @required this.onSearch,
    this.onBack,
    this.onClear,
    this.leadingIcon,
    this.searchHint = "",
    this.onChanged
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            offset: Offset(0.0, 4), //(x,y)
            blurRadius: 7.0,
            spreadRadius: 0.1
          ),
        ],
      ),
      child: Row(
        children: [
          if (onBack != null)
          IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
            onPressed: onBack
          ),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor
                  .withOpacity(0.6),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Theme(
                      data: ThemeData(primaryColor: Theme.of(context).accentColor),
                      child: TextField(
                        focusNode: focusNode,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: 14
                        ),
                        controller: controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(13.0),
                          prefixIcon: leadingIcon == null
                            ? Container() : leadingIcon,
                          hintText: searchHint,
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
                        onSubmitted: (searchQuery) {
                          onSearch(searchQuery);
                        },
                        onChanged: (text) => onChanged(text),
                      ),
                    ),
                  ),
                  if (onClear != null)
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: controller.text != ""
                      ? IconButton(
                          icon: Icon(EvaIcons.trashOutline,
                            color: Theme.of(context).iconTheme.color,
                            size: 18),
                          onPressed: onClear
                        )
                      : Container()
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 16)
        ],
      )
    );
  }
}