import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:songtube/internal/languages.dart';


class MusicEqualizerSheet extends StatefulWidget {
  
  const MusicEqualizerSheet({
    @required this.equalizerMap,
    @required this.loudnessMap,
    Key key }) : super(key: key);
  final dynamic equalizerMap;
  final dynamic loudnessMap;

  @override
  _MusicEqualizerSheetState createState() => _MusicEqualizerSheetState();
}

class _MusicEqualizerSheetState extends State<MusicEqualizerSheet> {

  _EqualizationData equalizer;
  _LoudnessEqualizationData loudnessEqualization;

  @override
  void initState() {
    equalizer = _EqualizationData.fromMap(Map<String, dynamic>.from(widget.equalizerMap));
    loudnessEqualization = _LoudnessEqualizationData.fromMap(Map<String, dynamic>.from(widget.loudnessMap));
    super.initState();
  }

  void sendEqualizer() {
    AudioService.customAction('updateEqualizer', equalizer.toMap());
  }

  void sendLoudnessGain() {
    AudioService.customAction('updateLoudnessGain', loudnessEqualization.toMap());
  }

  SliderThemeData sliderTheme() {
    return SliderThemeData(
      thumbColor: Theme.of(context).accentColor,
      activeTrackColor: Theme.of(context).accentColor,
      trackHeight: 3,
      thumbShape: RoundSliderThumbShape(
        disabledThumbRadius: 8,
        enabledThumbRadius: 8
      ),
      inactiveTrackColor: Theme.of(context).cardColor
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App Title Bar
          Container(
            height: kToolbarHeight*1.1,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_rounded,
                    color: Theme.of(context).iconTheme.color),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Equalizer',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontSize: 22,
                          fontFamily: 'Product Sans',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 32)
              ],
            ),
          ),
          // Loudness Equalization Slider
          _loudnessEqualizationWidget(),
          // Equalizer Sliders
          _equalizerWidget(),
          // Bottom Padding
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 16,
          )
        ],
      ),
    );
  }

  Widget _loudnessEqualizationWidget() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Loudness Equalization Gain',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600
            )),
          value: loudnessEqualization.enabled,
          onChanged: (value) {
            setState(() => loudnessEqualization.enabled = value);
            sendLoudnessGain();
          }
        ),
        SliderTheme(
          data: sliderTheme(),
          child: Slider(
            min: -1,
            max: 1,
            value: loudnessEqualization.gain,
            onChanged: (gain) {
              setState(() => loudnessEqualization.gain = gain);
              sendLoudnessGain();
            },
          ),
        )
      ],
    );
  }

  Widget _equalizerWidget() {
    return Column(
      children: [
        CheckboxListTile(
          title: Text('Equalizer',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.w600
            )),
          value: equalizer.enabled,
          onChanged: (value) {
            setState(() => equalizer.enabled = value);
            sendEqualizer();
          }
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(equalizer.bands.length, (index) {
            return _bandSlider(index);
          })
        ),
      ],
    );
  }

  Widget _bandSlider(int bandIndex) {
    final band = equalizer.bands[bandIndex];
    return Column(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: SliderTheme(
            data: sliderTheme(),
            child: Slider(
              min: band.minFreq,
              max: band.maxFreq,
              value: band.gain,
              onChanged: (value) {
                setState(() => equalizer.bands[bandIndex].gain = value);
                sendEqualizer();
              }
            ),
          ),
        ),
        Text('${band.centerFrequency.round()}Hz'),
      ],
    );
  }

}

class _LoudnessEqualizationData {

  _LoudnessEqualizationData({
    @required this.enabled,
    @required this.gain
  });

  bool enabled;
  double gain;

  static _LoudnessEqualizationData fromMap(Map<String, dynamic> map) {
    return _LoudnessEqualizationData(
      enabled: map['enabled'] == 'true' ? true : false,
      gain: map['gain'] as double
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled ? 'true' : false,
      'gain': gain
    };
  }

}

class _EqualizationData {

  _EqualizationData({
    @required this.enabled,
    @required this.bands
  });

  bool enabled;
  List<_EqualizationBand> bands;
  

  static _EqualizationData fromMap(Map<String, dynamic> map) {
    final enabled = map['enabled'] == 'true' ? true : false;
    final bands = List.from(map['bands']);
    return _EqualizationData(
      enabled: enabled,
      bands: List.generate(bands.length, (index) {
        final band = bands[index];
        return _EqualizationBand.fromMap(Map<String, dynamic>.from(band));
      })
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'enabled': enabled ? 'true' : 'false',
      'bands': List.generate(bands.length, (index) {
        final band = bands[index];
        return {
          'centerFrequency': band.centerFrequency,
          'minFreq': band.minFreq,
          'maxFreq': band.maxFreq,
          'gain': band.gain
        };
      })
    };
  }

}

class _EqualizationBand {

  _EqualizationBand({
    @required this.centerFrequency,
    @required this.minFreq,
    @required this.maxFreq,
    @required this.gain,
  });

  final double centerFrequency;
  final double minFreq;
  final double maxFreq;
  double gain;
  
  static _EqualizationBand fromMap(Map<String, dynamic> map) {
    return _EqualizationBand(
      centerFrequency: map['centerFrequency'],
      minFreq: map['minFreq'],
      maxFreq: map['maxFreq'],
      gain: map['gain']
    );
  }

  Map<String, dynamic> toMap(_EqualizationBand band) {
    return {
      'centerFrequency': band.centerFrequency,
      'minFreq': band.minFreq,
      'maxFreq': band.maxFreq,
      'gain': band.gain
    };
  }

}