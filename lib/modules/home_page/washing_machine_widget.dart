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

class WashingMachineStatus extends _MachineStatus {
  final double size = 50.0;

  const WashingMachineStatus(
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

class DryerMachineStatus extends _MachineStatus {
  final double size = 100.0;

  const DryerMachineStatus(
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
