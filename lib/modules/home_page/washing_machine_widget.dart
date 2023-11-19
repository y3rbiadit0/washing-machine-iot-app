import 'package:flutter/material.dart';

enum WashingMachineStatusColor {
  available(value: Colors.green),
  occupied(value: Colors.orange),
  outOfService(value: Colors.red);

  const WashingMachineStatusColor({
    required this.value,
  });

  final Color value;
}

class _WashingMachineStatus extends StatelessWidget {
  final int number;
  final WashingMachineStatusColor color;
  final double size = 50.0;

  const _WashingMachineStatus(
      {super.key, required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color(0xFFD0D5DD),
          width: 1,
        ),
        color: color.value,
      ),
      width: size,
      height: size,
      child: Center(child: Text(number.toString())),
    );
  }
}

class AvailableWashingMachine extends _WashingMachineStatus {
  const AvailableWashingMachine({super.key, required number})
      : super(number: number, color: WashingMachineStatusColor.available);
}

class OccupiedWashingMachine extends _WashingMachineStatus {
  const OccupiedWashingMachine({super.key, required number})
      : super(number: number, color: WashingMachineStatusColor.occupied);
}

class OutOfServiceWashingMachine extends _WashingMachineStatus {
  const OutOfServiceWashingMachine({super.key, required number})
      : super(number: number, color: WashingMachineStatusColor.outOfService);
}
