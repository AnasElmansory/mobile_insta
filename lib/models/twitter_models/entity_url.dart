import 'dart:convert';

class EntityUrl {
  final int? start;
  final int? end;
  final String? url;
  final String? displayUrl;
  final String? expandedUrl;

  const EntityUrl({
    this.start,
    this.end,
    this.url,
    this.displayUrl,
    this.expandedUrl,
  });

  EntityUrl copyWith({
    int? start,
    int? end,
    String? url,
    String? displayUrl,
    String? expandedUrl,
  }) {
    return EntityUrl(
      start: start ?? this.start,
      end: end ?? this.end,
      url: url ?? this.url,
      displayUrl: displayUrl ?? this.displayUrl,
      expandedUrl: expandedUrl ?? this.expandedUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'url': url,
      'display_url': displayUrl,
      'expanded_url': expandedUrl,
    };
  }

  factory EntityUrl.fromMap(Map<String, dynamic> map) {
    return EntityUrl(
      start: map['start'],
      end: map['end'],
      url: map['url'],
      displayUrl: map['display_url'],
      expandedUrl: map['expanded_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EntityUrl.fromJson(String source) =>
      EntityUrl.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EntityUrl(start: $start, end: $end, url: $url, displayUrl: $displayUrl, expandedUrl: $expandedUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EntityUrl &&
        other.start == start &&
        other.end == end &&
        other.url == url &&
        other.displayUrl == displayUrl &&
        other.expandedUrl == expandedUrl;
  }

  @override
  int get hashCode {
    return start.hashCode ^
        end.hashCode ^
        url.hashCode ^
        displayUrl.hashCode ^
        expandedUrl.hashCode;
  }
}
