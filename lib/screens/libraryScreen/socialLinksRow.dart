import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 16),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => launch("https://t.me/songtubechannel"),
            child: Image.asset('assets/images/telegram.png')
          ),
          GestureDetector(
            onTap: () => launch("https://github.com/SongTube"),
            child: Image.asset('assets/images/github.png')
          ),
          GestureDetector(
            onTap: () => launch("https://facebook.com/songtubeapp/"),
            child: Image.asset('assets/images/facebook.png')
          ),
          GestureDetector(
            onTap: () => launch("https://instagram.com/songtubeapp"),
            child: Image.asset('assets/images/instagram.png')
          ),
        ],
      ),
    );
  }
}