// Flutter
import 'dart:async';
import 'package:flutter/material.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class CustomDownloadMenu extends StatefulWidget {
  final List<youtube.VideoStreamInfo> videoList;
  final Function onSettingsPressed;
  CustomDownloadMenu({
    @required this.videoList,
    @required this.onSettingsPressed
  });
  @override
  _CustomDownloadMenuState createState() => _CustomDownloadMenuState();
}

class _CustomDownloadMenuState extends State<CustomDownloadMenu> with TickerProviderStateMixin {

  // Controllers
  final StreamController<double> volumeStream = new StreamController<double>();
  final StreamController<int> bassGainStream = new StreamController<int>();
  final StreamController<int> trebleGainStream = new StreamController<int>();

  // Variables
  double volumeModifier = 1;
  int bassGain = 0;
  int trebleGain = 0;
  double menuSize = 160;
  int subMenu;

  String volumeString(double value) {
    if (value == 1) {
      return "Default";
    } else if (value < 1) {
      return "-" + ((1-value)*100).toStringAsFixed(2) + "%";
    } else if (value > 1) {
      return "+" + (value*100).toStringAsFixed(2) + "%";
    } else {
      return "Not Supported";
    }
  }

  void initState() {
    volumeStream.add(1);
    bassGainStream.add(0);
    trebleGainStream.add(0);
    super.initState();
  }

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      height: menuSize,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 8, top: 12),
            child: Row(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.only(top: 8, left: 8),
                  child: Text("Download", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))
                  ),
                Spacer(),
                // Settings quick access
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 100),
                  child: subMenu == 1 || subMenu == 0
                  ? GestureDetector(
                      onTap: widget.onSettingsPressed,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                            Icon(EvaIcons.settingsOutline, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              "Settings",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Varela"
                              ),
                            ),
                            SizedBox(width: 4)
                          ],
                        ),
                      ),
                    )
                  : Container()
                ),
                // ------------------------------
                // Downloads Menu Back Button
                AnimatedSize(
                  duration: Duration(milliseconds: 60),
                  vsync: this,
                  child: subMenu == 1 || subMenu == 0 
                    ? IconButton(
                      icon: Icon(EvaIcons.arrowBackOutline),
                      onPressed: () {
                        setState(() {
                          subMenu = 2;
                          menuSize = 160;
                        });
                        Future.delayed(Duration(milliseconds: 60), () {
                          setState(() => subMenu = null);
                        });
                      },
                    )
                    : Container()
                ),
                // ------------------------------
              ]
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: SizedBox(height: 1),
          ),
          // Downloads Menu
          Expanded(
            child: Stack(
              children: <Widget>[
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 80),
                  child: subMenu == null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              menuSize = MediaQuery.of(context).size.height*0.55;
                              subMenu = 2;
                            });
                            Future.delayed(Duration(milliseconds: 60), () {
                              setState(() => subMenu = 0);
                            });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            duration: Duration(milliseconds: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  offset: Offset(0, 3), //(x,y)
                                  blurRadius: 6.0,
                                  spreadRadius: 0.01 
                                )
                              ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Theme.of(context).accentColor
                                  ),
                                  child: Icon(EvaIcons.musicOutline, size: 55, color: Colors.white),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Audio",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                      fontFamily: "Varela"
                                    )
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              menuSize = MediaQuery.of(context).size.height*0.55;
                              subMenu = 2;
                            });
                            Future.delayed(Duration(milliseconds: 60), () {
                              setState(() => subMenu = 1);
                            });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            duration: Duration(milliseconds: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.05),
                                  offset: Offset(0, 3), //(x,y)
                                  blurRadius: 6.0,
                                  spreadRadius: 0.01 
                                )
                              ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Theme.of(context).accentColor
                                  ),
                                  child: Icon(EvaIcons.videoOutline, size: 55, color: Colors.white),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Video",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.9),
                                      fontFamily: "Varela"
                                    )
                                  )
                                )
                              ]
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                  : Container(),
                ),
                StreamBuilder<Object>(
                  stream: volumeStream.stream,
                  builder: (context, snapshot) {
                    double vol = snapshot.data;
                    return StreamBuilder<Object>(
                      stream: bassGainStream.stream,
                      builder: (context, snapshot) {
                        int bass = snapshot.data;
                        return StreamBuilder<Object>(
                          stream: trebleGainStream.stream,
                          builder: (context, snapshot) {
                            int treble = snapshot.data;
                            return AnimatedSwitcher(
                              duration: Duration(milliseconds: 60),
                              child: subMenu == 0 
                              ? audioSection(context, vol, bass, treble)
                              : Container()
                            );
                          }
                        );
                      }
                    );
                  }
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 60),
                  child: subMenu == 1
                  ? videoSection(context)
                  : Container()
                ),
              ],
            ),
          ),
          // ------------------------------
        ],
      ),
    );
  }

  Widget audioSection(BuildContext context, double vol, int bass, int treble) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 8),
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(EvaIcons.musicOutline, color: Theme.of(context).accentColor),
          ),
          title: Text(
            "Audio",
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.w600
            )
          ),
          subtitle: Text("Download the audio from this video at maximum quality"),
          trailing: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Download", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "Varela")),
            ),
          ),
          onTap: () => Navigator.pop(context, [
            "Audio",
            "null", 
            volumeModifier.toString(),
            bassGain.toString(),
            trebleGain.toString(),
          ]),
        ),
        // Volume Modifier
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 16),
            Text(
              "Volume modifier: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              volumeString(vol),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [volumeModifier*100, 200],
            min: 0,
            max: 200,
            onDragging: (value, currentValue, upperValue) {
              double value = (currentValue/100);
              value = double.parse(value.toStringAsFixed(2));
              volumeStream.add(value);
              volumeModifier = value;
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: 0, to: 200, step: 5),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).accentColor
              ),
            ),
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 16),
            Text("-100%", style: TextStyle(fontSize: 12)),
            Spacer(),
            Text("+200%", style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
        // Bass Modifier
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 16),
            Text(
              "Bass Gain: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              bass.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [bassGain.toDouble(), 5],
            min: -5,
            max: 5,
            onDragging: (value, currentValue, upperValue) {
              bassGainStream.add(currentValue.toInt());
              bassGain = currentValue.toInt();
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: -5, to: 5, step: 1),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).accentColor
              ),
            ),
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 16),
            Text("-5", style: TextStyle(fontSize: 12)),
            Spacer(),
            Text("+5", style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: 16),
        // Treble Modifier
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 16),
            Text(
              "Treble Gain: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              treble.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [trebleGain.toDouble(), 5],
            min: -5,
            max: 5,
            onDragging: (value, currentValue, upperValue) {
              trebleGainStream.add(currentValue.toInt());
              trebleGain = currentValue.toInt();
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: -5, to: 5, step: 1),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).accentColor
              ),
            ),
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 16),
            Text("-5", style: TextStyle(fontSize: 12)),
            Spacer(),
            Text("+5", style: TextStyle(fontSize: 12)),
            SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  Widget videoSection(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(left: 22, right: MediaQuery.of(context).size.width*0.2),
          child: ListTile(
            leading: Icon(EvaIcons.videoOutline, color: Theme.of(context).accentColor),
            title: Text("Video", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontWeight: FontWeight.w600)),
            subtitle: Text("Download video at selected quality bellow"),
            onTap: () {},
          ),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.videoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.only(top: 16, bottom: 16, left: 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Quality: ",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.videoList[index].videoResolution.toString() + " " +
                      widget.videoList[index].framerate.toString() + "fps ",
                      style: TextStyle(fontFamily: "Varela"),
                    ),
                    widget.videoList[index].videoQualityLabel.contains(new RegExp(r'HDR'))
                    ? Text(
                      "HDR ", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor,
                        fontFamily: "Varela"
                      ),
                    ) : Container(),
                    Text(
                      (((widget.videoList[index].size)/1024)/1024).toStringAsFixed(2) +
                      "MB", style: TextStyle(fontSize: 12, fontFamily: "Varela"),
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(EvaIcons.downloadOutline, color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, ["Video", index.toString(), "1.0", "0", "0"]);
                      },
                    ),
                    SizedBox(width: 18)
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}