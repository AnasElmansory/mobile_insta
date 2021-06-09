import 'dart:convert';

import 'package:hive/hive.dart';
part 'source.g.dart';

@HiveType(typeId: 1)
class Source extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? url;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String? location;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final String? profileImageUrl;
  @HiveField(7)
  final bool? verified;
  @HiveField(8)
  final DateTime? createdAt;
  Source({
    required this.id,
    required this.name,
    required this.username,
    this.url,
    this.location,
    this.description,
    this.profileImageUrl,
    this.verified,
    this.createdAt,
  });

  Source copyWith({
    String? id,
    String? url,
    String? username,
    String? name,
    String? location,
    String? description,
    String? profileImageUrl,
    bool? verified,
    DateTime? createdAt,
  }) {
    return Source(
      id: id ?? this.id,
      url: url ?? this.url,
      username: username ?? this.username,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'username': username,
      'name': name,
      'location': location,
      'description': description,
      'profile_image_url': profileImageUrl,
      'verified': verified,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    final createdAt =
        map['created_at'] != null ? DateTime.parse(map['created_at']) : null;
    return Source(
      id: map['id'],
      url: map['url'],
      username: map['username'],
      name: map['name'],
      location: map['location'],
      description: map['description'],
      profileImageUrl: map['profile_image_url'],
      verified: map['verified'],
      createdAt: createdAt,
    );
  }
  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Source(id: $id, url: $url, username: $username, name: $name, location: $location, description: $description, profileImageUrl: $profileImageUrl, verified: $verified, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Source &&
        other.id == id &&
        other.url == url &&
        other.username == username &&
        other.name == name &&
        other.location == location &&
        other.description == description &&
        other.profileImageUrl == profileImageUrl &&
        other.verified == verified &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        url.hashCode ^
        username.hashCode ^
        name.hashCode ^
        location.hashCode ^
        description.hashCode ^
        profileImageUrl.hashCode ^
        verified.hashCode ^
        createdAt.hashCode;
  }
}
