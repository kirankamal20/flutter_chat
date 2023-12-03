import 'dart:convert';
import 'package:flutter_chat/main.dart';
import 'package:http/http.dart' as http;

import 'i_pushnotification_service.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushnotificationService implements IPushnotificationService {
  @override
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      logger.info('app was killed and we have a message');
      logger.info('initial message: ${initialMessage.data}');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      logger.info('app in background and we have a message');
      logger.info('onMessageOpenedApp: ${message.data}');
    });
    await registerNotificationListeners();
  }

  @override
  Future<void> registerNotificationListeners() async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'aeonbank',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initSetttings = InitializationSettings(
      android: androidSettings,
    );
    try {
      flutterLocalNotificationsPlugin.initialize(initSetttings);
    } catch (e) {
      logger.error('Error initializing flutterLocalNotificationsPlugin: $e');
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null) {
        logger.good('app in foreground and we have a message');

        StyleInformation? bigPictureStyleInformation;

        if (message.notification != null &&
            message.notification!.android != null) {
          var imageUrl = message.notification!.android!.imageUrl;

          if (imageUrl != null) {
            try {
              var image = await loadImageFromNetworkAndEncodeToBase64(imageUrl);
              bigPictureStyleInformation = BigPictureStyleInformation(
                ByteArrayAndroidBitmap.fromBase64String(image),
                largeIcon: ByteArrayAndroidBitmap.fromBase64String(image),
              );
            } catch (e) {
              logger.error('Error loading or encoding image: $e');
            }
          }
        }

        RemoteNotification? notification = message.notification;
        AndroidNotification? android = notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                playSound: true,
                styleInformation: bigPictureStyleInformation,
                color: const Color(0xFFDF0AFC),
                actions: [
                  const AndroidNotificationAction(
                    'button',
                    'Tap',
                    titleColor: Colors.red,
                    inputs: [AndroidNotificationActionInput(label: 'text')],
                  ),
                  const AndroidNotificationAction(
                    'button',
                    'Tap',
                    titleColor: Colors.black,
                  ),
                ],
              ),
            ),
          );
        }
      }
    });
  }

  Future<String> loadImageFromNetworkAndEncodeToBase64(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        List<int> imageBytes = response.bodyBytes;
        String base64Image = base64Encode(imageBytes);
        return base64Image;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      logger.error('Error loading image: $e');
      throw Exception('Failed to load image');
    }
  }

  @override
  Future<void> getToken() async {
    try {
      await FirebaseMessaging.instance.getToken().then((token) {
        logger.good("Token: $token");
      });
    } catch (e) {
      logger.error("Error: $e");
    }
  }
}
