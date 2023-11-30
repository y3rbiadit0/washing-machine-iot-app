import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api_client.dart';
import 'washing_machine_model.dart';

final apiProvider = Provider<WashingMachinesAPI>((ref) {
  return WashingMachinesAPI();
});

final allWashingMachinesProvider =
    FutureProvider<List<WashingMachineModel>>((ref) async {
  return ref.watch(apiProvider).getWashingMachines();
});

class WashingMachinesAPI extends WashingMachineHttpClient {
  WashingMachinesAPI() : super();

  Future<List<WashingMachineModel>> getWashingMachines() async {
    final response = await dioClient.get("/washing-machines/all");
    return (response.data as List)
        .map((json) => WashingMachineModel.fromJson(json))
        .toList();
  }
}
