import 'dart:async';

import '../api_client.dart';
import 'reservation_model.dart';
import 'washing_machine_model.dart';

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

  Future<Map<String, dynamic>> blockDoor(
      ReservationModel reservationModel) async {
    final response = await dioClient.post("washing-machines/block",
        data: reservationModel.toJson());
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> unblockDoor(
      ReservationModel reservationModel) async {
    final response = await dioClient.post("washing-machines/unblock",
        data: reservationModel.toJson());
    return response.data as Map<String, dynamic>;
  }
}
