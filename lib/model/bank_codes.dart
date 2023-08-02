class BankCode {
  String name, code, ussd, logoUrl;
  BankCode(
      {required this.name,
      required this.code,
      required this.ussd,
      required this.logoUrl});

  factory BankCode.fromJson(Map<String, dynamic> json) {
    return BankCode(
        name: json["name"],
        code: json["code"],
        ussd: json["ussd"],
        logoUrl: json['logo']);
  }
}
