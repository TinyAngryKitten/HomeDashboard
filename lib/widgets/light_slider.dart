import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:mqttdashboard/widgets/StoneCard.dart';

import '../mqtt.dart';

class LightSlider extends StatefulWidget {
  String topic;

  LightSlider(String lightName, {Key key}) : super(key: key) {
    topic = "light/group/"+lightName+"/";
  }

  @override
  _LightSliderState createState() => _LightSliderState();
}

class _LightSliderState extends State<LightSlider> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return StoneCard(
      FluidSlider(
      value: _value,
      start: Container(),
      end: Container(),
      onChanged: (newValue){
        setState(() {
          _value = newValue;
        });
        },
      onChangeEnd: (double newValue) {
        setState(() {
          _value = newValue;
          publish(widget.topic+"brightness", newValue.round().toString());
        });
      },
      min: 0.0,
      max: 100.0,
    ),);
  }
}