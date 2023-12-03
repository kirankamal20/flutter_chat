import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verificationCodePod = StateProvider<String>((ref) {
  return "";
});
final authStateChangesProvider = StreamProvider<User?>((ref) async* {
  yield* FirebaseAuth.instance.authStateChanges();
});
