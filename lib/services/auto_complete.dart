import 'package:google_maps_webservice/places.dart';

class AutoCompletePrediction {
  final String? description;

  final StructuredFormatting? structuredFormatting;

  final String? placeID;

  final String? reference;

  AutoCompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeID,
    this.reference,
  });

  factory AutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutoCompletePrediction(
        description: json['description'] as String?,
        placeID: json['place_id'] as String?,
        reference: json['reference'] as String?,
        structuredFormatting: json['structured_formatting'] != null
            ? StructuredFormatting.fromJson(json['structured_formatting'])
            : null);
  }
}
