import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'token_service.dart';

class DatabaseService {
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseMessaging = FirebaseMessaging.instance;
  final supabaseStorage = Supabase.instance.client;

  initialFirebaseMessaging() async {
    try {
      await firebaseMessaging.requestPermission();
    } catch (e) {
      throw Exception(e);
    }
  }

  uploadImageToStorage(String folderName, File file) async {
    final payloadUsername = await TokenService().jwtPayloadUsername();
    final fileName =
        '$payloadUsername/$folderName/${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.jpg';
    final response = await supabaseStorage.storage
        .from('storage_manber')
        .upload(fileName, file);
    if (response.isNotEmpty) {
      final publicUrl =
          supabaseStorage.storage.from('storage_manber').getPublicUrl(fileName);
      return publicUrl;
    }
    return null;
  }
}
