import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Blumax',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'RobotoMono',
              fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/blumax.jpg"), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
