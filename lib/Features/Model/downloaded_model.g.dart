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
      instagramUrl: fields[0] as String,
      downloadUrl: fields[1] as String,
      thumbnailUrl: fields[2] as String,
      videoPath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.instagramUrl)
      ..writeByte(1)
      ..write(obj.downloadUrl)
      ..writeByte(2)
      ..write(obj.thumbnailUrl)
      ..writeByte(3)
      ..write(obj.videoPath);
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
