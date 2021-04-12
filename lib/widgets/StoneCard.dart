import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../globals.dart';

class StoneCard extends StatelessWidget {
  final Widget child;
  StoneCard(this.child);

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return Container(
      margin: stoneMargin,
        child: Neumorphic(
          style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              lightSource: theme.lightSource,
              color: backgroundColor,
              shadowDarkColor: theme.shadowDarkColor,
              shadowLightColor: theme.shadowLightColor,
              depth: theme.depth,
              intensity: theme.intensity
          ),
          child: Container(clipBehavior: Clip.hardEdge, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)), child: child),
          margin: EdgeInsets.all(0),
        )
    );
  }
}