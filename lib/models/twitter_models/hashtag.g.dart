// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hashtag.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HashtagAdapter extends TypeAdapter<Hashtag> {
  @override
  final int typeId = 5;

  @override
  Hashtag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hashtag(
      start: fields[0] as int?,
      end: fields[1] as int?,
      tag: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hashtag obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.tag);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HashtagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
