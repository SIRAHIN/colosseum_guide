import 'package:colosseum_guide/feature/download_audio/presentation/download_audio_screen.dart';
import 'package:colosseum_guide/feature/guided_landing/view/guided_landing_view.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots/view/guided_spots_view.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view/guided_spots_details_view.dart';
import 'package:colosseum_guide/feature/language_select/view/language_select_view.dart';
import 'package:colosseum_guide/feature/settings/presentation/settings_view.dart';
import 'package:colosseum_guide/feature/splash/view/splash_view.dart';
import 'package:colosseum_guide/feature/tour_points/view/tour_points_view.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  static final GoRouter router = GoRouter(
    initialLocation: splashViewPath,
    routes: [
      GoRoute(
        name: splashViewName,
        path: splashViewPath,
        builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        name: languageSelectViewName,
        path: languageSelectViewPath,
        builder: (context, state) {
          final reRouteName = state.extra as String;
          return LanguageSelectView(reRouteName: reRouteName);
        },
      ),

      // Guided Landing Route
      GoRoute(
        name: guidedLandingViewName,
        path: guidedLandingViewPath,
        builder: (context, state) => const GuidedLandingView(),
      ),

      // Download Audio Route
      GoRoute(
        name: downloadAudioViewName,
        path: downloadAudioViewPath,
        builder: (context, state) => const DownloadAudioScreen(),
      ),

      // Guided Spots Routes
      GoRoute(
        name: guidedSpotsViewName,
        path: guidedSpotsViewPath,
        builder: (context, state) => const GuidedSpotsView(),
        routes: [
          // Tour Points List Route
          GoRoute(
            name: tourPointsViewName,
            path: tourPointsViewPath,
            builder: (context, state) {
              final tourPoints = state.extra as List<TourPointModel>;
              return TourPointsView(tourPoints: tourPoints);
            },
            routes: [
              // Guided Spots Details Route
              GoRoute(
                name: guidedSpotsDetailsName,
                path: guidedSpotsDetailsPath,
                builder: (context, state) {
                  final tourPoints = state.extra as List<TourPointModel>;
                  return GuidedSpotsDetailsView(tourPoints: tourPoints);
                },
              ),
            ],
          ),
        ],
      ),

      // Settings Route
      GoRoute(
        name: settingsViewName,
        path: settingsViewPath,
        builder: (context, state) => const SettingsView(),
      ),
    ],
  );
}

// Routes Paths
const String splashViewPath = '/';
const String guidedLandingViewPath = '/guided-landing';
const String guidedSpotsViewPath = '/guided-spots';
const String tourPointsViewPath = 'tour-points';
const String guidedSpotsDetailsPath = 'details';
const String languageSelectViewPath = '/language-select';
const String settingsViewPath = '/settings';
const String downloadAudioViewPath = '/download-audio';
// Routes Names
const String splashViewName = 'splashView';
const String guidedLandingViewName = 'guidedLandingView';
const String guidedSpotsViewName = 'guidedSpotsView';
const String tourPointsViewName = 'tourPointsView';
const String guidedSpotsDetailsName = 'guidedSpotsDetailsView';
const String languageSelectViewName = 'languageSelectView';
const String settingsViewName = 'settingsView';
const String downloadAudioViewName = 'downloadAudioView';
