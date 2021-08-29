import 'package:mqttdashboard/data/Room.dart';

import '../ButtonCollection.dart';
import 'SliderItem.dart';

var livingroom = "living room";

var rooms = {
   livingroom: Room(
  "living room",
    [
      NightButton(),
      HomeButton(),
    ],
    [
      NightToggle(),
      HomeToggle(),
      SensorToggle(),
    ],
  [
    SliderItem("living room", "Living room"),
    SliderItem("hallway", "Hallway"),
  ]
)};