import 'dart:convert';

import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String email;
  final String provider;
  final String? name;
  final String? avatar;
  final String? permission;
  const User({
    required this.id,
    required this.email,
    required this.provider,
    this.name,
    this.avatar,
    this.permission,
  });

  factory User.guest() {
    return User(
      id: const Uuid().v1(),
      name: 'Guest',
      email: '',
      avatar: '',
      provider: 'guest',
      permission: 'none',
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? provider,
    String? name,
    String? avatar,
    String? permission,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'provider': provider,
      'name': name,
      'avatar': avatar,
      'permission': permission,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      provider: map['provider'],
      name: map['name'],
      avatar: map['avatar'],
      permission: map['permission'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, email: $email, provider: $provider, name: $name, avatar: $avatar, permission: $permission)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.provider == provider &&
        other.name == name &&
        other.avatar == avatar &&
        other.permission == permission;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        provider.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        permission.hashCode;
  }
}
