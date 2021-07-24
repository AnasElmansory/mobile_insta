// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_metric.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PublicMetricsAdapter extends TypeAdapter<PublicMetrics> {
  @override
  final int typeId = 10;

  @override
  PublicMetrics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PublicMetrics(
      retweetCount: fields[0] as int?,
      replyCount: fields[1] as int?,
      likeCount: fields[2] as int?,
      quoteCount: fields[3] as int?,
      viewCount: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PublicMetrics obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.retweetCount)
      ..writeByte(1)
      ..write(obj.replyCount)
      ..writeByte(2)
      ..write(obj.likeCount)
      ..writeByte(3)
      ..write(obj.quoteCount)
      ..writeByte(4)
      ..write(obj.viewCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PublicMetricsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
