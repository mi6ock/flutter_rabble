import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/timestamp.dart';

class Gu {
  String text;
  DateTime start;

  Map<String, dynamic> toJson() {
    return {'gu': text, 'start': start};
  }
}
class JamPan {
  int id;
  String text;
  List<Gu> gu;
  DateTime dateTime;

  JamPan(this.id, this.text, this.gu, {this.dateTime});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'dateTime': dateTime,
      'gu': gu.map((e) {
        print(e.runtimeType);
        return e.toJson();
      }).toList(),
    };
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OB Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DataSerializationWidget(),
    );
  }
}

class DataSerializationWidget extends StatefulWidget {
  @override
  _DataSerializationWidgetState createState() =>
      _DataSerializationWidgetState();
}

class _DataSerializationWidgetState extends State<DataSerializationWidget> {
  Database db;
  List<Map> title;
  StoreRef store;
  String rawText = "";

  Future<void> loadDB() async {
    Directory rootPath = await getApplicationDocumentsDirectory();
    String dbPath = '${rootPath.path}/sample.db';
    DatabaseFactory dbFactory = databaseFactoryIo;

    db = await dbFactory.openDatabase(dbPath);
    store = intMapStoreFactory.store('animals');

//    store = StoreRef<String, String>.main();
  }

  Future<void> save(String text) async {
    if (db != null) {
      var moel = JamPan(
          1,
          text,
          [
            Gu()
              ..text = text
              ..start = DateTime.now()
          ],
          dateTime: DateTime.now());
      final output = _dateTimeToTimestamp(moel.toJson());
      print(output);
      await store.add(db, output);
      setState(() {});
    }
  }

  Map<String, dynamic> _dateTimeToTimestamp(Map<String, dynamic> json) {
    final output = <String, dynamic>{};
    json.forEach((key, value) {
      if (value.runtimeType == DateTime) {
        output[key] = Timestamp.fromDateTime(value);
      } else if (TypeMatcher<List<Map<String, dynamic>>>().check(value)) {
        output[key] = value.map((e) => _dateTimeToTimestamp(e)).toList();
      } else {
        output[key] = value;
      }
    });
    return output;
  }

  Map<String, dynamic> _timestampToDateTime(Map<String, dynamic> json) {
    final output = <String, dynamic>{};
    Map<String, dynamic>.from(json).forEach((key, value) {
      print(
          "$key $value ${value.runtimeType} ${TypeMatcher<List<dynamic>>().check(value)}");
      if (value.runtimeType == Timestamp) {
        output[key] = value.toDateTime();
      } else if (TypeMatcher<List<dynamic>>().check(value)) {
        output[key] = value.map((e) => _timestampToDateTime(e)).toList();
      } else {
        output[key] = value;
      }
    });
    return output;
  }

  Future<void> load() async {
//    var finder = Finder(
//        filter: Filter.notNull('id'), sortOrders: [SortOrder("text", false)]);
    var finder = Finder();
    List<RecordSnapshot> title = await store.find(
//    RecordSnapshot title = await store.findFirst(
      db,
      finder: finder,
    );

    var val = title.map((e) => _timestampToDateTime(e.value));

    final jampam  = JamPan.from
    print(val);
    setState(() {});
  }

  @override
  void initState() {
    loadDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: (String) {
              rawText = String;
            },
          ),
          FlatButton(
            color: Colors.blueGrey,
            child: Text(
              "save",
              style: Theme.of(context).textTheme.headline6,
            ),
            onPressed: () => save(rawText),
          ),
          const SizedBox(height: 48),
          Text(
            "",
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 32,
          ),
          FlatButton(
            color: Colors.blueGrey,
            child: Text(
              "load",
              style: Theme.of(context).textTheme.headline6,
            ),
            onPressed: () => load(),
          ),
        ],
      ),
    );
  }
}
