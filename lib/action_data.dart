import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'button_class.dart';
import 'category_class.dart';

//bool isUserAdded = false;

class AppData extends ChangeNotifier {
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userSetActions = json.decode(
      prefs.get("actionData"),
    );
    print(userSetActions);
    print(categoryData);
    if (userSetActions == null) {
      return;
    } else {
      categoryData.removeRange(0, (categoryData.length));
      categoryData.insertAll(0, defaultCategoryData);
      categoryData.insert(
          0,
          Category(
              title: "User-Added",
              imagePath: "assets/images/user.jpeg",
              isCreatedByUser: true,
              id: "user-added",
              members: []));
//      isUserAdded = true;

      for (int action in userSetActions["actions"]) {
        categoryData[0].members.add(Button(
            title: "${userSetActions["$action"]["title"]}",
            imagePath: "${userSetActions["$action"]["imagePath"]}",
            isCreatedByUser: true,
            id: "${DateTime.now().toString()}"));
      }
    }
    print(categoryData);
    notifyListeners();
  }

  List<String> quickWords = [
    "Hi",
    "How are you doing?",
    "What time is it?",
    "It is over there",
    "Do you know the way?",
    "Will you be there?"
  ];
  List<Category> categoryData = [
    Category(
        title: "People",
        imagePath: "assets/images/person.jpg",
        isCreatedByUser: false,
        id: "people",
        members: [
          Button(
              title: "Boy",
              id: "boy",
              isCreatedByUser: false,
              imagePath: "assets/images/boy.jpg"),
        ]),
    Category(
        title: "Places",
        imagePath: "assets/images/home.png",
        isCreatedByUser: false,
        id: "places",
        members: [
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
        ])
  ];

  final List<Category> defaultCategoryData = [
    Category(
        title: "People",
        imagePath: "assets/images/person.jpg",
        isCreatedByUser: false,
        id: "people",
        members: [
          Button(
              title: "Boy",
              id: "boy",
              isCreatedByUser: false,
              imagePath: "assets/images/boy.jpg"),
        ]),
    Category(
        title: "Places",
        imagePath: "assets/images/home.png",
        isCreatedByUser: false,
        id: "places",
        members: [
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
          Button(
              title: "School",
              id: "school",
              isCreatedByUser: false,
              imagePath: "assets/images/school.png"),
        ])
  ];
}
