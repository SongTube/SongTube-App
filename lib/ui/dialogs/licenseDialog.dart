import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class LicenseDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("LICENSE", style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1.color,
      )),
      content: FutureBuilder(
        future: getLicense(),
        builder: (context, AsyncSnapshot<String> license) {
          if (license.hasData) {
            return SingleChildScrollView(
              child: Text(license.data, style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
              )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("OK", style: TextStyle(
            color: Theme.of(context).accentColor,
          )),
        )
      ],
    );
  }

  Future<String> getLicense() async {
    return await rootBundle.loadString('assets/LICENSE');
  }

}
