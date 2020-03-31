import 'package:flutter/material.dart';
import 'package:learning_disability_app/button_class.dart';
import 'package:learning_disability_app/category_class.dart';
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
          "/category_items_screen": (ctx) => CategoryScreen(),
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
