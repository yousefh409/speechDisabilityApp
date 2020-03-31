import 'package:flutter/material.dart';
import 'action_data.dart';
import 'button_class.dart';
import 'category_class.dart';

class CategoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, Category>;
    final Category category = routeArgs["category"];

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          for (var action in category.members)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonIcon(
                buttonData: action,
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
