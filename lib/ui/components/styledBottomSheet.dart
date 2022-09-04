import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/internal/languages.dart';

class StyledBottomSheetList extends StatefulWidget {
  /// List of [StyledBottomSheet] that will be displayed
  final List<Widget> children;
  StyledBottomSheetList({
    @required this.children
  });

  @override
  _StyledBottomSheetListState createState() => _StyledBottomSheetListState();
}

class _StyledBottomSheetListState extends State<StyledBottomSheetList> with TickerProviderStateMixin {

  int _selectedIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = List.generate(widget.children.length, (index) => widget.children[index]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15)
      ),
      child: AnimatedSize(
        duration: Duration(milliseconds: 300),
        vsync: this,
        child: Column(
          children: [
            // Main Body
            AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              child: widget.children[_selectedIndex],
            ),
            Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey[600].withOpacity(0.1),
                indent: 12,
                endIndent: 12
              ),
            Container(
              height: 50,
              color: Theme.of(context).cardColor,
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Current Screen
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16, bottom: 16,
                        right: 24, left: 24
                      ),
                      child: Text(
                        "${_selectedIndex+1}/${widget.children.length}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).accentColor,
                          letterSpacing: 3
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: screens.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          margin: EdgeInsets.only(left: 8, right: 8),
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: _selectedIndex == index
                              ? Theme.of(context).accentColor
                              : Theme.of(context).iconTheme.color.withOpacity(0.08)
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedIndex+1 == widget.children.length) {
                          Navigator.pop(context);
                        } else {
                          setState(() => _selectedIndex += 1);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 16, bottom: 16,
                          right: 24, left: 24
                        ),
                        child: Text(
                          _selectedIndex+1 == widget.children.length
                            ? Languages.of(context).labelExit
                            : Languages.of(context).labelNext,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).padding.bottom,
              color: Theme.of(context).cardColor
            )
          ],
        ),
      ),
    );
  }
}

class StyledBottomSheet extends StatelessWidget {
  /// Title Widget
  final String title;
  /// Title leading Widget
  final Widget leading;
  /// BottomSheet Body
  final Widget content;
  /// BottomSheet Actions
  final List<Widget> actions;
  /// Content Padding
  final EdgeInsetsGeometry contentPadding;
  /// Actions Padding
  final EdgeInsetsGeometry actionsPadding;
  /// On dismiss
  final Function onDismiss;
  /// Add padding at the bottom of the sheet
  final bool addBottomPadding;
  StyledBottomSheet({
    this.title,
    this.leading,
    @required this.content,
    this.actions,
    this.contentPadding = const EdgeInsets.only(
      top: 24, right: 24, left: 24, bottom: 12
    ),
    this.actionsPadding = const EdgeInsets.only(
      right: 24, left: 24, bottom: 12
    ),
    this.onDismiss,
    this.addBottomPadding = false
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15)
      ),
      child: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            if (title != null)
            AppBar(
              centerTitle: false,
              backgroundColor: Theme.of(context).cardColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(title, style: GoogleFonts.poppins(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.w600,
                fontSize: 24
              )),
              leading: leading,
            ),
            if (title != null)
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey[600].withOpacity(0.1),
              indent: 12,
              endIndent: 12
            ),
            Padding(
              padding: contentPadding,
              child: content,
            ),
            if (actions != null)
            Padding(
              padding: actionsPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions
              ),
            ),
            if (addBottomPadding)
            Container(
              height: MediaQuery.of(context).padding.bottom,
              color: Theme.of(context).cardColor
            )
          ],
        ),
      )
    );
  }
}