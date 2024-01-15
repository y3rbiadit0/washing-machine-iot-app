import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:washing_machine_iot_app/providers/washing_machine_api/reservation_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'washing_machine_api_client.dart';
import 'washing_machine_model.dart';

part 'washing_machine_provider.g.dart';

final apiProvider = Provider<WashingMachinesAPI>((ref) {
  return WashingMachinesAPI();
});

@riverpod
Stream<List<WashingMachineModel>> washingMachinesStream(
    WashingMachinesStreamRef ref) async* {
  final socket = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:8000/v1/washing-machines/washing-machines-ws'),
  );
  ref.onDispose(socket.sink.close);
  await for (final message in socket.stream) {
    List<dynamic> washing_machines_data = jsonDecode(message) as List<dynamic>;
    yield washing_machines_data
        .map((e) => WashingMachineModel.fromJson(e))
        .toList();
  }
}

@riverpod
Stream<List<ReservationModel>> reservationsStream(
    ReservationsStreamRef ref) async* {
  final socket = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:8000/v1/washing-machines/reservation-ws'),
  );
  ref.onDispose(socket.sink.close);
  await for (final message in socket.stream) {
    List<dynamic> reservationsData = jsonDecode(message) as List<dynamic>;
    yield reservationsData.map((e) => ReservationModel.fromJson(e)).toList();
  }
}
