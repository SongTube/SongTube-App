import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class STSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSearch;
  final Function onBack;
  final Function onClear;
  final Function(String) onChanged;
  final Function onTap;
  final Widget leadingIcon;
  final String searchHint;
  STSearchBar({
    @required this.controller,
    @required this.focusNode,
    @required this.onSearch,
    this.onBack,
    this.onClear,
    this.onTap,
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
      ),
      child: Container(
        height: 45,
        margin: EdgeInsets.only(
          left: 18,
          right: 18,
          top: 4,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Expanded(
              child: Theme(
                data: ThemeData(primaryColor: Theme.of(context).accentColor),
                child: TextField(
                  onTap: onTap,
                  focusNode: focusNode,
                  keyboardType: TextInputType.url,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontSize: 16
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  controller: controller,
                  cursorColor: Theme.of(context).accentColor,
                  cursorRadius: Radius.circular(20),
                  decoration: InputDecoration(
                    prefixIcon: leadingIcon == null
                      ? Container() : leadingIcon,
                    hintText: searchHint,
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.6),
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
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
                    splashColor: Colors.transparent,
                    icon: Icon(EvaIcons.trashOutline,
                      color: Theme.of(context).iconTheme.color,
                      size: 18),
                    onPressed: onClear
                  )
                : IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(EvaIcons.searchOutline,
                      color: Theme.of(context).iconTheme.color
                        .withOpacity(0.8)),
                    onPressed: onTap
                  )
            ),
            SizedBox(width: 4)
          ],
        ),
      )
    );
  }
}