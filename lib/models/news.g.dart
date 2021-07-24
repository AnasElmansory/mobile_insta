// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 3;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      id: fields[0] as String,
      text: fields[1] as String,
      createdAt: fields[8] as DateTime,
      users: (fields[9] as List).cast<Source>(),
      media: (fields[10] as List).cast<Media>(),
      referencedTweets: (fields[11] as List).cast<ReferencedTweet>(),
      referencedTweetObjects: (fields[12] as List).cast<News>(),
      entity: fields[5] as Entity?,
      authorId: fields[2] as String?,
      source: fields[3] as String?,
      lang: fields[4] as String?,
      publicMetrics: fields[6] as PublicMetrics?,
      attachments: fields[7] as Attachments?,
    );
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.authorId)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.lang)
      ..writeByte(5)
      ..write(obj.entity)
      ..writeByte(6)
      ..write(obj.publicMetrics)
      ..writeByte(7)
      ..write(obj.attachments)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.users)
      ..writeByte(10)
      ..write(obj.media)
      ..writeByte(11)
      ..write(obj.referencedTweets)
      ..writeByte(12)
      ..write(obj.referencedTweetObjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
