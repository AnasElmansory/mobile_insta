import 'dart:convert';

import 'package:hive/hive.dart';
part 'mention.g.dart';

@HiveType(typeId: 7)
class Mention extends HiveObject {
  @HiveField(0)
  final int? start;
  @HiveField(1)
  final int? end;
  @HiveField(2)
  final String? username;
  Mention({
    this.start,
    this.end,
    this.username,
  });

  Mention copyWith({
    int? start,
    int? end,
    String? username,
  }) {
    return Mention(
      start: start ?? this.start,
      end: end ?? this.end,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'username': username,
    };
  }

  factory Mention.fromMap(Map<String, dynamic> map) {
    return Mention(
      start: map['start'],
      end: map['end'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Mention.fromJson(String source) =>
      Mention.fromMap(json.decode(source));

  @override
  String toString() => 'Mention(start: $start, end: $end, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Mention &&
        other.start == start &&
        other.end == end &&
        other.username == username;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ username.hashCode;
}
