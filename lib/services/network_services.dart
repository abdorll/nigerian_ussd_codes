// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ussd_bank_codes/model/bank_codes.dart';
import 'package:ussd_bank_codes/model/network_model.dart';

String jsonPath({required String jsonName}) {
  return "assets/data/$jsonName.json";
}

class InvokeJSON {
  static Future<List<NetworkModel>> networkCodes(
    BuildContext context,
  ) async {
    var rawData = await DefaultAssetBundle.of(context)
        .loadString(jsonPath(jsonName: "netwok_codes"));
    Map<String, dynamic> fineData = await jsonDecode(rawData);
    List<dynamic> networkData = fineData["ussd"];
    List<NetworkModel> dataList = networkData.map((data) {
      return NetworkModel.fromJson(json: data);
    }).toList();
    // print(dataList);

    return dataList;
  }

  static Future<List<BankCode>> bankCodes(BuildContext context) async {
    var rawData = await DefaultAssetBundle.of(context)
        .loadString(jsonPath(jsonName: "nigerian_banks"));
    List<dynamic> jsonData = await jsonDecode(rawData);
    List<BankCode> finalData =
        jsonData.map((e) => BankCode.fromJson(e)).toList();

    // print(finalData);
    return finalData;
  }
}
