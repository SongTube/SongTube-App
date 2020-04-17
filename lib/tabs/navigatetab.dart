import 'package:flutter/material.dart';

class NavigateTab extends StatefulWidget {
  @override
  _NavigateTabState createState() => _NavigateTabState();
}

class _NavigateTabState extends State<NavigateTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Flex(
          direction: Axis.vertical,
          
        ),
      ),
    );
  }
}