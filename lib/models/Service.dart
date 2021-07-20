class Service {
  String id;
  String code;
  String typeOfService;
  String typeOfTreatment;
  String price;
  String clinic;

  Service(
      {required this.id,
      required this.code,
      required this.typeOfService,
      required this.typeOfTreatment,
      required this.price,
      required this.clinic});

  factory Service.fromJsonResponse(Map<String, dynamic> response) {
    return Service(
        id: response['_id'],
        code: response['code'],
        typeOfService: response['typeofservice'],
        typeOfTreatment: response['typeoftreatment'],
        price: response['price'],
        clinic: response['clinic']);
  }
}
