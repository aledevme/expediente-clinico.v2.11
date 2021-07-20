class Recetary {
  String? id;
  String? medicine;
  String? count;
  String? indication;

  Recetary(
      {required this.id,
      required this.medicine,
      required this.count,
      required this.indication});

  factory Recetary.fromJsonResponse(Map<String, dynamic> response) {
    return Recetary(
        id: response["_id"],
        medicine: response['medicine'],
        count: response['count'],
        indication: response['indication']);
  }

  Map<String, dynamic> toJson() {
    return {
      'medicine': this.medicine,
      'count': this.count,
      'indication': this.indication
    };
  }
}
