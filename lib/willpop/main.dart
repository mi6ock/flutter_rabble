// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          bool isDrawerOpen = _key.currentState.isDrawerOpen;
          if (isDrawerOpen) {
            Navigator.pop(context);
            return Future.value(false); // 画面遷移をさせない
          } else {
            return Future.value(true); // 画面遷移を許可
          }
        },
        child: Scaffold(
            key: _key,
            drawerEdgeDragWidth: 0, //　ボタンのみでドロワーを開ける様にする(スワイプでドロワーを開けるエリアを0にする）
            drawer: Drawer(
                child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                  DrawerHeader(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Drawer Header'),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            )
                          ]),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ))
                ])),
            appBar: AppBar(
              automaticallyImplyLeading: false, // デフォルトで設置されるメニューボタンを表示させない
            ),
            body: Center(
                child: RaisedButton(
              child: Text('open'),
              onPressed: () => _key.currentState.openDrawer(),
            ))));
  }
}
