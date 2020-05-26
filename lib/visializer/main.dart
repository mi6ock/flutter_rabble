import 'dart:math';

import 'package:flutter/material.dart';
import 'package:samples_rabble/visializer/visializer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> jampam;

  @override
  void initState() {
    jampam = [
      for (double i = 0; i < 0.1; i += 0.1) (sin(i * pi) * 50).toInt().abs()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(' Example'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: 250,
        child: TweenAnimationBuilder<double>(
          builder: (context, _, child) {
            jampam.add((sin(pi * _) * 50).toInt().abs());
            if (jampam.length > 40) jampam.removeAt(0);
            return CustomPaint(
              painter: SoundVisualizer(
                tooLoudVolume: 40,
                tooSoftVolume: 8,
                normalColor: Colors.blue,
                waveData: jampam,
                maxValue: 50,
              ),
            );
          },
          tween: Tween(begin: 1, end: 10),
          duration: Duration(seconds: 10),
        ),
      ),
    );
  }
}
