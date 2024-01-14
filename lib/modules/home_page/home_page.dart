import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:washing_machine_iot_app/modules/home_page/washing_machine_widget.dart';

import '../../language/language_pop_up_menu.dart';
import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../../routes/routes.dart';
import '../error_widgets/no_connection_error.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final washingMachinesData = ref.watch(washingMachinesStreamProvider);
    int available = 0;
    int occupied = 0;
    int outOfService = 0;
    if (washingMachinesData.value != null) {
      available =
          washingMachinesData.value!.where((e) => e.status == "free").length;
      occupied = washingMachinesData.value!
          .where((e) => e.status == "occupied")
          .length;
      outOfService = washingMachinesData.value!
          .where((e) => e.status == "out_of_service")
          .length;
    }
    return switch (washingMachinesData) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)?.home_page_title ?? ""),
            actions: const [LanguagePopUpMenu(), SizedBox(width: 8.0)],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              WashingMachinesSection(
                available: available,
                occupied: occupied,
                outOfService: outOfService,
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: available > 0
                ? () {
                    context.goNamed(
                      AppRoutes.reservation_page.details.name,
                    );
                  }
                : null,
            icon: const Icon(Icons.add),
            label: Text(
              AppLocalizations.of(context)?.home_page_reserve_button ?? "",
              style: available > 0
                  ? const TextStyle(color: Colors.black)
                  : const TextStyle(
                      color: Colors.grey), // Set disabled text color
            ),
          )),
      AsyncLoading() => const CircularProgressIndicator(),
      AsyncError(:final error) => NoConnection(onRetry: () {}),
      _ => const CircularProgressIndicator(),
    };
  }
}

class WashingMachinesSection extends StatelessWidget {
  final int available;
  final int occupied;
  final int outOfService;

  const WashingMachinesSection({
    super.key,
    required this.available,
    required this.occupied,
    required this.outOfService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Column(
        children: [
          //Add a title to the row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)
                        ?.home_page_washing_machines_label ??
                    "",
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AvailableWashingMachine(number: available),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OccupiedWashingMachine(number: occupied),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutOfServiceWashingMachine(number: outOfService),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class DryerMachinesSection extends StatelessWidget {
  final int available;
  final int occupied;
  final int outOfService;

  const DryerMachinesSection({
    super.key,
    required this.available,
    required this.occupied,
    required this.outOfService,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Column(
        children: [
          //Add a title to the row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)?.home_page_dryer_machines_label ??
                    "",
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AvailableDryerMachine(number: 1),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OccupiedDryerMachine(number: 2),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: OutOfServiceDryerMachine(number: 3),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
