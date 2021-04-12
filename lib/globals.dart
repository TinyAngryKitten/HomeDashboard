import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mobx/mobx.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

double sliderHeight = 100;
double sliderWidth = 100;

const TextStyle h1 = TextStyle(fontSize: 32, color: Colors.white);
const TextStyle h2 = TextStyle(fontSize: 24, color: Colors.white);
const TextStyle h3 = TextStyle(fontSize: 18, color: Colors.white);
const TextStyle p = TextStyle(fontSize: 14, color: Colors.white);

const EdgeInsets stoneMargin = EdgeInsets.all(6);

final neuTheme = NeumorphicThemeData(
    depth: 10,
    boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
    shadowDarkColor: shadowColor,
    shadowLightColor: softShadowColor,
    intensity: 0.7,
    defaultTextColor: highlightColor,
    baseColor: backgroundColor,
    accentColor: gradientStart,
    variantColor: gradientStart,
);

final backgroundColor = Color(0xFF2c3135);
final highlightColor = Colors.white.withOpacity(0.05);
final shadowColor = Colors.black87;

final softHighlightColor = highlightColor.withOpacity(0.03);
final softShadowColor = shadowColor.withOpacity(0.3);

const gradientEnd = Color(0xFF2196F3);
const gradientStart = Color(0xFF00BCD4);
//final gradientStart = Color(0xFFf1da95);
//final gradientMiddle = Color(0xFFfe948a);
//final gradientEnd = Color(0xFFb24fce);

final lightBackgroundColor = Color.fromRGBO(73,79,93, 1);
final primaryColor = Colors.white;

final MqttClient mqttClient = MqttServerClient.withPort("192.168.50.3", "Dashboard",1883);

final isConnected = Observable(false);

final defaultTheme = ThemeData(
    appBarTheme: AppBarTheme(color: primaryColor),
    buttonTheme: ButtonThemeData(buttonColor: primaryColor, disabledColor: lightBackgroundColor),
    bottomAppBarColor: primaryColor,
    bottomAppBarTheme: BottomAppBarTheme(color: primaryColor),
    scaffoldBackgroundColor: backgroundColor
);