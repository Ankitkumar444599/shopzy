import 'package:ai_real_estate/screens/auth/auth_screen.dart';
import 'package:ai_real_estate/screens/comparison/comparison_screen.dart';
import 'package:ai_real_estate/screens/dashboard/dashboard_screen.dart';
import 'package:ai_real_estate/screens/favorites/favorites_screen.dart';
import 'package:ai_real_estate/screens/history/history_screen.dart';
import 'package:ai_real_estate/screens/home/home_screen.dart';
import 'package:ai_real_estate/screens/maps/map_screen.dart';
import 'package:ai_real_estate/screens/prediction/prediction_screen.dart';
import 'package:ai_real_estate/screens/reports/reports_screen.dart';
import 'package:ai_real_estate/screens/settings/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) => GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/auth', builder: (_, __) => const AuthScreen()),
        GoRoute(path: '/predict', builder: (_, __) => const PredictionScreen()),
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/compare', builder: (_, __) => const ComparisonScreen()),
        GoRoute(path: '/history', builder: (_, __) => const HistoryScreen()),
        GoRoute(path: '/favorites', builder: (_, __) => const FavoritesScreen()),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
        GoRoute(path: '/map', builder: (_, __) => const MapScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    ));
