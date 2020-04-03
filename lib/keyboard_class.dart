import 'package:flutter/material.dart';
import 'package:learning_disability_app/main_drawer.dart';
import 'package:provider/provider.dart';
import 'action_data.dart';
import 'package:flutter_tts/flutter_tts.dart';

void textToSpeech(String data, FlutterTts flutterTts) async {
  if (data.isNotEmpty && data != null) {
    var result = await flutterTts.speak(data);
  }
}

class QuickAction extends StatelessWidget {
  QuickAction({this.word});

  final String word;
  @override
  FlutterTts flutterTts = FlutterTts();

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        textToSpeech(word, flutterTts);
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
        height: 50,
        child: Center(
          child: Text(word),
        ),
      ),
    );
  }
}

class KeyboardScreen extends StatefulWidget {
  @override
  _KeyboardScreen createState() => _KeyboardScreen();
}

class _KeyboardScreen extends State<KeyboardScreen> {
  TextEditingController keyboardController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();

  String typedWords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Keyboard"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * (1 / 3),
              child: GridView(
                padding: const EdgeInsets.all(25),
                children: <Widget>[
                  for (var word in Provider.of<AppData>(context).quickWords)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: QuickAction(
                        word: word,
                      ),
                    ),
                ],
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 10 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontSize: 30),
                controller: keyboardController,
                decoration: InputDecoration(
                  labelText: "Write Text Here!",
                ),
                onChanged: (value) {
                  typedWords = value;
//                Future.delayed(const Duration(milliseconds: 1000), () {
//                  flutterTts.stop();
//                  textToSpeech(value, flutterTts);
//                });
                },
                onTap: () {},
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                // ignore: missing_return
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * (1 / 2.2),
                      height: 50,
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              keyboardController.text = " ";
                              typedWords = " ";
                            });
                          },
                          color: Colors.red,
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * (1 / 2.2),
                      height: 50,
                      child: RaisedButton(
                          onPressed: () {
                            textToSpeech(typedWords, flutterTts);
                          },
                          color: Colors.green,
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
