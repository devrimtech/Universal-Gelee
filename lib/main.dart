import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getJson() async {
  return await rootBundle.loadString('data/data.json');
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String? _mySelection = "Atmosphere";
  Future<String> getJson() {
    return rootBundle.loadString('data.json');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: FutureBuilder<String>(
            future: getJson(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error?.toString() ?? ''));
              }
              final Map<String, dynamic> _data = jsonDecode(snapshot.data!);
              return DropdownButton<String>(
                isDense: true,
                hint: Text("Select"),
                value: _mySelection,
                onChanged: (String? newValue) {
                  setState(() {
                    _mySelection = newValue;
                  });

                  print(_mySelection);
                },
                items: _data["payloads"]
                    .map((key, map) {
                      return MapEntry(
                        key,
                        DropdownMenuItem<String>(
                          value: map["link"].toString(),
                          child: new Text(
                            map["name"],
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
              );
            }),
      ),
    );
  }
}
