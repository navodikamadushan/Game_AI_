import 'package:flutter/material.dart';
import 'package:gameaiupdate/screens/home/lessonpage.dart';
import 'package:gameaiupdate/screens/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:gameaiupdate/models/user.dart';
import 'package:gameaiupdate/screens/emailverify.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);
    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MyHomePage();
      //return EmailVerify();
    }
    //return SignInPage();
  }
}
