import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samples_rabble/wave_reader/wave_reader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String rootPath;

  Future<void> _init() async {
    rootPath = "${(await getApplicationDocumentsDirectory()).path}";
    final fff = File("$rootPath/test.md");
    if (!fff.existsSync()) {
      fff.createSync();
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("wave reader"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => joinFilesWithEmpty(
                  files: [
                    File("${rootPath}/test.wav"),
                    File("${rootPath}/test.wav"),
                    File("${rootPath}/test.wav"),
                  ],
                  output: File(
                    "${rootPath}/test2.wav",
                  )),
            )
          ],
        ),
      ),
    );
  }
}
