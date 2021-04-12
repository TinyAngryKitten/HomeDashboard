import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'globals.dart';

var flowsTopic="homey/flows/";

var reactionMap = Map<String,ReactionDisposer>();

void subscribe(String topic, Function f) {
  if(isConnected.value) {
    mqttClient.subscribe(topic, MqttQos.exactlyOnce);
    _listenForEvents(topic, f);
  } else {
    reactionMap[topic]?.call();//dispose last reaction
    reactionMap.remove(topic);
    reactionMap.putIfAbsent(topic,  () => when((_) => isConnected.value, () {
      mqttClient.subscribe(topic, MqttQos.exactlyOnce);
      _listenForEvents(topic,f);
    }));
  }

}

void _listenForEvents(String topic, Function f) {
  mqttClient.updates.listen(
          (List<MqttReceivedMessage<MqttMessage>> c)
          {
            if(c[0].topic == topic)
              f(
                MqttPublishPayload
                    .bytesToStringAsString(
                      (c[0].payload as MqttPublishMessage)
                          .payload.message
                )
            );
          }
  );
}

void publish(String topic, String message) async {
  when((_) => isConnected.value, () {
    var msgBuilder = MqttClientPayloadBuilder()
      ..addString(message);
    mqttClient.publishMessage(topic, MqttQos.exactlyOnce, msgBuilder.payload);
  });
}