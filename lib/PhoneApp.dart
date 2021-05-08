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
    return MyApp(
      Scaffold(
          bottomNavigationBar: NavBar(),
          body: Container(
              margin: EdgeInsets.all(15),
              color: backgroundColor,
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PhoneAppBar(room),
                      AirQualityStats(room),

                      buildSpacer(),
                      buildSliderRow(),

                      Expanded(
                        child: Container(),
                      ),
                      buildSpacer(),
                      buildActionRow(),

                      Expanded(
                        child: Container(),
                      ),
                      buildSpacer(),
                      buildStateRow(),

                      Expanded(
                        child: Container(),
                      ),
                      //LightSlider("hallway", "Hallway", icon: Icons.lightbulb),
                    ]),
              ))),
    );
  }

  Widget AirQualityStats(String room) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("24 °C", style: h1.copyWith(fontSize: 60)),
            Text(
              "50 %",
              style: h2,
            )
          ],
        ));
  }

  Widget buildSpacer() => Container(
        height: 30,
      );

  Widget buildActionRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NightButton(),
          HomeButton(),
        ],
      );

  Widget buildStateRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NightToggle(),
          HomeToggle(),
          SensorToggle(),
        ],
      );

  Widget buildSliderRow() {
    double height = 150;
    double width = 110;
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LightSlider(
            "hallway",
            "Hallway",
            icon: Icons.lightbulb,
            height: height,
            width: width,
          ),
          LightSlider(
            "living room",
            "Livingroom",
            icon: Icons.lightbulb,
            height: height,
            width: width,
          )
        ],
      );
    });
  }
}

Stone spaceStone(int id, int width, int height) {
  return Stone(
    id: id,
    child: Container(),
    width: width,
    height: height,
  );
}
