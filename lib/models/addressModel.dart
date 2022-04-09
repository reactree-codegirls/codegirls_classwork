class AddressModel {
  String street, suite, city;
  AddressModel({this.street, this.suite, this.city});
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        street: json["street"], suite: json["suite"], city: json["city"]);
  }
}
