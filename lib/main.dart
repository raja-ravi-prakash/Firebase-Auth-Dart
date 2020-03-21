import 'package:flutter/material.dart';
import 'Auth/Auth.dart';
import 'screens/Home.dart';
import 'screens/Login.dart';
import 'Components/Component.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Main());
  }
}

class Main extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  var _auth = Auth();
  var _home;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _home = loading();
    super.initState();
    Component.parent = this;
    setScreen();
  }

  setScreen() async {
    print('Set Screen Called!');
    await _auth.checkUser().then((user) {
      if (user == null)
        setState(() {
          _home = Login();
        });
      else
        setState(() {
          _home = Home();
        });
    });
  }

  loading() {
    return Center(
      child: LinearProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _home,
    );
  }
}
