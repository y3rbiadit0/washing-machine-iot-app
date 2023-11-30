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
  final String label;

  const _MachineStatus(
      {required this.number, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _WashingMachineStatus extends _MachineStatus {
  final double size = 50.0;

  const _WashingMachineStatus(
      {required super.number, required super.color, required super.label});

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
      child: Column(
        children: [
          Center(child: Text(number.toString())),
          Center(child: Text(label)),
        ],
      ),
    );
  }
}

class AvailableWashingMachine extends _WashingMachineStatus {
  const AvailableWashingMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.available,
            label: "Available");
}

class OccupiedWashingMachine extends _WashingMachineStatus {
  const OccupiedWashingMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.occupied,
            label: "Occupied");
}

class OutOfServiceWashingMachine extends _WashingMachineStatus {
  const OutOfServiceWashingMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.outOfService,
            label: "Out of Service");
}

class _DryerMachineStatus extends _MachineStatus {
  final double size = 100.0;

  const _DryerMachineStatus(
      {required super.number, required super.color, required super.label});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(number.toString()),
            Text(
              label,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableDryerMachine extends _DryerMachineStatus {
  const AvailableDryerMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.available,
            label: "Available");
}

class OccupiedDryerMachine extends _DryerMachineStatus {
  const OccupiedDryerMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.occupied,
            label: "Occupied");
}

class OutOfServiceDryerMachine extends _DryerMachineStatus {
  const OutOfServiceDryerMachine({required number})
      : super(
            number: number,
            color: WashingMachineStatusColor.outOfService,
            label: "Out of Service");
}
