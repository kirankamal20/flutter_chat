import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/data/service/pushnotification/i_pushnotification_service.dart';
import 'package:flutter_chat/data/service/pushnotification/pushnotification_service.dart';
import 'package:flutter_chat/main.dart';

Future<void> init() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  final IPushnotificationService notification = PushnotificationService();
  await notification.initializeFirebase();
  await notification.setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  try {
    await FirebaseMessaging.instance.getToken().then((token) {
      logger.good("Token: $token");
    });
  } catch (e) {
    logger.error("Error: $e");
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message");
}
