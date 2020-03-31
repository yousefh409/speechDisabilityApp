import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Button {
  final String title;
  final bool isCreatedByUser;
  final String id;
  final String imagePath;

  const Button({
    @required this.title,
    @required this.id,
    @required this.isCreatedByUser,
    @required this.imagePath,
  });
}

class ButtonIcon extends StatelessWidget {
  ButtonIcon({this.buttonData});

  final Button buttonData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Column(
        children: <Widget>[
          Image.asset(buttonData.imagePath),
          Center(
            child: Text(buttonData.title),
          ),
        ],
      ),
    );
  }
}
