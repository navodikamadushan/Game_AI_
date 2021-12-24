import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference deviceInfo = FirebaseFirestore.instance.collection('deviceInfo');
  final CollectionReference tf_categories = FirebaseFirestore.instance.collection('tf_categories');

  Future updateUserData(String email, String language) async {
    return await users.doc(uid).set({
      'email': email,
      'language': language,
    });
  }

  Future updateDeviceInfo(String deviceId, String language) async {
    return await deviceInfo.doc(deviceId).set({
      'language': language,
    });
  }

  // store to user document
  Future updateUserProfileData(String currentUserId, String name, String email, String about) async {
    return await users.doc(currentUserId).set({
      'name': name,
      'email': email,
      'about': about,
    });
  }

  // get tf_categories stream
  Stream<QuerySnapshot> get lessons {
    return tf_categories.snapshots();
  }
}
