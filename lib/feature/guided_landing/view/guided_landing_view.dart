import 'package:colosseum_guide/core/route/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuidedLandingView extends StatelessWidget {
  const GuidedLandingView({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Colosseum Guide',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: const Color(0xFFFFC107),
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Explore the Colosseum through panoramic views and immersive audio narration. Navigate through 5 iconic stops.',
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
                child: const Text('Start Tour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}