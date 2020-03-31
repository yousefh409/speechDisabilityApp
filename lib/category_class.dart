import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button_class.dart';

class Category {
  final String title;
  final String id;
  final String imagePath;
  final bool isCreatedByUser;
  final List<Button> members;

  const Category({
    @required this.title,
    @required this.id,
    @required this.imagePath,
    @required this.isCreatedByUser,
    @required this.members,
  });
}

void pushCategoryScreen(BuildContext context, Category category) {
  Navigator.of(context)
      .pushNamed("/category_items_screen", arguments: {"category": category});
}

class CategoryIcon extends StatelessWidget {
  CategoryIcon({this.categoryData});

  final Category categoryData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushCategoryScreen(context, categoryData);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
            top: BorderSide(color: Colors.grey, width: 1),
            right: BorderSide(color: Colors.grey, width: 1),
            left: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        width: 100,
        height: 200,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                categoryData.imagePath,
//              width: 100,
//              height: 150,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(categoryData.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
