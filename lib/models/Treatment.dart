class Treatment {
  String nameTreatment;
  double price;
  String description;

  Treatment(
      {required this.nameTreatment,
      required this.price,
      required this.description});
  factory Treatment.fromJsonResponse(Map<String, dynamic> response) {
    return Treatment(
        nameTreatment: response['nameTreatment'],
        price: response['price'],
        description: response['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nameTreatment': this.nameTreatment,
      'price': this.price,
      'description': this.description
    };
  }
}
