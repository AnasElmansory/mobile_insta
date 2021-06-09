import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'country.g.dart';

@HiveType(typeId: 2)
class Country extends HiveObject {
  @HiveField(0)
  final String countryName;
  @HiveField(1)
  final String? countryCode;
  @HiveField(2)
  final List<String> countryAliases;
  Country({
    required this.countryName,
    required this.countryAliases,
    this.countryCode,
  });

  Country copyWith({
    String? countryName,
    String? countryCode,
    List<String>? countryAliases,
  }) {
    return Country(
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      countryAliases: countryAliases ?? this.countryAliases,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryName': countryName,
      'countryCode': countryCode,
      'countryAliases': countryAliases,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    final countryName = map['countryName'] as String;
    final aliases = map['countryAliases'] == null
        ? [countryName]
        : List<String>.from(map['countryAliases']);
    if (!aliases.contains(countryName)) aliases.add(countryName);
    return Country(
      countryName: map['countryName'],
      countryCode: map['countryCode'],
      countryAliases: aliases,
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) =>
      Country.fromMap(json.decode(source));

  @override
  String toString() =>
      'Country(countryName: $countryName, countryCode: $countryCode, countryAliases: $countryAliases)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country &&
        other.countryName == countryName &&
        other.countryCode == countryCode &&
        listEquals(other.countryAliases, countryAliases);
  }

  @override
  int get hashCode =>
      countryName.hashCode ^ countryCode.hashCode ^ countryAliases.hashCode;
}
