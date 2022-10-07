import 'dart:convert';

import 'package:eshamba/services/auto_complete.dart';

class PlaceAutoCompleteResponsed {
  final String? status;
  final List<AutoCompletePrediction>? prediction;

  PlaceAutoCompleteResponsed({this.status, this.prediction});

  factory PlaceAutoCompleteResponsed.fromJson(Map<String, dynamic> json) {
    return PlaceAutoCompleteResponsed(
        status: json['status'] as String?,
        // ignore: prefer_null_aware_operators
        prediction: json['predictions'] != null
            ? json['predictions']
                .map<AutoCompletePrediction>(
                    (json) => AutoCompletePrediction.fromJson(json))
                .toList()
            : null);
  }

  static PlaceAutoCompleteResponsed parseAutoCompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return PlaceAutoCompleteResponsed.fromJson(parsed);
  }
}
