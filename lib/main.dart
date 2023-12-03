import 'package:flutter/material.dart';
import 'package:flutter_chat/init.dart';
import 'package:flutter_chat/router/auto_router_pod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_logger/talker_logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final logger = TalkerLogger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://333677536fd0b78e3c56b68fca43d498@o4506263171629056.ingest.sentry.io/4506301884399616';;
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
  }, appRunner: () async {
    try {
      runApp(const ProviderScope(child: MyApp()));
    } catch (e) {
      print(e);
      await Sentry.captureException(e, stackTrace: StackTrace.current);
    }
  });
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(autrouterPod);
    return MaterialApp.router(
      routerConfig: router.config(),
    );
  }
}
