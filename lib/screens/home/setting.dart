import 'package:flutter/material.dart';
import "package:gameaiupdate/services/auth.dart";
import "package:gameaiupdate/services/email.dart";
import "package:gameaiupdate/models/user.dart";
////import "package:gameaiupdate/services/smsservice.dart";
import "package:gameaiupdate/services/alert.dart";
import "package:gameaiupdate/services/database.dart";
import "package:gameaiupdate/shared/constant.dart";
import "package:gameaiupdate/shared/loading.dart";
import "package:gameaiupdate/screens/authenticate.dart";
import 'package:gameaiupdate/screens/signinpage.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatefulWidget {
  BuildContext profile_context;
  //SettingPage({this.context});
  SettingPage(BuildContext context) {
    this.profile_context = context;
  }
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final EmailService _email = EmailService();
  final DatabaseService _database = DatabaseService();
  ////final SmsService _sms = SmsService();
  Timer timer;
  User user;
  bool isEmailVerified;

  @override
  void initState() {
    isEmailVerified = _auth.returnExactFirebaseUser().emailVerified;
    user = _auth.returnExactFirebaseUser();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
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
    final AlertService _alertService = AlertService();
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('සැකසීම'),
              flexibleSpace: Image.asset(
                "assets/appbar_image.png",
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
              elevation: 10,
            ),
            body: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text('Account'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.local_phone),
                    title: Text('දුරකතන අංකය'),
                    onTap: () {
                      _alertService.addMobileNumberAlert(context).then((onValue) async {
                        print(onValue);
                        setState(() => loading = true);
                        dynamic currentUserId = await _auth.getCurrentUser();
                        dynamic result = await _database.updatePhoneNumbertoUserProfile(currentUserId.uid, onValue);
                        if (result == null) {
                          setState(() => loading = false);
                          print('null');
                        } else {
                          print('not null');
                        }
                      });
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: isEmailVerified
                        ? Text(
                            'ඊමේල් ලිපිනය තහවුරු කර ඇත',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          )
                        : Text(
                            'ඊමේල් ලිපිනය තහවුරු කරන්න',
                          ),
                    onTap: () async {
                      _email.sendEmailVerification();
                      if (isEmailVerified) {
                        print('Already Verified');
                        _alertService.singleButtonAlert(context, 'සැකසීම සඳහා ඇඟවීම', 'ඔබ දැනටමත් ඊමේල් ලිපිනය සත්‍යාපනය කර ඇත.');
                      } else {
                        _alertService.singleButtonAlert(context, 'සැකසීම සඳහා ඇඟවීම', '${_auth.returnExactFirebaseUser().email} වෙත විද්‍යුත් තැපෑලක් යවා ඇත. කරුණාකර එය තහවුරු කරන්න.');
                      }
                    },
                    trailing: isEmailVerified
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : null,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('වරන්න'),
                    onTap: () {
                      _alertService.signOutAlert(context).then((onValue) async {
                        if (onValue) {
                          print('true!');
                          setState(() => loading = true);
                          dynamic signoutresult = await _auth.signOut();
                          // print(signoutresult.toString());
                          if (signoutresult == null) {
                            Navigator.pop(widget.profile_context);
                            Navigator.pop(context);
                            setState(() => loading = false);
                            print('signing out!');
                          }
                        } else {
                          print('false!');
                        }
                      });

                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignInPage()), (Route<dynamic> route) => false);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      'ගිණුම මකන්න',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Security'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('මුරපදය වෙනස් කරන්න'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Common'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text('යාවත්කාලීන කරන්න'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('භාෂාව'),
                    subtitle: Text('සිංහල'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> checkEmailVerified() async {
    user = _auth.returnExactFirebaseUser();
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      setState(() => isEmailVerified = true);
      print('verified');
    }
  }
}
