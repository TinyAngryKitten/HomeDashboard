import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:flutter_wall_layout/layout/wall_layout.dart';
import 'package:mqttdashboard/ButtonCollection.dart';
import 'package:mqttdashboard/widgets/ButtonStone.dart';
import 'package:mqttdashboard/widgets/GaugeStone.dart';
import 'package:mqttdashboard/widgets/LightSlider.dart';
import 'package:mqttdashboard/widgets/NavBar.dart';

import 'PhoneAppBar.dart';
import 'globals.dart';
import 'main.dart';

String room = "Livingroom";

class PhoneApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyApp( Scaffold(
          body: Container(
              margin: EdgeInsets.all(25),
              color: backgroundColor,
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PhoneAppBar("Living room"),
                      FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Center(
                              child: GaugeStone(
                            "",
                            "homey/livingroomsensor/measure-temperature",
                            valuePostfix: " °C",
                          ))),

                      buildSpacer(),
                      buildSliderRow(),

                      buildSpacer(),
                      buildActionRow(),

                      buildSpacer(),
                      buildStateRow(),

                      Expanded(child: Container(),),
                      NavBar()
                      //LightSlider("hallway", "Hallway", icon: Icons.lightbulb),
                    ]),
              ))),
    );
  }

  Widget buildSpacer() => Container(height: 30,);

  Widget buildActionRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      NightButton(),
      NightButton(),
      NightToggle()
    ],
  );

  Widget buildStateRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      NightToggle(),
      NightToggle(),
      NightToggle(),
    ],
  );

  Widget buildSliderRow() {
    double height = 150;
    double width = 110;
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        LightSlider("hallway", "Hallway", icon: Icons.lightbulb, height: height, width: width,),
        LightSlider("living room", "Livingroom", icon: Icons.lightbulb, height: height, width: width,)
      ],);
    });
  }
}

Stone spaceStone(int id, int width, int height) {
  return Stone(id: id,child: Container(), width: width, height: height,);
}