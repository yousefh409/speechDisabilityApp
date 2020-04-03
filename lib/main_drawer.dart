import 'package:flutter/material.dart';
import 'keyboard_class.dart';
import 'category_class.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            height: 120,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).accentColor,
            ),
            padding: EdgeInsets.all(30),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                'Placeholder',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Soundboard', Icons.speaker, () {
            Navigator.of(context).pushNamed("/home_screen");
          }),
          buildListTile('Keyboard', Icons.keyboard, () {
            Navigator.of(context).pushNamed("/keyboard_screen");
          }),
          buildListTile('Account Info', Icons.account_circle, () {
            Navigator.of(context).pushNamed("/account_screen_signed_out");
          }),
          buildListTile('Add Action', Icons.add, () {
            Navigator.of(context).pushNamed("/add_action_screen");
          }),
        ],
      ),
    );
  }
}