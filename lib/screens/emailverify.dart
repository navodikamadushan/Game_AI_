import 'package:flutter/material.dart';
import "package:gameaiupdate/services/auth.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:gameaiupdate/services/email.dart";
import 'package:gameaiupdate/screens/home/lessonpage.dart';
import 'dart:async';

class EmailVerify extends StatefulWidget {
  _EmailVerifyState createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('An email has been sent ${user.email}, please verify'),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      print('verified');
      Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }
}
