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
    return Container(
      margin: EdgeInsets.all(20),
        child: Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              depth: 20,
              color: backgroundColor,
              shadowLightColor: softShadowColor,
              surfaceIntensity: 0.1,
              intensity: 1,
          ),
          child: Container(clipBehavior: Clip.hardEdge, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)), child: child),
          margin: EdgeInsets.all(0),
        )
    );
  }
}