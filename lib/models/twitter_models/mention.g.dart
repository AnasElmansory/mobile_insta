// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MentionAdapter extends TypeAdapter<Mention> {
  @override
  final int typeId = 7;

  @override
  Mention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mention(
      start: fields[0] as int?,
      end: fields[1] as int?,
      username: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Mention obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.start)
      ..writeByte(1)
      ..write(obj.end)
      ..writeByte(2)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
