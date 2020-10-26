import 'ButtonAnimation.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Split Widgets Example"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return new Text('Not implemented yet');
  }
}

class AvatarGlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: Duration(milliseconds: 1000),
      glowColor: Colors.white,
      endRadius: 160.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 100),
      child: MaterialButton(
        onPressed: () {
          print("GO");
        },
        elevation: 20.0,
        shape: CircleBorder(),
        child: Container(
          width: 200.0,
          height: 200.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(160.0)),
          child: Text(
            "GO",
            style: TextStyle(
                fontSize: 75.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF7557D6)),
          ),
        ),
      ),
    );
  }
}
