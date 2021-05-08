import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/utils/ColorUtils.dart';
import 'package:mqttdashboard/views/TvRemote.dart';
import 'package:mqttdashboard/widgets/StatsScreen.dart';

import '../globals.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        separator(context),
        Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildIconButton(Icons.tv, () => _openTvView(context)),
                buildIconButton(Icons.bar_chart, () => _openStatsView(context))
              ],
            ))
      ],
    );
  }

  Widget separator(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 2,
          color: darken(backgroundColor, 10),
        ),
        Container(
          height: 2,
          color: brighten(backgroundColor, 10),
        ),
      ],
    );
  }

  void _openTvView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => TvRemote()));
  }

  void _openStatsView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => StatsScreen()));
  }

  Widget buildIconButton(IconData icon, Function action) {
    return NeumorphicButton(
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: action,
    );
  }
}
