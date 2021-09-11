import 'package:flutter/material.dart';

import 'SliderItem.dart';

class Room {
  List<Widget> stateItems;
  List<Widget> actionItems;
  List<SliderItem> sliderItems;

  String name;
  String airQualityTopic;

  Room(this.name,  this.stateItems,this.actionItems,this.sliderItems, this.airQualityTopic);
}