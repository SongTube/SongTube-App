import 'package:flutter/material.dart';

class ChannelPageBottomSheet extends StatelessWidget {
  const ChannelPageBottomSheet({
    @required this.onPlayAll,
    @required this.onDownloadAll,
    Key key }) : super(key: key);
  final Function() onPlayAll;
  final Function() onDownloadAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}