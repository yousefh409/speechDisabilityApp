import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';

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

void textToSpeech(Button data, FlutterTts flutterTts) async {
  if (data.title.isNotEmpty && data.title != null) {
    var result = await flutterTts.speak(data.title);
  }
}
class ButtonIcon extends StatelessWidget {

  ButtonIcon({this.buttonData});
  final Button buttonData;

  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        textToSpeech(this.buttonData, flutterTts);
      },
      onLongPress: () {},
      child: Container(
        width: 100,
        height: 200,
        child: Column(
          children: <Widget>[
            Image.asset(buttonData.imagePath, width: 100, height: 150,),
            Center(
              child: Text(buttonData.title),
            ),
          ],
        ),
      ),
    );
  }
}
