import 'package:flutter/material.dart';
import 'package:learning_disability_app/button_class.dart';
import 'action_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disability App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            direction: Axis.horizontal,
            spacing: 10.0,
            children: <Widget>[
              for (var action in actionData) Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonIcon(buttonData: action,),
              ),
            ],
          )
        ],
      ),
    );
  }
}
