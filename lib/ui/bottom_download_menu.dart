// Flutter
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;

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
  double menuSize = 270;
  int subMenu;

  // Menu Border Colors
  Color audioTabBorderColor = Colors.black12;
  Color videoTabBorderColor = Colors.black12;

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

  void animateAudioTabBorderColor() async {
    setState(() => audioTabBorderColor = Colors.redAccent);
    Future.delayed(Duration(milliseconds: 60), () {
      setState(() => audioTabBorderColor = Colors.black12);
    });
  }

  void animateVideoTabBorderColor() async {
    setState(() => videoTabBorderColor = Colors.redAccent);
    Future.delayed(Duration(milliseconds: 60), () {
      setState(() => videoTabBorderColor = Colors.black12);
    });
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
                Text("Download", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Spacer(),
                // Settings quick access
                GestureDetector(
                  onTap: widget.onSettingsPressed,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 4),
                        Icon(Icons.settings, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(width: 4)
                      ],
                    ),
                  ),
                ),
                // ------------------------------
                // Downloads Menu Back Button
                AnimatedSize(
                  duration: Duration(milliseconds: 60),
                  vsync: this,
                  child: subMenu == 1 || subMenu == 0 
                    ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        setState(() {
                          subMenu = 2;
                          menuSize = 270;
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
            child: SizedBox(height: 1, child: Divider(indent: 16, endIndent: 16)),
          ),
          // Downloads Menu
          Expanded(
            child: IntrinsicHeight(
              child: Stack(
                children: <Widget>[
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 80),
                    child: subMenu == null
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              animateAudioTabBorderColor();
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
                                border: Border.all(color: audioTabBorderColor, width: 2)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Icon(MdiIcons.musicBox, size: 100),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.redAccent
                                    ),
                                    child: Text(
                                      "Audio",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
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
                              animateVideoTabBorderColor();
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
                                border: Border.all(color: videoTabBorderColor, width: 2)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Icon(MdiIcons.movie, size: 100),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.redAccent
                                    ),
                                    child: Text(
                                      "Video",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white
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
          leading: Icon(Icons.music_note, color: Colors.redAccent),
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
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(30)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Download", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
                color: Colors.redAccent
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [100, 400],
            min: 0,
            max: 400,
            onDragging: (value, currentValue, upperValue) {
              double value = (currentValue/100);
              value = double.parse(value.toStringAsFixed(2));
              volumeStream.add(value);
              volumeModifier = value;
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: 0, to: 400, step: 10),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent
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
            Text("+400%", style: TextStyle(fontSize: 12)),
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
                color: Colors.redAccent
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [0, 20],
            min: -20,
            max: 20,
            onDragging: (value, currentValue, upperValue) {
              bassGainStream.add(currentValue.toInt());
              bassGain = currentValue.toInt();
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: -20, to: 20, step: 1),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent
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
            Text("-20", style: TextStyle(fontSize: 12)),
            Spacer(),
            Text("+20", style: TextStyle(fontSize: 12)),
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
                color: Colors.redAccent
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          child: FlutterSlider(
            values: [0, 20],
            min: -20,
            max: 20,
            onDragging: (value, currentValue, upperValue) {
              trebleGainStream.add(currentValue.toInt());
              trebleGain = currentValue.toInt();
            },
            step: FlutterSliderStep(
              isPercentRange: true,
              rangeList: [
                FlutterSliderRangeStep(from: -20, to: 20, step: 1),
              ]
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
              ),
              activeTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.redAccent
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
            Text("-20", style: TextStyle(fontSize: 12)),
            Spacer(),
            Text("+20", style: TextStyle(fontSize: 12)),
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
            leading: Icon(Icons.videocam, color: Colors.redAccent),
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
              padding: EdgeInsets.only(top: 16, bottom: 16, left: 32),
              child: Row(
                children: <Widget>[
                  Text(
                    "Quality: ",
                    style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.videoList[index].videoResolution.toString() + " " +
                    widget.videoList[index].framerate.toString() + "fps "
                  ),
                  widget.videoList[index].videoQualityLabel.contains(new RegExp(r'HDR'))
                  ? Text(
                    "HDR ", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
                  ) : Container(),
                  Text(
                    (((widget.videoList[index].size)/1024)/1024).toStringAsFixed(2) +
                    "MB", style: TextStyle(fontSize: 12),
                  ),
                  Spacer(),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(Icons.file_download, color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, ["Video", index.toString()]);
                    },
                  ),
                  SizedBox(width: 18)
                ],
              ),
            );
          },
        )
      ],
    );
  }
}