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

//Converts the text that is passed to it to speech
void textToSpeech(Button data, FlutterTts flutterTts) async {
  if (data.title.isNotEmpty && data.title != null) {
    var result = await flutterTts.speak(data.title);
  }
}

class ButtonIcon extends StatelessWidget {

  //Gets the info about the button to use in this screen
  ButtonIcon({this.buttonData});
  final Button buttonData;

  //An instance of FlutterTts that will be used to convert text to speech
  FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        textToSpeech(this.buttonData, flutterTts);
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
                buttonData.imagePath,
//              width: 100,
//              height: 150,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(buttonData.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
