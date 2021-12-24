import 'package:flutter/material.dart';

class AlertService {
  BuildContext context;
  String titleofAlret;
  String contentofAlert;

  singleButtonAlert(BuildContext context, String titleofAlret, String contentofAlert) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            titleofAlret,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(contentofAlert),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('අනුමත කරනවා'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
