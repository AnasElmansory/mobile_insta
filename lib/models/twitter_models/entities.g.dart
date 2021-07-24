// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntityAdapter extends TypeAdapter<Entity> {
  @override
  final int typeId = 4;

  @override
  Entity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entity(
      hashtags: (fields[0] as List?)?.cast<Hashtag>(),
      urls: (fields[1] as List?)?.cast<EntityUrl>(),
      mentions: (fields[2] as List?)?.cast<Mention>(),
    );
  }

  @override
  void write(BinaryWriter writer, Entity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.hashtags)
      ..writeByte(1)
      ..write(obj.urls)
      ..writeByte(2)
      ..write(obj.mentions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
