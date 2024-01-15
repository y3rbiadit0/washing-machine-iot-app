import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../language/l10n_helper.dart';
import '../../routes/routes.dart';

class ScanQRStepperStart extends ConsumerWidget {
  ScanQRStepperStart({super.key});

  final StateProvider<int> stepperProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Unblocking Door")),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          final isFinalStep = ref.read(stepperProvider.notifier).state == 1;
          return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: isFinalStep ? Text("Finish") : const Text(''),
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
            title: const Text("Scan QR"),
            content: SafeArea(
              child: Column(
                children: [
                  Text("Scan Washing Machine - QR Code"),
                  SizedBox(height: 16),
                  Container(
                    width: 350,
                    height: 350,
                    child: MobileScanner(
                      fit: BoxFit.contain,
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.normal,
                        facing: CameraFacing.front,
                        formats: [BarcodeFormat.qrCode],
                        useNewCameraSelector: true,
                      ),
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;
                        for (final barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue}');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            isActive: currentStep == 0,
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text("Load Clothes"),
            content: Column(
              children: [
                const Text(
                  "Reservation for 1 hour",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
