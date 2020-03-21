import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Components/Component.dart';

class Auth {
  var _phoneNumber;
  var _smsCode;
  var _verificationId;
  var _auth = FirebaseAuth.instance;
  var _user;

  Future<FirebaseUser> checkUser() async {
    return await _auth.currentUser().then((user) {
      if (user == null)
        return null;
      else {
        _user = user;
        Component.user = user;
        return user;
      }
    });
  }

  signedIn() => Component.parent.setScreen();

  void verifyPhoneNumber(phoneNumber) async {
    _phoneNumber = phoneNumber;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential).then((value) {
        _user = value.user;
        print('Authentication Success!');
        signedIn();
      });
      //TODO:Auth Completed
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('Authentication Failed!');
      //TODO:Auth Failed
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      print('Otp Sent Successfully');
      Component.parent.scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Otp Sent')));
      //TODO: Code Sent
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print('Code Auto Retrieval Time Out');
      _verificationId = verificationId;
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + _phoneNumber,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void signInWithPhoneNumber(otp) async {
    _smsCode = otp;
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );

    await _auth.signInWithCredential(credential).then((value) {
      _user = value.user;
      print('Authentication Success!');
      signedIn();
    });
  }
}
