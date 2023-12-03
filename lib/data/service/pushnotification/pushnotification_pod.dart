import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chat/data/service/pushnotification/i_pushnotification_service.dart';
import 'package:flutter_chat/data/service/pushnotification/pushnotification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider =
    Provider.autoDispose<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firebaseMessagingPod = Provider.autoDispose<FirebaseMessaging>(
    (ref) => FirebaseMessaging.instance);

final pushNotifcationPod =
    Provider.autoDispose<IPushnotificationService>((ref) {
  return PushnotificationService();
});
