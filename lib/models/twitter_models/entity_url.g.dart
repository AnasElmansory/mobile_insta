// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntityUrlAdapter extends TypeAdapter<EntityUrl> {
  @override
  final int typeId = 6;

  @override
  EntityUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntityUrl(
      start: fields[0] as int?,
      end: fields[1] as int?,
      url: fields[2] as String?,
      displayUrl: fields[3] as String?,
      expandedUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EntityUrl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.displayUrl)
      ..writeByte(4)
      ..write(obj.expandedUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntityUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
