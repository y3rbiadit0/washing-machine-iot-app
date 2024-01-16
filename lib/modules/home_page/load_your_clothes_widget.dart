import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:washing_machine_iot_app/providers/washing_machine_api/reservation_model.dart';

import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../../routes/routes.dart';

class LoadYourClothesWidget extends ConsumerWidget {
  final ReservationModel reservationModel;
  final StateProvider<int> stepperProvider = StateProvider<int>((ref) => 0);
  final StateProvider<String> qrCodeScanned =
      StateProvider<String>((ref) => "");

  LoadYourClothesWidget(this.reservationModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stepperProvider);
    final qrCode = ref.watch(qrCodeScanned);
    return Scaffold(
      appBar: AppBar(title: const Text("Load your clothes!")),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
          return Row(
            children: <Widget>[
              TextButton(
                onPressed: dtl.onStepContinue,
                child: Text(nextButtonText(currentStep)),
              ),
              TextButton(
                onPressed: dtl.onStepCancel,
                child: const Text(''),
              ),
            ],
          );
        },
        onStepContinue: () async {
          if (currentStep == 1) {
            await ref
                .read(washingMachineDoorProvider.notifier)
                .blockDoor(reservationModel);
            ref.read(stepperProvider.notifier).state = currentStep + 1;
          }
          if (currentStep == 2) {
            context.go(AppRoutes.homepage.details.path);
          }
        },
        onStepCancel: () => context.go(AppRoutes.homepage.details.path),
        steps: [
          Step(
            title: const Text("Scan QR"),
            content: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Scan Washing Machine - QR Code",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: MobileScanner(
                      fit: BoxFit.cover,
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                        facing: CameraFacing.back,
                        formats: [BarcodeFormat.qrCode],
                        useNewCameraSelector: true,
                      ),
                      onDetect: (capture) async {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          ref.read(qrCodeScanned.notifier).state =
                              barcodes[0].rawValue!;
                          await ref
                              .read(washingMachineDoorProvider.notifier)
                              .unblockDoor(reservationModel);
                          ref.read(stepperProvider.notifier).state = 1;
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
            title: const Text("Load"),
            content: const Column(
              children: [
                Text(
                  "Door Unblocked! - Load your clothes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Door has been unblocked!"),
                SizedBox(height: 16),
                Text("Load your clothes and close the door!",
                    style: TextStyle(fontSize: 18, color: Colors.green)),
                SizedBox(height: 16),
                Text(
                    "Press 'Continue' when clothes are loaded and door is closed"),
              ],
            ),
            isActive: currentStep == 1,
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
          ),
          Step(
            title: const Text("Start"),
            content: const Column(
              children: [
                Text(
                  "Door blocked! - Start your laundry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text("Door has been blocked!"),
                SizedBox(height: 16),
                Text("You can now start your laundry!",
                    style: TextStyle(fontSize: 18, color: Colors.green)),
                SizedBox(height: 16),
                Text(
                    "When your program is finished, scan the QR Code again to unblock the door"),
              ],
            ),
            isActive: currentStep == 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
          ),
        ],
      ),
    );
  }

  String nextButtonText(int currentStep) {
    switch (currentStep) {
      case 0:
        return "";
      case 1:
        return "Continue";
      case 2:
        return "Finish";
      default:
        return "";
    }
  }
}
