import 'dart:convert';

import 'package:insta_news_mobile/models/source.dart';

import 'twitter_models/attachments.dart';
import 'twitter_models/entities.dart';
import 'twitter_models/media.dart';
import 'twitter_models/public_metric.dart';

class News {
  final String id;
  final String text;
  final String? authorId;
  final String? source;
  final List<Source>? users;
  final List<Media>? media;
  final String? lang;
  final Entity? entity;
  final PublicMetrics? publicMetrics;
  final Attachments? attachments;
  final DateTime createdAt;

  const News({
    required this.id,
    required this.text,
    required this.createdAt,
    this.users,
    this.entity,
    this.authorId,
    this.source,
    this.media,
    this.lang,
    this.publicMetrics,
    this.attachments,
  });

  News copyWith({
    String? id,
    String? text,
    String? authorId,
    String? source,
    List<Source>? users,
    List<Media>? media,
    String? lang,
    Entity? entity,
    PublicMetrics? publicMetrics,
    Attachments? attachments,
    DateTime? createdAt,
  }) {
    return News(
      id: id ?? this.id,
      text: text ?? this.text,
      authorId: authorId ?? this.authorId,
      source: source ?? this.source,
      media: media ?? this.media,
      users: users ?? this.users,
      entity: entity ?? this.entity,
      lang: lang ?? this.lang,
      publicMetrics: publicMetrics ?? this.publicMetrics,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author_id': authorId,
      'source': source,
      'media': media?.map((x) => x.toMap()).toList(),
      'users': users?.map((x) => x.toMap()).toList(),
      'entities': entity?.toMap(),
      'lang': lang,
      'public_metrics': publicMetrics?.toMap(),
      'attachments': attachments?.toMap(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    final attachments = map['attachments'] != null
        ? Attachments.fromMap(map['attachments'])
        : null;
    final entity =
        map['entities'] != null ? Entity.fromMap(map['entities']) : null;
    final publicMetrics = map['public_metrics'] != null
        ? PublicMetrics.fromMap(map['public_metrics'])
        : null;
    final users = map['users'] != null
        ? List<Source>.from(map['users']?.map((x) => Source.fromMap(x)))
        : null;
    return News(
      id: map['id'],
      text: map['text'],
      authorId: map['author_id'],
      source: map['source'],
      media: List<Media>.from(map['media']?.map((x) => Media.fromMap(x))),
      entity: entity,
      users: users,
      lang: map['lang'],
      publicMetrics: publicMetrics,
      attachments: attachments,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() {
    return 'News(id: $id, text: $text, author_id: $authorId, source: $source, media: $media, lang: $lang, public_metrics: $publicMetrics, attachments: $attachments, created_at: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is News &&
        other.id == id &&
        other.text == text &&
        other.authorId == authorId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        authorId.hashCode ^
        source.hashCode ^
        media.hashCode ^
        lang.hashCode ^
        publicMetrics.hashCode ^
        attachments.hashCode ^
        createdAt.hashCode;
  }
}
