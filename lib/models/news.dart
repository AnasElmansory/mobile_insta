import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:insta_news_mobile/models/model.dart';
import 'package:insta_news_mobile/models/source.dart';
import 'package:insta_news_mobile/models/twitter_models/referenced_tweets.dart';

import 'twitter_models/attachments.dart';
import 'twitter_models/entities.dart';
import 'twitter_models/media.dart';
import 'twitter_models/public_metric.dart';

part 'news.g.dart';

abstract class FavoriteNews extends Model {
  const FavoriteNews();
}

@HiveType(typeId: 3)
class News extends HiveObject implements Model, FavoriteNews {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final String? authorId;
  @HiveField(3)
  final String? source;
  @HiveField(4)
  final String? lang;
  @HiveField(5)
  final Entity? entity;
  @HiveField(6)
  final PublicMetrics? publicMetrics;
  @HiveField(7)
  final Attachments? attachments;
  @HiveField(8)
  final DateTime createdAt;
  @HiveField(9)
  final List<Source> users;
  @HiveField(10)
  final List<Media> media;
  @HiveField(11)
  final List<ReferencedTweet> referencedTweets;
  @HiveField(12)
  final List<News> referencedTweetObjects;

  News({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.users,
    required this.media,
    required this.referencedTweets,
    required this.referencedTweetObjects,
    this.entity,
    this.authorId,
    this.source,
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
    List<ReferencedTweet>? referencedTweets,
    List<News>? referencedTweetObjects,
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
      referencedTweets: referencedTweets ?? this.referencedTweets,
      referencedTweetObjects:
          referencedTweetObjects ?? this.referencedTweetObjects,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author_id': authorId,
      'source': source,
      'media': media.map((x) => x.toMap()).toList(),
      'users': users.map((x) => x.toMap()).toList(),
      'entities': entity?.toMap(),
      'lang': lang,
      'public_metrics': publicMetrics?.toMap(),
      'attachments': attachments?.toMap(),
      'created_at': createdAt.toIso8601String(),
      'referenced_tweets': referencedTweets.map((x) => x.toMap()),
      'referenced_tweet_objects': referencedTweetObjects.map((x) => x.toMap()),
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    final media = map['media'] != null
        ? List<Media>.from(map['media'].map((x) => Media.fromMap(x)))
        : const <Media>[];

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
        : const <Source>[];
    final referencedTweet = map['referenced_tweets'] != null
        ? List<ReferencedTweet>.from(
                map['referenced_tweets'].map((x) => ReferencedTweet.fromMap(x)))
            .toList()
        : const <ReferencedTweet>[];
    final referencedTweetObjects = map['referenced_tweet_objects'] != null
        ? List<News>.from(
                map['referenced_tweet_objects'].map((x) => News.fromMap(x)))
            .toList()
        : const <News>[];
    return News(
      id: map['id'],
      text: map['text'],
      authorId: map['author_id'],
      source: map['source'],
      media: media,
      entity: entity,
      users: users,
      lang: map['lang'],
      publicMetrics: publicMetrics,
      attachments: attachments,
      createdAt: DateTime.parse(map['created_at']),
      referencedTweets: referencedTweet,
      referencedTweetObjects: referencedTweetObjects,
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

const referencedTweetTypes = ['retweet', 'reply_to', 'quoted'];
