import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/features/login_page/controller/verification_code_pod.dart';
import 'package:flutter_chat/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider = StreamProvider<Map?>(
  (ref) {
    try {
      final userStream = ref.watch(authStateChangesProvider);

      var user = userStream.value;

      if (user != null) {
        var docRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        return docRef.snapshots().map((doc) {
          logger.info(doc.data());
          return doc.data();
        });
      } else {
        return const Stream.empty();
      }
    } catch (e) {
      return Stream.error(e);
    }
  },
);
