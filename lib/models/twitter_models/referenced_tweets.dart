import 'dart:convert';

import 'package:hive/hive.dart';
part 'referenced_tweets.g.dart';

@HiveType(typeId: 11)
class ReferencedTweet extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;

  ReferencedTweet({
    required this.id,
    required this.type,
  });

  ReferencedTweet copyWith({
    String? id,
    String? type,
  }) {
    return ReferencedTweet(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
    };
  }

  factory ReferencedTweet.fromMap(Map<String, dynamic> map) {
    return ReferencedTweet(
      id: map['id'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferencedTweet.fromJson(String source) =>
      ReferencedTweet.fromMap(json.decode(source));

  @override
  String toString() => 'ReferencedTweet(id: $id, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReferencedTweet && other.id == id && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
