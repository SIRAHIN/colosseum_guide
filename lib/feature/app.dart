import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:colosseum_guide/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ToastificationWrapper(
        child: MaterialApp.router(
          theme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: RouteManager.router,
        ),
      ),
    );
  }
}
