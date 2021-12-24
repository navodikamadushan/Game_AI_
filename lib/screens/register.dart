import 'package:flutter/material.dart';
import "package:gameaiupdate/services/auth.dart";
import "package:gameaiupdate/shared/constant.dart";
import "package:gameaiupdate/shared/loading.dart";

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field State
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  var language = [
    'සිංහල',
    'English',
    'தமிழ்'
  ];
  var currentItemSelected = 'සිංහල';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('ලියාපදිංචි වන්න'),
              flexibleSpace: Image.asset(
                "assets/appbar_image.png",
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
              elevation: 10,
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('පුරන්න'),
                    onPressed: () {
                      widget.toggleView();
                    }),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'විද්‍යුත් තැපෑල'),
                        validator: (val) => val.isEmpty ? 'විද්‍යුත් තැපැල් ගිණුමක් ඇතුලත් කරන්න' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'මුර පදය'),
                        obscureText: true,
                        validator: (val) => val.length < 5 ? 'අක්ෂර 5කට වඩා ඇතුලත් කරන්න' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.purple[400],
                        child: Text(
                          'ලියාපදිංචි කරන්න',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result[0] == null) {
                              setState(() => loading = false);
                              setState(() => error = result[1]);
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
