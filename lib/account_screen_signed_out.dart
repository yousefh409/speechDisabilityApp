import 'package:flutter/material.dart';
import 'package:learning_disability_app/auth_screen.dart';
import 'package:learning_disability_app/main_drawer.dart';

class SignedIn extends StatefulWidget {
  @override
  _SignedInState createState() => _SignedInState();
}

class _SignedInState extends State<SignedIn>
    with SingleTickerProviderStateMixin {
  bool isSigningIn = false;
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    offset = Tween<Offset>(begin: Offset(0, -3), end: Offset(0.0, 0.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Info"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Stack(
          children: <Widget>[
            isSigningIn
                ? SlideTransition(
                    position: offset,
                    child: AuthCard(),
                  )
                : SizedBox(),
            !isSigningIn
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.account_box),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            isSigningIn = true;
                            controller.forward();
                          });
                        },
                        child: Text("Get an Account!"),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
