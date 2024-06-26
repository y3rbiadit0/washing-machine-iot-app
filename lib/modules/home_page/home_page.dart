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

  WashingMachineStatusData({
    this.available = 0,
    this.occupied = 0,
    this.outOfService = 0,
  });
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final washingMachinesStreamData = ref.watch(washingMachinesStreamProvider);
    final reservationStreamData = ref.watch(reservationsStreamProvider);

    WashingMachineStatusData washingStatusData =
        parseStatus(washingMachinesStreamData);

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
          floatingActionButton: buildFloatingActionButton(
            context,
            washingMachinesStreamData,
            reservationStreamData.value ?? [],
          ),
        ),
      AsyncLoading() => LoadingPage(),
      AsyncError(:final error) => NoConnection(onRetry: () {}),
      _ => LoadingPage(),
    };
  }

  StatelessWidget buildFloatingActionButton(
      BuildContext context,
      AsyncValue<List<WashingMachineModel>> data,
      List<ReservationModel> reservationsData) {
    if (reservationsData.isNotEmpty) {
      final String status = reservationsData.first.reservationStatus;
      switch (status) {
        case "created":
          return FloatingLoadClothesActionButton(
              reservationData: reservationsData.first);
        case "clothes_loaded":
          return FloatingGetYourClothesActionButton(
              reservationData: reservationsData.first);
      }
    }

    return FloatingReserveActionButton(
      washingStatusData: parseStatus(data),
    );
  }

  WashingMachineStatusData parseStatus(
      AsyncValue<List<WashingMachineModel>> washingMachinesData) {
    WashingMachineStatusData washingStatusData = WashingMachineStatusData();
    return switch (washingMachinesData) {
      AsyncData(:final value) => WashingMachineStatusData(
          available: value.where((e) => e.status == "free").length,
          occupied: value.where((e) => e.status == "occupied").length,
          outOfService: value.where((e) => e.status == "out_of_service").length,
        ),
      AsyncLoading() => washingStatusData,
      AsyncError(:final error) => washingStatusData,
      _ => washingStatusData,
    };
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

class FloatingLoadClothesActionButton extends StatelessWidget {
  const FloatingLoadClothesActionButton({
    super.key,
    required this.reservationData,
  });

  final ReservationModel? reservationData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.goNamed(
        AppRoutes.load_your_clothes.details.name,
        extra: reservationData,
      ),
      icon: const Icon(Icons.qr_code),
      label: const Text(
        "Load your clothes",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class FloatingGetYourClothesActionButton extends StatelessWidget {
  const FloatingGetYourClothesActionButton({
    super.key,
    required this.reservationData,
  });

  final ReservationModel? reservationData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.goNamed(
        AppRoutes.get_your_clothes.details.name,
        extra: reservationData,
      ),
      icon: const Icon(Icons.qr_code),
      label: const Text(
        "Get your clothes",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n?.home_page_title ?? ""),
        actions: const [LanguagePopUpMenu(), SizedBox(width: 8.0)],
      ),
      body: const Center(
        child:
            CircularProgressIndicator(), // You can customize the loading indicator
      ),
    );
  }
}
