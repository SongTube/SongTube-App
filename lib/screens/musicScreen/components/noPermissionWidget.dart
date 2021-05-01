// Flutter
import 'package:flutter/material.dart';

// Packages
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:songtube/internal/languages.dart';

class NoPermissionWidget extends StatelessWidget {
  final Function onPermissionRequest;
  NoPermissionWidget({
    @required this.onPermissionRequest
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(EvaIcons.saveOutline, size: 80),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Text(
              Languages.of(context).labelNoPermissionJustification,
              style: TextStyle(
                fontFamily: 'YTSans',
                fontSize: 20
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => onPermissionRequest(),
            child: Container(
              margin: EdgeInsets.only(bottom: 32),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).accentColor
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 8),
                    child: Text(
                      Languages.of(context).labelAllow + " " +
                      Languages.of(context).labelAccess,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Icon(
                      EvaIcons.radioButtonOnOutline,
                      color: Colors.white,
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}