import 'dart:convert';

import 'package:hive/hive.dart';

import 'public_metric.dart';
import '../../utils/extentions.dart';
part 'media.g.dart';

@HiveType(typeId: 9)
class Media extends HiveObject {
  @HiveField(0)
  final PublicMetrics? publicMetric;
  @HiveField(1)
  final int? height;
  @HiveField(2)
  final int? width;
  @HiveField(3)
  final String? url;
  @HiveField(4)
  final String? mediaKey;
  @HiveField(5)
  final MediaType? type;
  @HiveField(6)
  final String? previewImageUrl;
  @HiveField(7)
  final Duration? durationMs;
  Media({
    this.publicMetric,
    this.height,
    this.width,
    this.url,
    this.mediaKey,
    this.type,
    this.previewImageUrl,
    this.durationMs,
  });

  Media copyWith({
    PublicMetrics? publicMetric,
    int? height,
    int? width,
    String? url,
    String? mediaKey,
    MediaType? type,
    String? previewImageUrl,
    Duration? durationMs,
  }) {
    return Media(
      publicMetric: publicMetric ?? this.publicMetric,
      height: height ?? this.height,
      width: width ?? this.width,
      mediaKey: mediaKey ?? this.mediaKey,
      url: url ?? this.url,
      type: type ?? this.type,
      previewImageUrl: previewImageUrl ?? this.previewImageUrl,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'public_metric': publicMetric?.toMap(),
      'height': height,
      'width': width,
      'media_key': mediaKey,
      'url': url,
      'type': type?.typeToString(),
      'preview_image_url': previewImageUrl,
      'duration_ms': durationMs?.inMilliseconds,
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    final type = typeFromString(map['type']);
    final duration = map['duration_ms'] != null
        ? Duration(milliseconds: map['duration_ms'])
        : null;
    final publicMetrics = map['public_metrics'] != null
        ? PublicMetrics.fromMap(map['public_metrics'])
        : null;
    return Media(
      publicMetric: publicMetrics,
      height: map['height'],
      width: map['width'],
      url: map['url'],
      mediaKey: map['media_key'],
      type: type,
      previewImageUrl: map['preview_image_url'],
      durationMs: duration,
    );
  }

  String toJson() => json.encode(toMap());

  factory Media.fromJson(String source) => Media.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Media(publicMetric: $publicMetric, height: $height, width: $width, mediaKey: $mediaKey, type: $type, preview_image_url: $previewImageUrl, durationMs: $durationMs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Media &&
        other.publicMetric == publicMetric &&
        other.height == height &&
        other.width == width &&
        other.mediaKey == mediaKey &&
        other.type == type &&
        other.previewImageUrl == previewImageUrl &&
        other.durationMs == durationMs;
  }

  @override
  int get hashCode {
    return publicMetric.hashCode ^
        height.hashCode ^
        width.hashCode ^
        mediaKey.hashCode ^
        type.hashCode ^
        previewImageUrl.hashCode ^
        durationMs.hashCode;
  }
}

@HiveType(typeId: 13)
enum MediaType {
  @HiveField(0)
  video,
  @HiveField(1)
  photo,
  @HiveField(2)
  gif,
}

MediaType? typeFromString(String type) {
  if (type == 'video') {
    return MediaType.video;
  } else if (type == 'photo') {
    return MediaType.photo;
  } else if (type == 'animated_gif') return MediaType.gif;
}
