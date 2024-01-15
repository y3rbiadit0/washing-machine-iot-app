import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../api_client.dart';
import 'reservation_model.dart';
import 'washing_machine_model.dart';

part 'washing_machine_provider.g.dart';

final apiProvider = Provider<WashingMachinesAPI>((ref) {
  return WashingMachinesAPI();
});

final allWashingMachinesProvider =
    FutureProvider<List<WashingMachineModel>>((ref) async {
  return ref.watch(apiProvider).getWashingMachines();
});

@riverpod
Stream<List<WashingMachineModel>> washingMachinesStream(
    WashingMachinesStreamRef ref) async* {
  final socket = WebSocketChannel.connect(
    Uri.parse('ws://0.0.0.0:8000/v1/washing-machines/ws'),
  );
  ref.onDispose(socket.sink.close);
  await for (final message in socket.stream) {
    List<dynamic> washing_machines_data = jsonDecode(message) as List<dynamic>;
    yield washing_machines_data
        .map((e) => WashingMachineModel.fromJson(e))
        .toList();
  }
}

class WashingMachinesAPI extends WashingMachineHttpClient {
  WashingMachinesAPI() : super();

  Future<List<WashingMachineModel>> getWashingMachines() async {
    final response = await dioClient.get("washing-machines/all");
    return (response.data as List)
        .map((json) => WashingMachineModel.fromJson(json))
        .toList();
  }

  Future<Map<String, dynamic>> getHealthStatus() async {
    final response = await dioClient.get("health");
    return response.data as Map<String, dynamic>;
  }

  Future<ReservationModel> reserveMachine() async {
    final response = await dioClient.post("washing-machines/reserve");
    return ReservationModel.fromJson(response.data);
  }
}
