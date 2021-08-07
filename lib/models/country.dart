import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'country_source.dart';
import 'model.dart';

part 'country.g.dart';

@HiveType(typeId: 21)
class Country extends HiveObject implements Model {
  @HiveField(0)
  final String countryName;
  @HiveField(1)
  final String countryNameAr;
  @HiveField(2)
  final String? countryCode;
  @HiveField(3)
  final List<CountrySource> sources;
  Country({
    required this.countryName,
    required this.countryNameAr,
    this.countryCode,
    required this.sources,
  });

  Country copyWith({
    String? countryName,
    String? countryNameAr,
    String? countryCode,
    List<CountrySource>? sources,
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
      'sources': sources.map((x) => x.toMap()).toList(),
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      countryName: map['countryName'],
      countryNameAr: map['countryNameAr'],
      countryCode: map['countryCode'],
      sources: List<CountrySource>.from(
          map['sources']?.map((x) => CountrySource.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(countryName: $countryName, countryNameAr: $countryNameAr, countryCode: $countryCode, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.countryName == countryName &&
        other.countryNameAr == countryNameAr &&
        other.countryCode == countryCode &&
        listEquals(other.sources, sources);
  }

  @override
  int get hashCode {
    return countryName.hashCode ^
        countryNameAr.hashCode ^
        countryCode.hashCode ^
        sources.hashCode;
  }
}
