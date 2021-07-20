import 'package:expediente_clinico/models/Expedient.dart';

class Inquirie {
  String id;
  Expedient expedient;
  String service;
  dynamic baseprice;
  List<dynamic> treatments;
  List<dynamic> recetaries;
  late String clinic;
  String status;
  String type;
  dynamic totalService;
  dynamic balance;
  dynamic quota;
  dynamic deposit;
  int session;
  List<dynamic> history;

  Inquirie(
      {required this.id,
      required this.expedient,
      required this.service,
      required this.treatments,
      required this.status,
      required this.recetaries,
      required this.type,
      required this.baseprice,
      required this.totalService,
      required this.balance,
      required this.quota,
      required this.history,
      required this.session});

  factory Inquirie.fromJsonResponse(Map<String, dynamic> response) {
    return Inquirie(
        id: response['_id'],
        expedient: Expedient.fromJsonResponse(response['patient']),
        service: response['service'],
        baseprice: response['baseprice']["\$numberDecimal"] ?? 0,
        treatments: response['treatments'] ?? [],
        status: response['status'],
        type: response['type'],
        history: response['subinquirie'] ?? [],
        balance: response['balance']["\$numberDecimal"] ?? 0,
        quota: response['quota']["\$numberDecimal"] ?? 0,
        session: response['session'],
        recetaries: response['recetaries'] ?? [],
        totalService: response['totalService']["\$numberDecimal"] ?? 0);
  }
}
