import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqttdashboard/globals.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../mqtt.dart';
import 'StoneCard.dart';

class GaugeStone extends StatefulWidget {
  final String title;
  final double min;
  final double max;
  final double value;
  final String valuePostfix;
  final String topic;

  GaugeStone(this.title, this.topic, {this.min=0,this.max=100, this.value=40,this.valuePostfix=""});

  @override
  State<StatefulWidget> createState() {
    print("topic"+topic);
    return GaugeStoneState(value,topic??"");
  }
}

class GaugeStoneState extends State<GaugeStone> {
  double value;

  GaugeStoneState(this.value,topic) {
    subscribe(topic, (message) => setState((){
      value = double.parse(message);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return StoneCard(
      SfRadialGauge(
        title: buildTitle(),
        axes: [buildAxis()],
      )
    );
  }

  RadialAxis buildAxis() {
    return RadialAxis(
      minimum: widget.min,
      maximum: widget.max,
      showTicks: false,
      showLabels: false,
      annotations: [
        GaugeAnnotation(
            angle: 90,
            positionFactor: 0,
            widget: Text(
              value.toString()+widget.valuePostfix,
              style: h2,
            )
        )
      ],
      pointers: <GaugePointer>[
        RangePointer(
          value: value ?? 0,
          width: 10,
          pointerOffset: 0,
          cornerStyle: CornerStyle.bothCurve,
          color: const Color(0xFFF67280),
          gradient: const SweepGradient(
              colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
              stops: <double>[0.25, 0.75]),
        ),
      ]
    );
  }

  GaugeTitle buildTitle() {
    return GaugeTitle(
      text: widget.title,
      textStyle: h2,
      backgroundColor: Colors.transparent,
      alignment: GaugeAlignment.center
    );
  }
}