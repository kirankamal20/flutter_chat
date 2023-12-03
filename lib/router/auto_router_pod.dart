import 'package:flutter_chat/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autrouterPod = Provider.autoDispose<AppRouter>((ref) {
  return AppRouter(ref: ref);
});
