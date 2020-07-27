import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:songtube/ui/animations/FadeIn.dart';
import 'package:songtube/ui/animations/showUp.dart';

class AccentPicker extends StatefulWidget {
  final ValueChanged<Color> onColorChanged;
  AccentPicker({
    @required this.onColorChanged
  });
  @override
  _AccentPickerState createState() => _AccentPickerState();
}

class _AccentPickerState extends State<AccentPicker> {
  @override
  Widget build(BuildContext context) {
    return FadeInTransition(
      duration: Duration(milliseconds: 250),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: 400,
          width: 300,
          child: Column(
            children: <Widget>[
              ShowUpTransition(
                delay: Duration(milliseconds: 100),
                duration: Duration(milliseconds: 200),
                child: Container(
                  margin: EdgeInsets.only(top: 24, bottom: 16),
                  child: Text(
                    "Choose Color",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22
                    ),
                  ),
                ),
              ),
              Divider(indent: 16, endIndent: 16),
              Expanded(
                child: FadeInTransition(
                  delay: Duration(milliseconds: 200),
                  duration: Duration(milliseconds: 200),
                  child: MaterialColorPicker(
                    circleSize: 50,
                    spacing: 10,
                    colors: const <ColorSwatch>[
                      Colors.red,
                      Colors.redAccent,
                      Colors.pink,
                      Colors.pinkAccent,
                      Colors.purple,
                      Colors.purpleAccent,
                      Colors.deepPurpleAccent,
                      Colors.indigo,
                      Colors.indigoAccent,
                      Colors.blue,
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.lightBlueAccent,
                      Colors.cyan,
                      Colors.cyanAccent,
                      Colors.teal,
                      Colors.tealAccent,
                      Colors.green,
                      Colors.greenAccent,
                      Colors.lightGreen,
                      Colors.lightGreenAccent,
                      Colors.lime,
                      Colors.limeAccent,
                      Colors.yellow,
                      Colors.yellowAccent,
                      Colors.amber,
                      Colors.amberAccent,
                      Colors.orange,
                      Colors.orangeAccent,
                      Colors.deepOrangeAccent,
                    ],
                    onMainColorChange: (color) => widget.onColorChanged(color),
                    selectedColor: Theme.of(context).accentColor
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}