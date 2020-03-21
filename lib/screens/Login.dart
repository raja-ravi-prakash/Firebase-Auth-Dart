import 'package:flutter/material.dart';
import '../Auth/Auth.dart';

class Login extends StatelessWidget {
  var _phoneNumber;
  var _otp;
  Auth _auth = Auth();

  Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => _phoneNumber = value,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) => _otp = value,
                      decoration: InputDecoration(labelText: 'OTP'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: () {
                          _auth.verifyPhoneNumber(_phoneNumber);
                        },
                        child: Text('Login')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        onPressed: () {
                          _auth.signInWithPhoneNumber(_otp);
                        },
                        child: Text('OTP')),
                  )
                ],
              ),
            )));
  }
}
