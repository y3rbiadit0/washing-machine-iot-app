import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'washing_machine_api/washing_machine_provider.dart';

final internetConnectionProvider = StreamProvider.autoDispose<bool>((ref) {
  final apiService = WashingMachinesAPI();
  final StreamController<bool> controller = StreamController<bool>.broadcast();

  ref.onDispose(() => controller.close());

  Future<void> checkServerConnection() async {
    try {
      await apiService.getHealthStatus();
      controller.add(true);
    } catch (e) {
      controller.add(false);
    }
  }

  ref.watch(FutureProvider.autoDispose<void>((ref) async {
    await Future<void>.delayed(const Duration(seconds: 5));
    await checkServerConnection();
  }));

  return controller.stream;
});
