import 'dart:convert';

import 'package:flutter/foundation.dart';

class Attachments {
  final List<String>? mediaKeys;

  const Attachments({this.mediaKeys});

  Attachments copyWith({
    List<String>? mediaKeys,
  }) {
    return Attachments(
      mediaKeys: mediaKeys ?? this.mediaKeys,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'media_keys': mediaKeys,
    };
  }

  factory Attachments.fromMap(Map<String, dynamic> map) {
    return Attachments(
      mediaKeys: List<String>.from(map['media_keys']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachments.fromJson(String source) =>
      Attachments.fromMap(json.decode(source));

  @override
  String toString() => 'Attachments(mediaKeys: $mediaKeys)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attachments && listEquals(other.mediaKeys, mediaKeys);
  }

  @override
  int get hashCode => mediaKeys.hashCode;
}
