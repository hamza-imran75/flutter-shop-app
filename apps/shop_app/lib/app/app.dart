import 'package:context_watch/context_watch.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app_route.dart';
import 'auth_gate.dart';

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});

  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  // WidgetsApp, unlike MaterialApp, does not install a HeroController.
  final _heroController = HeroController();
  late final _observers = <NavigatorObserver>[_heroController];

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ContextWatch.root(
      child: WidgetsApp(
        title: 'Shop',
        color: AppColors.background,
        textStyle: AppTextStyles.body,
        debugShowCheckedModeBanner: false,
        navigatorObservers: _observers,
        pageRouteBuilder: <T>(settings, builder) =>
            appRoute<T>(builder, settings: settings),
        builder: (context, child) =>
            ColoredBox(color: AppColors.background, child: child),
        home: const AuthGate(),
      ),
    );
  }
}
