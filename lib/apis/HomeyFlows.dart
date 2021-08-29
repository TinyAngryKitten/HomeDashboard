import '../mqtt.dart';

enum Flow {
  GodNatt,
  Home,
  ToggleNight,
  ToggleMovement,
  ToggleHome,
}

class HomeyFlows {
  static String topic = "homey/flows/run";
  static void triggerFlow(Flow flow) {
    publish(topic,flow.toString());
  }
}