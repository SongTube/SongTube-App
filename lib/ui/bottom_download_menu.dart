// Flutter
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

// Packages
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;

class CustomDownloadMenu extends StatelessWidget {
  final List<youtube.VideoStreamInfo> videoList;
  final Function onSettingsPressed;
  CustomDownloadMenu({
    @required this.videoList,
    @required this.onSettingsPressed
  }){
    volumeStream.add(1);
    bassGainStream.add(0);
    trebleGainStream.add(0);
  }

  final StreamController<double> volumeStream = new StreamController<double>();
  final StreamController<int> bassGainStream = new StreamController<int>();
  final StreamController<int> trebleGainStream = new StreamController<int>();
  double volumeModifier = 1;
  int bassGain = 0;
  int trebleGain = 0;
  
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

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 8, top: 12),
            child: Row(
              children: <Widget> [
                Text("Download", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                Spacer(),
                GestureDetector(
                  onTap: onSettingsPressed,
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
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: SizedBox(height: 1, child: Divider(indent: 16, endIndent: 16)),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.music_note, color: Colors.redAccent),
                        title: Text("Audio", style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color, fontWeight: FontWeight.w600)),
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
                      StreamBuilder<Object>(
                        stream: volumeStream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
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
                                  volumeString(snapshot.data),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.redAccent
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }
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
                      StreamBuilder<Object>(
                        stream: bassGainStream.stream,
                        builder: (context, snapshot) {
                          return Row(
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
                                snapshot.data.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent
                                ),
                              ),
                            ],
                          );
                        }
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
                      StreamBuilder<Object>(
                        stream: trebleGainStream.stream,
                        builder: (context, snapshot) {
                          return Row(
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
                                snapshot.data.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent
                                ),
                              ),
                            ],
                          );
                        }
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: SizedBox(height: 1, child: Divider(indent: 16, endIndent: 16)),
                ),
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
                  itemCount: videoList.length,
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
                            videoList[index].videoResolution.toString() + " " +
                            videoList[index].framerate.toString() + "fps "
                          ),
                          videoList[index].videoQualityLabel.contains(new RegExp(r'HDR'))
                          ? Text(
                            "HDR ", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.redAccent),
                          ) : Container(),
                          Text(
                            (((videoList[index].size)/1024)/1024).toStringAsFixed(2) +
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
            ),
          ),
        ],
      ),
    );
  }
}