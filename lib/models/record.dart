//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final int categoryid;
  final String categorySin;
  final int dqcount;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['categoryid'] != null),
        assert(map['categorySin'] != null),
        assert(map['dqcount'] != null),
        categoryid = map['categoryid'],
        categorySin = map['categorySin'],
        dqcount = map['dqcount'];
  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
  @override
  String toString() => "Record<$categoryid:$categorySin:$dqcount>";
}
