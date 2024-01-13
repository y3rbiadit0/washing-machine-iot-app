import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/washing_machine_api/reservation_model.dart';
import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../../routes/routes.dart';

final StateProvider<int> stepperProvider = StateProvider<int>((ref) => 0);

final FutureProvider<ReservationModel> reservationProvider =
    FutureProvider<ReservationModel>((ref) async {
  return ref.watch(apiProvider).reserveMachine();
});

class ReservationStepper extends ConsumerWidget {
  const ReservationStepper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperProvider);
    final reservationData = ref.watch(reservationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve Machine'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          final isFinalStep = ref.read(stepperProvider.notifier).state == 1;
          return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: isFinalStep ? const Text('Finish') : const Text(''),
              ),
              TextButton(
                onPressed: dtl.onStepCancel,
                child: const Text(''),
              ),
            ],
          );
        },
        onStepContinue: () => context.go(AppRoutes.homepage.details.path),
        steps: [
          Step(
            title: const Text('Reserving Machine'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Reserving your machine...'),
                const SizedBox(height: 16),
                reservationData.when(
                  loading: () => const CircularProgressIndicator(),
                  data: (data) {
                    _moveToNextStep(
                      ref: ref,
                      context: context,
                      currentStep: ref.read(stepperProvider.notifier).state,
                    );
                    return const Icon(Icons.check,
                        color: Colors.green, size: 50);
                  },
                  error: (err, stack) => Text('Error: $err'),
                ),
              ],
            ),
            isActive: currentStep == 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text('Machine Information'),
            content: Column(
              children: [
                Text(
                  "Washing Machine ID ${reservationData.value?.machineId}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text('Information about the machine:'),
                SizedBox(height: 16),
                Text('Reserved!',
                    style: TextStyle(fontSize: 18, color: Colors.green)),
                SizedBox(height: 16),
                Text('15 min to load your clothes'),
              ],
            ),
            isActive: currentStep == 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }

  void _moveToNextStep(
      {required WidgetRef ref,
      required BuildContext context,
      required int currentStep}) {
    Future.delayed(const Duration(seconds: 1), () {
      if (currentStep == 0) {
        ref.read(stepperProvider.notifier).state = currentStep + 1;
      }
    });
  }
}
