import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:washing_machine_iot_app/providers/washing_machine_api/reservation_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../api_client.dart';
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
    Uri.parse(
        'ws://${WashingMachineHttpClient.serverAddress}/v1/washing-machines/washing-machines-ws'),
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
    Uri.parse(
        'ws://${WashingMachineHttpClient.serverAddress}/v1/washing-machines/reservation-ws'),
  );
  ref.onDispose(socket.sink.close);
  await for (final message in socket.stream) {
    List<dynamic> reservationsData = jsonDecode(message) as List<dynamic>;
    List<ReservationModel> data =
        reservationsData.map((e) => ReservationModel.fromJson(e)).toList();
    yield data.where((e) => e.reservationStatus != "finished").toList();
  }
}

@riverpod
class WashingMachineDoorProvider extends _$WashingMachineDoorProvider {
  @override
  Future<void> build() async {}

  Future<void> blockDoor(ReservationModel reservationModel) async {
    await WashingMachinesAPI().blockDoor(reservationModel);
  }

  Future<void> unblockDoor(ReservationModel reservationModel) async {
    await WashingMachinesAPI().unblockDoor(reservationModel);
  }
}
