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

abstract class _MachineStatus extends StatelessWidget {
  final int number;
  final WashingMachineStatusColor color;

  const _MachineStatus({required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _WashingMachineStatus extends _MachineStatus {
  final double size = 50.0;

  const _WashingMachineStatus({required super.number, required super.color});

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
  const AvailableWashingMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.available);
}

class OccupiedWashingMachine extends _WashingMachineStatus {
  const OccupiedWashingMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.occupied);
}

class OutOfServiceWashingMachine extends _WashingMachineStatus {
  const OutOfServiceWashingMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.outOfService);
}

class _DryerMachineStatus extends _MachineStatus {
  final double size = 50.0;

  const _DryerMachineStatus({required super.number, required super.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Adjust the size of the circle as needed
      height: size, // Adjust the size of the circle as needed
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.value, // Adjust the color of the circle as needed
      ),
      child: ClipOval(
        child: Center(
          child: Text(
            number.toString(),
          ),
        ),
      ),
    );
  }
}

class AvailableDryerMachine extends _DryerMachineStatus {
  const AvailableDryerMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.available);
}

class OccupiedDryerMachine extends _DryerMachineStatus {
  const OccupiedDryerMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.occupied);
}

class OutOfServiceDryerMachine extends _DryerMachineStatus {
  const OutOfServiceDryerMachine({required number})
      : super(number: number, color: WashingMachineStatusColor.outOfService);
}
