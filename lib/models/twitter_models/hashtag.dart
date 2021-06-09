import 'dart:convert';

class Hashtag {
  final int? start;
  final int? end;
  final String? tag;
  const Hashtag({
    this.start,
    this.end,
    this.tag,
  });

  Hashtag copyWith({
    int? start,
    int? end,
    String? tag,
  }) {
    return Hashtag(
      start: start ?? this.start,
      end: end ?? this.end,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'tag': tag,
    };
  }

  factory Hashtag.fromMap(Map<String, dynamic> map) {
    return Hashtag(
      start: map['start'],
      end: map['end'],
      tag: map['tag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Hashtag.fromJson(String source) =>
      Hashtag.fromMap(json.decode(source));

  @override
  String toString() => 'Hashtag(start: $start, end: $end, tag: $tag)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hashtag &&
        other.start == start &&
        other.end == end &&
        other.tag == tag;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ tag.hashCode;
}
