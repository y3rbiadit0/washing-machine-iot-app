import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_provider.dart';
import '../main.dart';
import '../modules/login_page/login_page.dart';
import '../routes/routes.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.login_page.path,
    routes: [
      GoRoute(
        path: AppRoutes.login_page.path,
        name: AppRoutes.login_page.name,
        builder: (context, state) {
          return const LoginPage();
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
    redirect: (BuildContext context, GoRouterState state) {
      // If our async state is loading, don't perform redirects, yet
      return handleAuthStateChanges(authState, state);
    },
  );
});

String? handleAuthStateChanges(
    AsyncValue<User?> authState, GoRouterState state) {
  // if (authState.isLoading || authState.hasError) return null;
  //
  // // Here we guarantee that hasData == true, i.e. we have a readable value
  //
  // // This has to do with how the FirebaseAuth SDK handles the "log-in" state
  // // Returning `null` means "we are not authorized"
  // final isAuth = authState.valueOrNull != null;
  //
  // final isLoginPage = state.path == AppRoutes.login_page.path;
  // if (isLoginPage) {
  //   return isAuth ? AppRoutes.homepage.path : AppRoutes.login_page.path;
  // }
  // return isAuth ? null : AppRoutes.login_page.path;
}
