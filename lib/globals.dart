import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

const TextStyle h1 = TextStyle(fontSize: 32);
const TextStyle h2 = TextStyle(fontSize: 24);
const TextStyle h3 = TextStyle(fontSize: 18);
const TextStyle p = TextStyle(fontSize: 14);

final neuTheme = NeumorphicThemeData(
    depth: 15,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    shadowDarkColor: shadowColor,
    shadowLightColor: softShadowColor,
    intensity: 1.0,
    defaultTextColor: highlightColor,
    baseColor: backgroundColor,
);

final backgroundColor = Color(0xFF2c3135);
final highlightColor = Colors.white.withOpacity(0.05);
final shadowColor = Colors.black87;

final softHighlightColor = highlightColor.withOpacity(0.03);
final softShadowColor = shadowColor.withOpacity(0.3);

final gradientStart = Color(0xFFf1da95);
final gradientMiddle = Color(0xFFfe948a);
final gradientEnd = Color(0xFFb24fce);

//final backgroundColor = Color.fromRGBO(36,46,66,1,);
final lightBackgroundColor = Color.fromRGBO(73,79,93, 1);
final primaryColor = Colors.white;

final MqttBrowserClient mqttClient = MqttBrowserClient.withPort("ws://192.168.50.3", "Dashboard",9001);

bool isConnected = false;

final defaultTheme = ThemeData(
    appBarTheme: AppBarTheme(color: primaryColor),
    buttonTheme: ButtonThemeData(buttonColor: primaryColor, disabledColor: lightBackgroundColor),
    bottomAppBarColor: primaryColor,
    bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
    scaffoldBackgroundColor: backgroundColor
);