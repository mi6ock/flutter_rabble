import 'package:flutter/material.dart';
import 'package:{yourpackage}/multidrop_down_menu/multiselect_formfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelect Formfield Example'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: MultiSelectFormField(
                    autovalidate: false,
                    dataSource: [
                      {
                        "display": "M",
                        "value": "Running",
                      },
                      {
                        "display": "L",
                        "value": "Climbing",
                      },
                      {
                        "display": "チーズ2kg",
                        "value": "sdf",
                      },
                      {
                        "display": "チーズ2kg",
                        "value": "dfe",
                      },
                      {
                        "display": "チーズ2kg",
                        "value": "we34",
                      },
                      {
                        "display": "チーズ2kg",
                        "value": "cddf",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    titleText: "サイズ",
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintText: '選択してください',
                    value: _myActivities,
                    close: () {
                      print(_myActivities);
                    },
                    onSaved: (value) {
                      if (value == null) return;
                      print(value);
                      setState(() {
                        _myActivities = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
