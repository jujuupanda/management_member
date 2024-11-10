import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseMessaging = FirebaseMessaging.instance;

  initialFirebaseMessaging() async {
    try {
      await firebaseMessaging.requestPermission();
    } catch (e) {
      throw Exception(e);
    }
  }
}
