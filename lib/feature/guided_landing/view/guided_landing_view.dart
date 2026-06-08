import 'package:colosseum_guide/core/localization/app_localizations.dart';
import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GuidedLandingView extends ConsumerWidget {
  const GuidedLandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.stadium,
                size: 80,
                color: Color(0xFFFFC107),
              ),
              const SizedBox(height: 32),
              Text(
                strings.colosseumGuide,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color(0xFFFFC107),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                strings.landingDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                 context.goNamed(guidedSpotsViewName);
                },
                child: Text(strings.startTour),
              ),
            ],
          ),
        ),
      ),
    );
  }
}