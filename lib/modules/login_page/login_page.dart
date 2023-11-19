import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/auth.dart';
import '../../routes/routes.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Washing Machine IoT"),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                //TODO: Activate this when main functionalities are done!
                //await Authentication().signInWithGoogle(context);
                context.go(AppRoutes.homepage.path);
              },
              child: const Text("Sign in with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
