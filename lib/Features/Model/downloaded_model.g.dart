// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedModelAdapter extends TypeAdapter<DownloadedModel> {
  @override
  final int typeId = 1;

  @override
  DownloadedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedModel(
      url: fields[0] as String,
      thumbnail: fields[1] as String,
      video: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.thumbnail)
      ..writeByte(2)
      ..write(obj.video);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
