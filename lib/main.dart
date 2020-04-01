import 'package:flutter/material.dart';
import 'package:learning_disability_app/button_class.dart';
import 'package:learning_disability_app/category_class.dart';
import 'package:learning_disability_app/keyboard_class.dart';
import 'package:learning_disability_app/main_drawer.dart';
import 'action_data.dart';
import 'category_screen.dart';

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
        routes: {
          "/home_screen": (ctx) => MyHomePage(),
          "/category_items_screen": (ctx) => CategoryScreen(),
          "/keyboard_screen": (ctx) => KeyboardScreen(),
        });
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
      drawer: MainDrawer(),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          for (var action in categoryData)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryIcon(
                categoryData: action,
              ),
            ),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
