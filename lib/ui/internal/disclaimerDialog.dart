import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:songtube/provider/configurationProvider.dart';
import 'package:songtube/ui/internal/licenseDialog.dart';

class DisclaimerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConfigurationProvider appData = Provider.of<ConfigurationProvider>(context);
    return WillPopScope(
      onWillPop: () {
        if (appData.disclaimerAccepted)
          return Future.value(true);
        else
          return Future.value(false);
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("Disclaimer", style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1.color,
        )),
        content: SingleChildScrollView(
          child: Text(
            "This Software is released \"as-is\", without any warranty, responsability or liability. " +
            "In no event shall the Author of this Software be liable for any special, consequential, " +
            "indidental or indirect damages whatsoever (including, without limitation, damages for "   +
            "loss of business profits, business interruption, loss of business information, or any "   +
            "other pecuniary loss) arising out of the use of inability to use this product, even if "  +
            "Author of this Sotware is aware of the possibility of such damages and known defect.",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              appData.disclaimerAccepted = true;
              Navigator.pop(context);
            },
            child: Text("OK", style: TextStyle(
              color: Theme.of(context).accentColor,
            )),
          ),
          FlatButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => LicenseDialog()
              );
            },
            child: Text("License", style: TextStyle(
              color: Theme.of(context).accentColor,
            )),
          ),
          FlatButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text("Exit", style: TextStyle(
              color: Theme.of(context).accentColor,
            )),
          ),
        ],
      ),
    );
  }
}