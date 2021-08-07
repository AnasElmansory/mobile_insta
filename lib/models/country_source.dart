import 'dart:convert';

import 'package:hive/hive.dart';

part 'country_source.g.dart';

@HiveType(typeId: 20)
class CountrySource extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  CountrySource({
    required this.id,
    required this.name,
  });

  CountrySource copyWith({
    String? id,
    String? name,
  }) {
    return CountrySource(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CountrySource.fromMap(Map<String, dynamic> map) {
    return CountrySource(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CountrySource.fromJson(String source) =>
      CountrySource.fromMap(json.decode(source));

  @override
  String toString() => 'CountrySource(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountrySource && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
