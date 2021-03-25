import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../mqtt.dart';

class LightSlider extends StatefulWidget {
  String topic;
  String name;
  IconData icon;

  LightSlider(String lightName, this.name, { this.icon, Key key}) : super(key: key) {
    topic = "light/group/" + lightName + "/";
  }

  @override
  _LightSliderState createState() => _LightSliderState();
}

class _LightSliderState extends State<LightSlider> {
  double _value = 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Stack(children: [
        FlutterSlider(
        axis: Axis.vertical,
        values: [_value],
        tooltip: FlutterSliderTooltip(disabled: true),
        rtl: true,
        handler: FlutterSliderHandler(opacity: 0),
        trackBar: FlutterSliderTrackBar(
            activeTrackBarHeight: constraints.maxWidth,
            activeTrackBar: BoxDecoration(color: Colors.yellow),
            inactiveTrackBarHeight: constraints.maxWidth,
            inactiveTrackBar: BoxDecoration(color: Colors.white),
        ),
        onDragging: (int newValue, arg2, arg3) {
          setState(() {
            _value = arg2.roundToDouble();
          });
        },
        onDragCompleted: (int newValue, arg2, arg3) {
          publish(widget.topic + "brightness", arg2.round().toString());
          setState(() {
            _value = arg2.roundToDouble();
          });
        },
        min: 0.0,
        max: 100.0,
      ),
        IgnorePointer(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Text(widget.name)),
              Container(height: 10,),
              Center(child: Icon(widget.icon))
            ]),
        )]);
    });
  }
}
