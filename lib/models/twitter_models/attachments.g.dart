// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachments.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttachmentsAdapter extends TypeAdapter<Attachments> {
  @override
  final int typeId = 8;

  @override
  Attachments read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attachments(
      mediaKeys: (fields[0] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Attachments obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.mediaKeys);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttachmentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
