class ReservationModel {
  String machineId;
  String userId;
  String reservationId;
  String limitTime;
  String reservationStatus;

  ReservationModel(
      {required this.machineId,
      required this.userId,
      required this.reservationId,
      required this.limitTime,
      required this.reservationStatus});

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      machineId: json['machine_id'],
      limitTime: json['limit_time'],
      reservationId: json['reservation_id'],
      userId: json['user_id'],
      reservationStatus: json['reservation_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'machine_id': machineId,
      'limit_time': limitTime,
      'reservation_id': reservationId,
      'user_id': userId,
      'reservation_status': reservationStatus,
    };
  }
}
