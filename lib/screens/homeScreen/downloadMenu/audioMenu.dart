import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class AudioDownloadMenu extends StatefulWidget {
  final Function(List<dynamic>) onDownload;
  AudioDownloadMenu({
    @required this.onDownload
  });
  @override
  _AudioDownloadMenuState createState() => _AudioDownloadMenuState();
}

class _AudioDownloadMenuState extends State<AudioDownloadMenu> {

  // Variables
  double volumeModifier = 1;
  int bassGain = 0;
  int trebleGain = 0;

  void _onDownload() {
    List<dynamic> list = [
      "Audio",
      "null", 
      volumeModifier.toString(),
      bassGain.toString(),
      trebleGain.toString(),
    ];
    widget.onDownload(list);
  }

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

  @override
  Widget build(BuildContext context) {
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
          onTap: _onDownload
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
              volumeString(volumeModifier),
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
              setState(() => volumeModifier = value);
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
              bassGain.toString(),
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
              setState(() => bassGain = currentValue.toInt());
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
              trebleGain.toString(),
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
              setState(() => trebleGain = currentValue.toInt());
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
}