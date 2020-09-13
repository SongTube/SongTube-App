// Flutter
import 'package:flutter/material.dart';

// Internal
import 'package:songtube/provider/managerProvider.dart';

// Packages
import 'package:provider/provider.dart';

// UI
import 'package:songtube/screens/downloadsPages/downloads.dart';

class DownloadTab extends StatefulWidget {
  _DownloadTabState createState() => _DownloadTabState();
}

class _DownloadTabState extends State<DownloadTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: DownloadingPage()),
    );
  }
}