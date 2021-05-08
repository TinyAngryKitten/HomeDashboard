import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';

import '../mqtt.dart';

class StoneToggle extends StatefulWidget {
  final Widget onChild;
  final Widget offChild;
  final String topic;

  const StoneToggle({Key key, this.onChild, this.offChild, this.topic}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StoneToggleState();
}

class StoneToggleState extends State<StoneToggle> with SingleTickerProviderStateMixin {
  bool state = false;
  AnimationController _controller;
  Animation<double> curve;
  Path path;

  StoneToggleState() {
    _controller = AnimationController(value: 0, duration: Duration(milliseconds: 500), vsync: this);
    curve = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    path = Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: 30));

    /*subscribe(widget.topic,(result) {

    });*/
  }

  @override
  void dispose() {
    super.dispose();
    unsubscribe(widget.topic);
  }

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
        depth: theme.depth,
        intensity: theme.intensity
      ),
      onPressed: toggle,
      child: Container(
        padding: EdgeInsets.all(10),
        child: state ? widget.onChild : widget.offChild,
      )
    );
  }

  void toggle() {
    setState(() {
      state = !state;
      publish(widget.topic,state.toString());
    });
  }

}