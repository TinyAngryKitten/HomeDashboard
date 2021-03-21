import 'package:mqtt_client/mqtt_client.dart';

import 'globals.dart';

var flowsTopic="homey/flows/";

void subscribe(String topic, Function f) {
  if(mqttClient.connectionStatus.state == MqttConnectionState.connected) mqttClient.subscribe(topic, MqttQos.exactlyOnce);
  else mqttClient.onConnected = () =>  mqttClient.subscribe(topic, MqttQos.exactlyOnce);
  mqttClient.updates.listen(
          (List<MqttReceivedMessage<MqttMessage>> c) =>
              f(MqttPublishPayload.bytesToStringAsString((c[0].payload as MqttPublishMessage).payload.message))
      );
}

void publish(String topic, String message) async {
  if(mqttClient.connectionStatus.state != MqttConnectionState.connected && mqttClient.connectionStatus.state != MqttConnectionState.connecting) 
    await mqttClient.connect();

  var msgBuilder = MqttClientPayloadBuilder()..addString(message);
  mqttClient.publishMessage(topic, MqttQos.exactlyOnce, msgBuilder.payload);
}