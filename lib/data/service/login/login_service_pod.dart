import 'package:flutter_chat/data/service/login/i_login_service.dart';
import 'package:flutter_chat/data/service/login/login_service.dart';
import 'package:flutter_chat/data/service/pushnotification/pushnotification_pod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final loginPod = Provider.autoDispose<ILoginService>((ref) {
  return LoginService(firebaseAuth: ref.watch(firebaseAuthProvider));
});
