import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:songtube/ui/components/styledBottomSheet.dart';
import 'package:songtube/ui/dialogs/licenseDialog.dart';

class DisclaimerSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StyledBottomSheet(
      title: "Disclaimer",
      content: Text(
        "This Software is released \"as-is\", without any warranty, responsibility or liability. " +
        "In no event shall the Author of this Software be liable for any special, consequential, " +
        "incidental or indirect damages whatsoever (including, without limitation, damages for "   +
        "loss of business profits, business interruption, loss of business information, or any "   +
        "other pecuniary loss) arising out of the use of inability to use this product, even if "  +
        "Author of this Sotware is aware of the possibility of such damages and known defect.",
        style: GoogleFonts.poppins(
          color: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => LicenseDialog()
            );
          },
          child: Text("License", style: GoogleFonts.poppins(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w600,
            fontSize: 18
          )),
        ),
      ],
    );
  }
}