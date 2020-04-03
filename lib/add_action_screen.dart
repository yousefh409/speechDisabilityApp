import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_disability_app/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddAction extends StatefulWidget {
  @override
  _AddActionState createState() => _AddActionState();
}

class _AddActionState extends State<AddAction> {
  TextEditingController titleController;
  bool validateTitle = false;
  String title;

  bool isImageTaken = false;
  String imagePath;

  void takeImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    final String localPath = DateTime.now().toString();
    final String documentPath = (await getApplicationDocumentsDirectory()).path;
    final File localImage = await image.copy("$documentPath/$localPath");
    setState(() {
      imagePath = localImage.path;
      isImageTaken = true;
    });
  }

  void saveAction(BuildContext context) async {
    if (titleController.text.isEmpty) {
      validateTitle = true;
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var previousData = prefs.get('actionData');
    var dataToUpload;
    int toAdd = 1;
    if (previousData == null) {
      dataToUpload = {
        "actions": [toAdd],
        "${toAdd}": {
          "title": "$title",
          "imagePath": "$imagePath",
        },
      };
    } else {
      dataToUpload = json.decode(previousData);
      for (var throwaway in dataToUpload["actions"]) {
        toAdd++;
      }
      dataToUpload["actions"].add(toAdd);
      dataToUpload["${toAdd}"] = {
        "title": "$title",
        "imagePath": "$imagePath",
      };
    }
    prefs.setString(
      "actionData",
      json.encode(dataToUpload),
    );
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            "Nice!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        )
      ],
      type: AlertType.success,
      style: AlertStyle(),
      title: "Your Action has been Added",
      desc:
          "Your action has succesfully been added! You can now go back to the soundboard screen and use it as you please.",
    ).show();
  }

  @override
  void initState() {
    titleController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add an action"),
      ),
      drawer: MainDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Please enter the title of the action you wish to add",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      errorText: validateTitle ? "Please enter a title!" : null,
                    ),
                    controller: titleController,
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Please select an image of the action you wish to add",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    takeImage();
                  },
                  child: Text(
                    "Add an image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.black,
                  child: isImageTaken
                      ? Image(
                          image: FileImage(
                            File(imagePath),
                          ),
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * (1 / 1.1),
              height: 50,
              child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      saveAction(context);
                    });
                  },
                  color: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
