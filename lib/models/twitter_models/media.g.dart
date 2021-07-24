// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaTypeAdapter extends TypeAdapter<MediaType> {
  @override
  final int typeId = 13;

  @override
  MediaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MediaType.video;
      case 1:
        return MediaType.photo;
      case 2:
        return MediaType.gif;
      default:
        return MediaType.video;
    }
  }

  @override
  void write(BinaryWriter writer, MediaType obj) {
    switch (obj) {
      case MediaType.video:
        writer.writeByte(0);
        break;
      case MediaType.photo:
        writer.writeByte(1);
        break;
      case MediaType.gif:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MediaAdapter extends TypeAdapter<Media> {
  @override
  final int typeId = 9;

  @override
  Media read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Media(
      publicMetric: fields[0] as PublicMetrics?,
      height: fields[1] as int?,
      width: fields[2] as int?,
      url: fields[3] as String?,
      mediaKey: fields[4] as String?,
      type: fields[5] as MediaType?,
      previewImageUrl: fields[6] as String?,
      durationMs: fields[7] as Duration?,
    );
  }

  @override
  void write(BinaryWriter writer, Media obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.publicMetric)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.width)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.mediaKey)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.previewImageUrl)
      ..writeByte(7)
      ..write(obj.durationMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
