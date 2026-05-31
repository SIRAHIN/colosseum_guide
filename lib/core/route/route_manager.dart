import 'package:colosseum_guide/feature/guided_landing/view/guided_landing_view.dart';
import 'package:colosseum_guide/feature/guided_spots/model/guide_model.dart';
import 'package:colosseum_guide/feature/guided_spots/view/guided_spots_view.dart';
import 'package:colosseum_guide/feature/guided_spots_details/view/guided_spots_details_view.dart';
import 'package:colosseum_guide/feature/splash/view/splash_view.dart';
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

      // Guided Landing Route
      GoRoute(
        name: guidedLandingViewName,
        path: guidedLandingViewPath,
        builder: (context, state) => const GuidedLandingView(),
      ),

      // Guided Spots Routes
      GoRoute(
        name: guidedSpotsViewName,
        path: guidedSpotsViewPath,
        builder: (context, state) => const GuidedSpotsView(),
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
  );
}

// Routes Paths
const String splashViewPath = '/';
const String guidedLandingViewPath = '/guided-landing';
const String guidedSpotsViewPath = '/guided-spots';
const String guidedSpotsDetailsPath = 'guided-spots-details';

// Routes Names
const String splashViewName = 'splashView';
const String guidedLandingViewName = 'guidedLandingView';
const String guidedSpotsViewName = 'guidedSpotsView';
const String guidedSpotsDetailsName = 'guidedSpotsDetailsView';
