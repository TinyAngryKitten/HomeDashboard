import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoneCard extends StatelessWidget {
  final Widget child;
  StoneCard(this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(0),child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      child: child,
      margin: EdgeInsets.all(0),

    ));
  }
}