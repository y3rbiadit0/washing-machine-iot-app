import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/auth_provider.dart';
import '../modules/home_page/get_your_clothes_widget.dart';
import '../modules/home_page/home_page.dart';
import '../modules/home_page/load_your_clothes_widget.dart';
import '../modules/home_page/reservation_page.dart';
import '../modules/login_page/login_page.dart';
import '../providers/washing_machine_api/reservation_model.dart';
import '../routes/routes.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.homepage.details.path,
    routes: [
      GoRoute(
        path: AppRoutes.login_page.details.path,
        name: AppRoutes.login_page.details.name,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.homepage.details.path,
        name: AppRoutes.homepage.details.name,
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: AppRoutes.reservation_page.details.path,
        name: AppRoutes.reservation_page.details.name,
        builder: (context, state) {
          return ReservationStepper();
        },
      ),
      GoRoute(
        path: AppRoutes.load_your_clothes.details.path,
        name: AppRoutes.load_your_clothes.details.name,
        builder: (context, state) {
          return LoadYourClothesWidget(state.extra as ReservationModel);
        },
      ),
      GoRoute(
        path: AppRoutes.get_your_clothes.details.path,
        name: AppRoutes.get_your_clothes.details.name,
        builder: (context, state) {
          return GetYourClothesWidget(state.extra as ReservationModel);
        },
      )
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
