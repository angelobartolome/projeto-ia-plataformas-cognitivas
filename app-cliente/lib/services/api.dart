import 'dart:io';

import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  Future<PredictApiResponse> submit({
    required String name,
    required String age,
    required String income,
    required String? gender,
    String modelId = "model2",
  }) async {
    const URL = "http://35.222.14.71/model";

    var response = await http.post(
      Uri.parse("$URL?model_id=$modelId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode([
        {
          "age": int.parse(age),
          "income": double.parse(income),
          "gender": gender == "Masculino"
              ? 0
              : gender == "Feminino"
                  ? 1
                  : 3,
        }
      ]),
    );

    return PredictApiResponse.fromJson(jsonDecode(response.body));
  }
}

class PredictApiResponse {
  String? status;
  Data? data;

  PredictApiResponse({this.status, this.data});

  PredictApiResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? status;
  List<double>? result;

  Data({this.status, this.result});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'].cast<double>();
  }
}
