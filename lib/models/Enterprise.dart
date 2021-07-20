import 'package:expediente_clinico/models/Clinic.dart';

class Enterprise {
  String id;
  String name;
  String socialReason;
  String direction;
  String doctorId;
  List<Clinic> clinics;

  Enterprise(
      {required this.id,
      required this.name,
      required this.socialReason,
      required this.direction,
      required this.doctorId,
      required this.clinics});

  factory Enterprise.fromJsonResponse(Map<String, dynamic> response) {
    return Enterprise(
        id: response['_id'],
        name: response['name'],
        socialReason: response['socialReason'],
        direction: response['direction'],
        doctorId: response['doctor'],
        clinics: (response['clinic'] as List)
            .map((e) => Clinic.fromJsonResponse(e))
            .toList());
  }
}
