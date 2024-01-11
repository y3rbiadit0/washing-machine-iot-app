import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:washing_machine_iot_app/modules/home_page/washing_machine_widget.dart';

import '../../language/language_pop_up_menu.dart';
import '../../providers/washing_machine_api/washing_machine_provider.dart';
import '../error_widgets/no_connection_error.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final washingMachinesData = ref.watch(allWashingMachinesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.home_page_title ?? ""),
        actions: const [LanguagePopUpMenu(), SizedBox(width: 8.0)],
      ),
      body: washingMachinesData.when(
          data: (data) {
            int available = data.where((e) => e.status == "free").length;
            int occupied = data.where((e) => e.status == "occupied").length;
            int outOfService =
                data.where((e) => e.status == "out_of_service").length;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                WashingMachinesSection(
                    available: available,
                    occupied: occupied,
                    outOfService: outOfService),
                const SizedBox(height: 8.0),
                const DryerMachinesSection(
                    available: 1, occupied: 2, outOfService: 3),
              ],
            );
          },
          error: (error, stack) => Center(child: NoConnection(
                onRetry: () {
                  ref.refresh(allWashingMachinesProvider.future);
                },
              )),
          loading: () => const Center(child: CircularProgressIndicator())),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          AppLocalizations.of(context)?.home_page_reserve_button ?? "",
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
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
