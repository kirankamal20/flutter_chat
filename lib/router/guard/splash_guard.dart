import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/features/login_page/controller/verification_code_pod.dart';
import 'package:flutter_chat/main.dart';
import 'package:flutter_chat/router/router.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashGuard extends AutoRouteGuard {
  final AutoDisposeProviderRef<AppRouter> ref;

  SplashGuard({required this.ref});
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    try {
      final result = await ref.watch(authStateChangesProvider.future);
      if (result != null) {
        logger.good(result);
        router.navigate(const HomeRoute());
      } else {
        resolver.next(true);
      }
    } catch (e) {
      resolver.next(true);
    }
  }
}
