import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'entity_url.dart';
import 'hashtag.dart';
import 'mention.dart';

class Entity {
  final List<Hashtag>? hashtags;
  final List<EntityUrl>? urls;
  final List<Mention>? mentions;
  const Entity({
    this.hashtags,
    this.urls,
    this.mentions,
  });

  Entity copyWith({
    List<Hashtag>? hashtags,
    List<EntityUrl>? urls,
    List<Mention>? mentions,
  }) {
    return Entity(
      hashtags: hashtags ?? this.hashtags,
      urls: urls ?? this.urls,
      mentions: mentions ?? this.mentions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hashtags': hashtags?.map((x) => x.toMap()).toList(),
      'urls': urls?.map((x) => x.toMap()).toList(),
      'mentions': mentions?.map((x) => x.toMap()).toList(),
    };
  }

  factory Entity.fromMap(Map<String, dynamic> map) {
    final hashtags = map['hashtags'] != null
        ? List<Hashtag>.from(map['hashtags']?.map((x) => Hashtag.fromMap(x)))
        : null;
    final urls = map['urls'] != null
        ? List<EntityUrl>.from(map['urls']?.map((x) => EntityUrl.fromMap(x)))
        : null;
    final mentions = map['mentions'] != null
        ? List<Mention>.from(map['mentions']?.map((x) => Mention.fromMap(x)))
        : null;

    return Entity(
      hashtags: hashtags,
      urls: urls,
      mentions: mentions,
    );
  }

  String toJson() => json.encode(toMap());

  factory Entity.fromJson(String source) => Entity.fromMap(json.decode(source));

  @override
  String toString() =>
      'Entity(hashtags: $hashtags, urls: $urls, mentions: $mentions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entity &&
        listEquals(other.hashtags, hashtags) &&
        listEquals(other.urls, urls) &&
        listEquals(other.mentions, mentions);
  }

  @override
  int get hashCode => hashtags.hashCode ^ urls.hashCode ^ mentions.hashCode;
}
