import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'model.dart';
part 'country.g.dart';

@HiveType(typeId: 2)
class Country extends HiveObject implements Model {
  @HiveField(0)
  final String countryName;
  @HiveField(1)
  final String countryNameAr;
  @HiveField(2)
  final String? countryCode;
  @HiveField(3)
  final List<String> sources;
  Country({
    required this.countryName,
    required this.countryNameAr,
    required this.sources,
    this.countryCode,
  });

  Country copyWith({
    String? countryName,
    String? countryNameAr,
    String? countryCode,
    List<String>? sources,
  }) {
    return Country(
      countryName: countryName ?? this.countryName,
      countryNameAr: countryNameAr ?? this.countryNameAr,
      countryCode: countryCode ?? this.countryCode,
      sources: sources ?? this.sources,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryName': countryName,
      'countryNameAr': countryNameAr,
      'countryCode': countryCode,
      'sources': sources,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    final aliases = map['sources'] == null
        ? const <String>[]
        : List<String>.from(map['sources']);

    return Country(
      countryName: map['countryName'],
      countryNameAr: map['countryNameAr'],
      countryCode: map['countryCode'],
      sources: aliases,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() =>
      'Country(countryName: $countryName, countryCode: $countryCode, sources: $sources)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.countryName == countryName &&
        other.countryCode == countryCode &&
        listEquals(other.sources, sources);
  }

  @override
  int get hashCode =>
      countryName.hashCode ^ countryCode.hashCode ^ sources.hashCode;
}
