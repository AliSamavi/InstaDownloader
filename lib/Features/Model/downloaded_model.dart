import 'package:hive/hive.dart';

part 'downloaded_model.g.dart';

@HiveType(typeId: 1)
class DownloadedModel extends HiveObject {
  @HiveField(0)
  String instagramUrl;
  @HiveField(1)
  String downloadUrl;
  @HiveField(2)
  String thumbnailUrl;
  @HiveField(3)
  String videoPath;

  DownloadedModel({
    required this.instagramUrl,
    required this.downloadUrl,
    required this.thumbnailUrl,
    required this.videoPath,
  });
}
