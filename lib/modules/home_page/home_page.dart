import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:washing_machine_iot_app/modules/home_page/washing_machine_widget.dart';

import '../../language/language_pop_up_menu.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Washing Machines IoT"),
        actions: const [LanguagePopUpMenu(), SizedBox(width: 8.0)],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WashingMachinesSection(),
          DryerMachinesSection(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Reserve Machine!"),
      ),
    );
  }
}

class WashingMachinesSection extends StatelessWidget {
  const WashingMachinesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex: 1, child: AvailableWashingMachine(number: 1)),
        Expanded(flex: 1, child: OccupiedWashingMachine(number: 2)),
        Expanded(flex: 1, child: OutOfServiceWashingMachine(number: 3)),
      ],
    );
  }
}

class DryerMachinesSection extends StatelessWidget {
  const DryerMachinesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(flex: 1, child: AvailableDryerMachine(number: 1)),
        Expanded(flex: 1, child: OccupiedDryerMachine(number: 2)),
        Expanded(flex: 1, child: OutOfServiceDryerMachine(number: 3)),
      ],
    );
  }
}
