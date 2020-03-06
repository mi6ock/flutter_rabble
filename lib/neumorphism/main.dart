import 'package:flutter/material.dart';

void main() async {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        centerTitle: false,
        leading: Icon(
          Icons.mood,
          size: 30,
          color: Colors.grey,
        ),
        title: Text(
          'MIMOSYS',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 40, color: Colors.grey),
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android, size: 80, color: Colors.grey),
//              Text(
//                'MIMOSYS!',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 60,
//                    shadows: [
//                      Shadow(
//                        offset: Offset(3, 3),
//                        color: Colors.grey[500],
//                        blurRadius: 10,
//                      ),
//                      Shadow(
//                        offset: Offset(-3, -3),
//                        color: Colors.white,
//                        blurRadius: 10,
//                      )
//                    ],
//                    color: Colors.grey.shade300),
//              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0),
              ]),
        ),
      ),
    );
  }
}
