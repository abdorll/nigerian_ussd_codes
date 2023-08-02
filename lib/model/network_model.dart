class NetworkModel {
  String code, description;
  NetworkModel({required this.code, required this.description});

  factory NetworkModel.fromJson({required Map<String, dynamic> json}) {
    return NetworkModel(code: json["code"]??'code', description: json["description"]??'code');
  }
}
