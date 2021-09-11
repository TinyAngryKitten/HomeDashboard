import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';

import '../main.dart';
import '../mqtt.dart';

class TvRemote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp(Center(
        child: Container(
            margin: EdgeInsets.all(30),
            child: Column(children: [
              Row(children: [
                exitButton(Icons.close, context),
                Expanded(child: Container())
              ]),
              Expanded(child: buildTouchPad()),
              Container(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildPowerRow(context),
                    buildVolumeColumn(context),
                    buildIconButton(Icons.check_circle_outline, appleTvTopic, "Select", context),
              ]),
              Container(height: 40),
              buildInputRow(context)
            ]))));
  }

  Widget buildPowerRow(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildIconButton(Icons.tv, tvTopic, "PowerToggle", context),
          Container(width: 20,),
          buildIconButton(
              BrandIcons.apple, appleTvTopic, "Menu", context),
        ]);
  }

  Widget buildInputRow(BuildContext context) {
    return IntrinsicWidth(child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTextButton("Apple TV", tvTopic, "InputHdmi3", context, BrandIcons.apple),
          Container(height: 20,),
          buildTextButton("Playstation", tvTopic, "InputHdmi1", context, BrandIcons.playstation),
          Container(height: 20,),
          buildTextButton("Switch", tvTopic, "InputHdmi2", context, BrandIcons.nintendoswitch),
        ]));
  }

  Widget buildIconButton(
      IconData icon, String topic, String message, BuildContext context, {size = 35.0}) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return NeumorphicButton(
        onPressed: () => publish(topic, message),
        style: NeumorphicStyle(
            lightSource: theme.lightSource,
            shadowLightColor: theme.shadowLightColor,
            shadowDarkColor: theme.shadowDarkColor,
            intensity: theme.intensity,
            color: backgroundColor,
            boxShape: NeumorphicBoxShape.circle()),
        child: Container(
          padding: EdgeInsets.all(size/3),
          child: Icon(
            icon,
            color: Colors.white,
            size: size,
          ),
        ));
  }

  Widget buildTextButton(
      String text, String topic, String message, BuildContext context, [IconData icon]) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return NeumorphicButton(
      onPressed: () => publish(topic, message),
      style: NeumorphicStyle(
        lightSource: theme.lightSource,
        shadowLightColor: theme.shadowLightColor,
        shadowDarkColor: theme.shadowDarkColor,
        intensity: theme.intensity,
        color: backgroundColor,
      ),
      child: Row(
          children: [
        icon != null ? Container(child: Icon(icon, color: Colors.white,), padding: EdgeInsets.only(right: 10),) : Container(),
        Text(text, style: h3, textAlign: TextAlign.left,),
      ])
    );
  }

  Widget buildTouchPad() {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: lightBackgroundColor, borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTapDown: (details) => _sendOK,
        onTap: () => _sendOK,
        onHorizontalDragEnd: _onSwipeHorizontal,
        onVerticalDragEnd: _onSwipeVertical,
      ),
    );
  }

  Widget exitButton(IconData icon, BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget buildVolumeColumn(BuildContext context) {
    return Column(
      children: [
        buildIconButton(Icons.add, tvTopic, "VolumeUp", context, size: 20.0),
        Container(height: 15,),
        buildIconButton(Icons.remove, tvTopic, "VolumeDown", context, size: 20.0)
      ],
    );
  }
}

String appleTvTopic = "harmony/livingroom/Apple TV";
String tvTopic = "harmony/livingroom/LG TV";

void _sendOK() => publish(appleTvTopic, "Select");

void _onSwipeHorizontal(DragEndDetails details) => publish(appleTvTopic,
    details.primaryVelocity > 0 ? "DirectionRight" : "DirectionLeft");
void _onSwipeVertical(DragEndDetails details) => publish(appleTvTopic,
    details.primaryVelocity > 0 ? "DirectionDown" : "DirectionUp");
