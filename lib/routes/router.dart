import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:washing_machine_iot_app/routes/routes.dart';

import '../auth_provider.dart';
import '../main.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash_screen.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash_screen.path,
        name: AppRoutes.splash_screen.name,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AppRoutes.homepage.path,
        name: AppRoutes.homepage.name,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
    // redirect: (context, state) {
    //   // If our async state is loading, don't perform redirects, yet
    //   return handleAuthStateChanges(authState, state);
    // },
  );
});

// String? handleAuthStateChanges(AsyncValue<User?> authState, GoRouterState state) {
//   if (authState.isLoading || authState.hasError) return null;
//
//   // Here we guarantee that hasData == true, i.e. we have a readable value
//
//   // This has to do with how the FirebaseAuth SDK handles the "log-in" state
//   // Returning `null` means "we are not authorized"
//   final isAuth = authState.valueOrNull != null;
//
//   final isSplash = state.location == SplashPage.routeLocation;
//   if (isSplash) {
//     return isAuth ? HomePage.routeLocation : LoginPage.routeLocation;
//   }
//
//   final isLoggingIn = state.location == LoginPage.routeLocation;
//   if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;
//
//   return isAuth ? null : SplashPage.routeLocation;
// }