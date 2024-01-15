import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../language/l10n_helper.dart';
import '../../language/language_pop_up_menu.dart';
import '../../providers/washing_machine_api/reservation_model.dart';
import '../../providers/washing_machine_api/washing_machine_model.dart';
import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../../routes/routes.dart';
import '../error_widgets/no_connection_error.dart';
import 'widgets/machines_section_widget.dart';

class WashingMachineStatusData {
  int available = 0;
  int occupied = 0;
  int outOfService = 0;
}

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final washingMachinesStreamData = ref.watch(washingMachinesStreamProvider);
    final reservationStreamData = ref.watch(reservationsStreamProvider);

    WashingMachineStatusData washingStatusData =
        parseStatus(washingMachinesStreamData);
    bool hasReservations = (reservationStreamData.value?.length ?? 0) > 0;
    return switch (washingMachinesStreamData) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
            title: Text(context.l10n?.home_page_title ?? ""),
            actions: const [LanguagePopUpMenu(), SizedBox(width: 8.0)],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              WashingMachinesSection(
                available: washingStatusData.available,
                occupied: washingStatusData.occupied,
                outOfService: washingStatusData.outOfService,
              ),
              const SizedBox(height: 8.0),
              const DryerMachinesSection(
                available: 0,
                occupied: 0,
                outOfService: 0,
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: hasReservations
              ? FloatingScanQRActionButton(
                  reservationData: reservationStreamData.value?.first)
              : FloatingReserveActionButton(
                  washingStatusData: washingStatusData,
                ),
        ),
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(:final error) => NoConnection(onRetry: () {}),
      _ => const CircularProgressIndicator(),
    };
  }

  WashingMachineStatusData parseStatus(
      AsyncValue<List<WashingMachineModel>> washingMachinesData) {
    WashingMachineStatusData washingStatusData = WashingMachineStatusData();
    if (washingMachinesData.value != null) {
      washingStatusData.available =
          washingMachinesData.value!.where((e) => e.status == "free").length;
      washingStatusData.occupied = washingMachinesData.value!
          .where((e) => e.status == "occupied")
          .length;
      washingStatusData.outOfService = washingMachinesData.value!
          .where((e) => e.status == "out_of_service")
          .length;
    }
    return washingStatusData;
  }
}

class FloatingReserveActionButton extends StatelessWidget {
  const FloatingReserveActionButton({
    super.key,
    required this.washingStatusData,
  });

  final WashingMachineStatusData washingStatusData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: washingStatusData.available > 0
          ? () {
              context.goNamed(
                AppRoutes.reservation_page.details.name,
              );
            }
          : null,
      icon: const Icon(Icons.add),
      label: Text(
        context.l10n?.home_page_reserve_button ?? "",
        style: washingStatusData.available > 0
            ? const TextStyle(color: Colors.black)
            : const TextStyle(color: Colors.grey), // Set disabled text color
      ),
    );
  }
}

class FloatingScanQRActionButton extends StatelessWidget {
  const FloatingScanQRActionButton({
    super.key,
    required this.reservationData,
  });

  final ReservationModel? reservationData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.goNamed(
        AppRoutes.scan_qr_page_start.details.name,
      ),
      icon: const Icon(Icons.qr_code),
      label: const Text(
        "Unblock machine",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
