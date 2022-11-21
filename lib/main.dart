import 'package:flutter/material.dart';

// fa22_drawers

/*
https://pub.dev/packages/http
https://pub.dev/packages/


pubsec.yaml

dependencies:
flutter:
  sdk: flutter

http: ^0.13.5
*/



import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static var data;

  static Future getData() async {

    var url = Uri.parse("https://flutter.locusnoesis.com/carinfo.php");

    //http.Response response = await http.get(url);
    http.Response response = await http.post(url);
    data = await jsonDecode(response.body);

    return data;

  }


  Widget myWidget = FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
        if(snapshot.hasData)
        {
          return Scrollbar(
              interactive: true,
              thickness: 10,
              thumbVisibility: true,
              child:
              ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index){
                    return
                      Card(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                    title: Text(data[index]['year'].toString() +
                                        " " + data[index]['make']),
                                    subtitle: Text(data[index]['body_styles'])
                                )
                              ]
                          )
                      );
                  }
              )
          );
        }
        return const Text("Waiting For Data");
      }
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Autos Json API"),
            backgroundColor: Colors.indigo),
        body: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: const Text("Cars For Sale")
              ),
              Expanded(child:  myWidget)
            ]
        )
    );}
}






