import 'package:auto_route/auto_route.dart';
import 'package:flutter_chat/router/guard/splash_guard.dart';
import 'package:flutter_chat/router/router.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final AutoDisposeProviderRef<AppRouter> ref;

  AppRouter({required this.ref});

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: LoginRoute.page,
            path: '/',
            initial: true,
            guards: [SplashGuard(ref: ref)]),
        AutoRoute(page: HomeRoute.page, path: '/HomeRoute'),
        AutoRoute(page: VerifyOtpRoute.page, path: '/VerifyOtpRoute'),
      ];
}
