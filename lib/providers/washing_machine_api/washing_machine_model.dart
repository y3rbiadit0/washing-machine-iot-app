class WashingMachineModel {
  String machineId;
  String location;
  int capacityKg;
  int price;
  String status;
  String qrCode;
  String brand;
  String model;

  WashingMachineModel({
    required this.machineId,
    required this.location,
    required this.capacityKg,
    this.price = 0,
    this.status = 'free',
    required this.qrCode,
    required this.brand,
    required this.model,
  });

  factory WashingMachineModel.fromJson(Map<String, dynamic> json) {
    return WashingMachineModel(
      machineId: json['machine_id'],
      location: json['location'],
      capacityKg: json['capacity_kg'],
      price: json['price'] ?? 0,
      status: json['status'] ?? 'free',
      qrCode: json['qr_code'],
      brand: json['brand'],
      model: json['model'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machine_id': machineId,
      'location': location,
      'capacity_kg': capacityKg,
      'price': price,
      'status': status,
      'qr_code': qrCode,
      'brand': brand,
      'model': model,
    };
  }
}
