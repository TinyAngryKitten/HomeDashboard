import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_wall_layout/flutter_wall_layout.dart';
import 'package:mqttdashboard/ButtonCollection.dart';
import 'package:mqttdashboard/widgets/AirQualityStats.dart';
import 'package:mqttdashboard/widgets/LightSlider.dart';
import 'package:mqttdashboard/widgets/NavBar.dart';

import 'PhoneAppBar.dart';
import 'data/Room.dart';
import 'data/Rooms.dart';
import 'globals.dart';
import 'main.dart';

class VerticalApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VerticalAppState();
  }
}

class VerticalAppState extends State<VerticalApp> {
  Room room = rooms[livingroomName];

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(room.name),
                      PhoneAppBar(room, (Room r){
                        setState(() {
                          room = r;
                        });
                      }),

                      AirQualityStats(room.airQualityTopic),
                      buildSpacer(),
                      buildSliderRow(),

                      buildSpacer(),
                      buildActionRow(),
                      buildSpacer(),
                      buildStateRow(),
                      //LightSlider("hallway", "Hallway", icon: Icons.lightbulb),
                    ]),
              ))),
    );
  }

  Widget buildSpacer() => Container(
    height: 30,
  );

  Widget buildActionRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: room.actionItems,
  );

  Widget buildStateRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: room.stateItems,
  );

  Widget buildSliderRow() {
    double height = 150;
    double width = 110;
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: room.sliderItems.map((slider) =>
          LightSlider(
            slider.name,
            slider.displayName,
            icon: Icons.lightbulb,
            height: height,
            width: width,
          ),
        ).toList()
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
