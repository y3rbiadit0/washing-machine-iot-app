import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../language/l10n_helper.dart';
import 'washing_machine_widget.dart';

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
                    child: WashingMachineStatus(
                        number: available,
                        color: WashingMachineStatusColor.available,
                        label: context.l10n?.available ?? ""),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WashingMachineStatus(
                        number: occupied,
                        color: WashingMachineStatusColor.occupied,
                        label: context.l10n?.occupied ?? ""),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WashingMachineStatus(
                        number: outOfService,
                        color: WashingMachineStatusColor.outOfService,
                        label: context.l10n?.out_of_service ?? ""),
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
                context.l10n?.home_page_dryer_machines_label ?? "",
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
                    child: DryerMachineStatus(
                        number: available,
                        color: WashingMachineStatusColor.available,
                        label: context.l10n?.available ?? ""),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DryerMachineStatus(
                        number: occupied,
                        color: WashingMachineStatusColor.occupied,
                        label: context.l10n?.occupied ?? ""),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DryerMachineStatus(
                        number: outOfService,
                        color: WashingMachineStatusColor.outOfService,
                        label: context.l10n?.out_of_service ?? ""),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
