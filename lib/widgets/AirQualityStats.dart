import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import '../mqtt.dart';

class AirQualityStats extends StatefulWidget {

  final String sensorTopic;

  AirQualityStats(this.sensorTopic);

  @override
  State<StatefulWidget> createState() {
    return AirQualityStatsState(sensorTopic);
  }
}

class AirQualityStatsState extends State<AirQualityStats> {
  int temp = 0;
  int humidity = 0;
  int tvoc = 0;

  Color _yellow = Colors.yellow;
  Color _red = Colors.red;
  Color _white = Colors.white;

  AirQualityStatsState(String sensorTopic) {
    subscribe("$sensorTopic/measure-humidity", (result) {
      setState(() {
        humidity = double.parse(result).round();
      });
    });

    subscribe("$sensorTopic/measure-temperature", (result) {
      setState(() {
        temp = double.parse(result).round();
      });
    });

    subscribe("$sensorTopic/measure-voc", (result) {
      setState(() {
        tvoc = double.parse(result).round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$temp °C", style: h1.copyWith(fontSize: 60)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$humidity %",
                  style: h2.copyWith(color: determineHumidityColor(humidity)),
                ),
                Container(width: 15,),
                Text(
                  "$tvoc ppm",
                  style: h2.copyWith(color: determinePPMColor(tvoc)),
                )
              ],
            )
          ])
    );
  }

  Color determineHumidityColor(int humidityPercent) {
    if(humidityPercent >= 30 && humidityPercent <= 60) return _white;
    else if(humidityPercent >=25 && humidityPercent < 70) return _yellow;
    else return _red;
  }

  Color determinePPMColor(int ppm) {
    if(ppm < 400) return _white;
    else if(ppm < 1500) return _yellow;
    else return _red;
  }

}