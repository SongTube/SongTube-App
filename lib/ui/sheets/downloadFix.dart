import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/internal/nativeMethods.dart';
import 'package:songtube/ui/components/styledBottomSheet.dart';

class DownloadFixSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StyledBottomSheet(
      title: Languages.of(context).labelAndroid11Detected,
      content: Text(
        Languages.of(context).labelAndroid11DetectedJustification,
        style: GoogleFonts.poppins(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            "Allow",
            style: GoogleFonts.poppins(
              color: Theme.of(context).accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () {
            NativeMethod.requestAllFilesPermission();
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            "Not Now",
            style: GoogleFonts.poppins(
              color: Theme.of(context).accentColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () => Navigator.pop(context)
        )
      ],
    );
  }
}