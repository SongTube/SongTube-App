import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:songtube/internal/languages.dart';
import 'package:songtube/provider/managerProvider.dart';
import 'package:songtube/ui/components/autoHideScaffold.dart';
import 'package:songtube/ui/components/searchBar.dart';
import 'package:songtube/ui/layout/streamsLargeThumbnail.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  _SubscriptionsScreenState createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    ManagerProvider manager = Provider.of<ManagerProvider>(context);
    return AutoHideScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 250),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Icon(
                  EvaIcons.bookOpenOutline,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                "Subscriptions",
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color
                ),
              ),
              Spacer(),
            ],
          )
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            // TODO: Channels carousel
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[600].withOpacity(0.1),
            indent: 12,
            endIndent: 12
          ),
          // TODO: Subscriptions feed
          Spacer(),
        ]
      ),
    );
  }
}