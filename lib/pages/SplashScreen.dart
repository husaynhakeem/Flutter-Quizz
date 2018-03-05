import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () => print("Tapped on screen"),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Let's Quizz", style: new TextStyle(color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold)),
            new Text("Tap to start", style: new TextStyle(color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}