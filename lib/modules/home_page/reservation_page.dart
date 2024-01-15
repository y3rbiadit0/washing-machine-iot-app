import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:washing_machine_iot_app/language/l10n_helper.dart';

import '../../providers/washing_machine_api/reservation_model.dart';
import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../../routes/routes.dart';

class ReservationStepper extends ConsumerWidget {
  ReservationStepper({super.key});

  final StateProvider<int> stepperProvider = StateProvider<int>((ref) => 0);

  final FutureProvider<ReservationModel> reservationProvider =
      FutureProvider<ReservationModel>((ref) async {
    return ref.watch(apiProvider).reserveMachine();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperProvider);
    final reservationData = ref.watch(reservationProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n!.reservation_page_title)),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          final isFinalStep = ref.read(stepperProvider.notifier).state == 1;
          return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: isFinalStep
                    ? Text(context.l10n!.reservation_step_finish)
                    : const Text(''),
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
            title: Text(context.l10n!.reservation_step_1_title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n!.reservation_step_1_description),
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
            title: Text(context.l10n!.reservation_step_2_title),
            content: Column(
              children: [
                Text(
                  "${context.l10n!.reservation_step_2_machine_id} ${reservationData.value?.machineId}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(context.l10n!.reservation_step_2_machine_data),
                const SizedBox(height: 16),
                Text(context.l10n!.reservatopn_step_2_action,
                    style: const TextStyle(fontSize: 18, color: Colors.green)),
                const SizedBox(height: 16),
                Text(context.l10n!.reservation_step_2_description),
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
