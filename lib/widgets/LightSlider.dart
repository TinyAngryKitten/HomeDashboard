import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:mqttdashboard/widgets/CustomNeumorphicSlider.dart';
import '../custom_neu/custom_shade_progress_bar.dart';
import '../mqtt.dart';
import 'StoneCard.dart';

class LightSlider extends StatefulWidget {
  String topic;
  final String name;
  final IconData icon;
  final double height;
  final double width;

  LightSlider(String lightName, this.name,
      {this.icon, Key key, this.height = 100, this.width})
      : super(key: key) {
    topic = "light/group/" + lightName + "/";
  }

  @override
  _LightSliderState createState() => _LightSliderState(topic);
}

class _LightSliderState extends State<LightSlider> {
  double _value = 0;
  bool isChanging = false;//used to keep slider from changing on updates while user is moving the slider

  _LightSliderState(String topic) {
    subscribe(topic+"update/brightness", (brightness) {
      var brightnessValue = double.tryParse(brightness);
      if(brightnessValue == null || isChanging) return;
      else setState(() {
        _value = brightnessValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return Stack(children: [
      CustomNeumorphicSlider(
        value: _value,
        height: widget.height,
        width: widget.width,
        thumb: Container(),
        style: SliderStyle(
          depth: theme.depth,
          lightSource: theme.lightSource,
          accent: theme.accentColor,
          variant: theme.variantColor,
        ),
        sliderHeight: 20,
        onChanged: (double newValue) {
          setState(() {
            _value = newValue.roundToDouble();
            isChanging = true;
          });
        },
        onChangeEnd: (double newValue) {
          publish(widget.topic + "brightness", newValue.round().toString());
          setState(() {
            isChanging = false;
            _value = newValue.roundToDouble();
          });
        },
        min: 0.0,
        max: 100.0,
      ),
      IgnorePointer(
        child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    widget.name,
                    style: h3,
                  )),
                  Container(
                    height: 10,
                  ),
                  Center(
                      child: NeumorphicIcon(
                    widget.icon,
                    style: NeumorphicStyle(
                        shadowDarkColor: shadowColor,
                        shadowLightColor: softShadowColor,
                        color: lightBackgroundColor),
                  ))
                ])),
      )
    ]);
  }
}
