import 'package:flutter/material.dart';
import 'package:gameaiupdate/screens/signinpage.dart';
import 'package:gameaiupdate/screens/register.dart';

class Authenticate extends StatefulWidget {
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
