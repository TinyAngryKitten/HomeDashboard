import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/views/TvRemote.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildIconButton(Icons.tv, ()=>_openTvView(context))
      ],
    );
  }

  void _openTvView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => TvRemote()));
  }

  Widget buildIconButton(IconData icon, Function action) {
    return NeumorphicButton(
      child: Icon(icon, color: Colors.white,),
      onPressed: action,
    );
  }

}