import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';

class StoneToggle extends StatefulWidget {
  final Widget child;

  const StoneToggle({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StoneToggleState();
}

class StoneToggleState extends State<StoneToggle> {
  bool state = false;
  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        lightSource: theme.lightSource,
        color: backgroundColor,
        shadowDarkColor: theme.shadowDarkColor,
        shadowLightColor:theme.shadowLightColor,
        shadowDarkColorEmboss: theme.shadowDarkColor,
        shadowLightColorEmboss: theme.shadowLightColor,
        depth: state ? theme.depth : -theme.depth,
        intensity: theme.intensity
      ),
      onPressed: toggle,
      child: Container(
        padding: EdgeInsets.all(10),
          child: widget.child
      ),
    );
  }

  void toggle() {
    setState(() {
      state = !state;
    });
  }

}