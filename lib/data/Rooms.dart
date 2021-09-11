import 'package:mqttdashboard/data/Room.dart';

import '../ButtonCollection.dart';
import 'SliderItem.dart';

var livingroomName = "living room";
var bedroomName = "bedroom";

var rooms = {
  livingroomName: Room(
  "living room",
    [
      NightButton(),
      HomeButton(),
      ACButton(),
    ],
    [
      NightToggle(),
      HomeToggle(),
      SensorToggle(),
    ],
  [
    SliderItem("living room", "Living room"),
    SliderItem("hallway", "Hallway"),
  ],
    "homey/airthings-wave-mini-stue"
),

  bedroomName: Room(
      "bedroom",
      [
        NightButton(),
        HomeButton(),
      ],
      [
        SensorToggle("bedroom"),
        NightToggle(),
      ],
      [
        SliderItem("bedroom", "Bedroom"),
      ],
      "homey/airthings-wave-mini-stue"
  )
};