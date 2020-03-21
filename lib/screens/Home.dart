import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/Component.dart';

class Home extends StatelessWidget {
  Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RaisedButton(
          child: Text('Sign Out'),
          onPressed: () async {
            await FirebaseAuth.instance.signOut().then((value) {
              Component.parent.setScreen();
            });
          }),
    ));
  }
}
