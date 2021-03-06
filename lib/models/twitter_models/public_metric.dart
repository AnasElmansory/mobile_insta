import 'dart:convert';

import 'package:hive/hive.dart';
part 'public_metric.g.dart';

@HiveType(typeId: 10)
class PublicMetrics extends HiveObject {
  @HiveField(0)
  final int? retweetCount;
  @HiveField(1)
  final int? replyCount;
  @HiveField(2)
  final int? likeCount;
  @HiveField(3)
  final int? quoteCount;
  @HiveField(4)
  final int? viewCount;

  PublicMetrics({
    this.retweetCount,
    this.replyCount,
    this.likeCount,
    this.quoteCount,
    this.viewCount,
  });

  PublicMetrics copyWith({
    int? retweetCount,
    int? replyCount,
    int? likeCount,
    int? quoteCount,
    int? viewCount,
  }) {
    return PublicMetrics(
      retweetCount: retweetCount ?? this.retweetCount,
      replyCount: replyCount ?? this.replyCount,
      likeCount: likeCount ?? this.likeCount,
      quoteCount: quoteCount ?? this.quoteCount,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'retweet_count': retweetCount,
      'reply_count': replyCount,
      'like_count': likeCount,
      'quote_count': quoteCount,
      'view_count': viewCount,
    };
  }

  factory PublicMetrics.fromMap(Map<String, dynamic> map) {
    return PublicMetrics(
      retweetCount: map['retweet_count'],
      replyCount: map['reply_count'],
      likeCount: map['like_count'],
      quoteCount: map['quote_count'],
      viewCount: map['view_count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PublicMetrics.fromJson(String source) =>
      PublicMetrics.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PublicMetric(retweetCount: $retweetCount, replyCount: $replyCount, likeCount: $likeCount, quoteCount: $quoteCount, viewCount: $viewCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PublicMetrics &&
        other.retweetCount == retweetCount &&
        other.replyCount == replyCount &&
        other.likeCount == likeCount &&
        other.quoteCount == quoteCount &&
        other.viewCount == viewCount;
  }

  @override
  int get hashCode {
    return retweetCount.hashCode ^
        replyCount.hashCode ^
        likeCount.hashCode ^
        quoteCount.hashCode ^
        viewCount.hashCode;
  }
}
