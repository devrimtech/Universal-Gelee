import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

var httpClient = new HttpClient();
Future<File> _downloadFile(String? url) async {
  var request = await httpClient.getUrl(Uri.parse(url!));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = new File('$dir/payload.bin');
  await file.writeAsBytes(bytes);
  return file;
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
  String? _mySelection = "https://misc.ktemkin.com/fusee.bin";
  Future<String> getJson() => rootBundle.loadString('data/data.json');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<String>(
            future: getJson(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error?.toString() ?? ''));
              }
              final List _data = jsonDecode(snapshot.data!)["payloads"];
              return DropdownButton(
                isDense: true,
                hint: Text("Select"),
                value: _mySelection,
                onChanged: (String? newValue) {
                  print(newValue);
                  _downloadFile(newValue);
                  setState(() {
                    _mySelection = newValue;
                  });

                  print(_mySelection);
                },
                items: _data.map((map) {
                  print(map["link"]);
                  return DropdownMenuItem<String>(
                    value: map["link"],
                    child: Text(
                      map["name"],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
