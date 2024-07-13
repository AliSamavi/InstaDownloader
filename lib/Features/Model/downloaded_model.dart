import 'package:hive/hive.dart';

part 'downloaded_model.g.dart';

@HiveType(typeId: 1)
class DownloadedModel extends HiveObject {
  @HiveField(0)
  String url;
  @HiveField(1)
  String thumbnail;
  @HiveField(2)
  String video;

  DownloadedModel({
    required this.url,
    required this.thumbnail,
    required this.video,
  });
}
