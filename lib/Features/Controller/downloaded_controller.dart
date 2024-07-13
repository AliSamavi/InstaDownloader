import 'dart:io';

import 'package:InstaDownloader/Features/Model/downloaded_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DownloadedController extends GetxController {
  late Box<DownloadedModel> _box;

  final _reels = RxList<DownloadedModel>().obs;
  List<DownloadedModel> get reels => _reels.value;

  @override
  void onInit() async {
    _box = await Hive.openBox<DownloadedModel>("Downloaded");
    _reels.value.addAll(_box.values);
    super.onInit();
  }

  @override
  void onClose() async {
    await _box.close();
    super.onClose();
  }

  void addVideo(
      {required String url,
      required String thumbnail,
      required String video}) async {
    final data = DownloadedModel(
      url: url,
      thumbnail: thumbnail,
      video: video,
    );
    _reels.value.add(data);
    await _box.add(data);
  }

  void deleteVideo(int key) async {
    DownloadedModel? model = _box.get(key);
    await File(_reels.value[_reels.value.indexOf(model)].thumbnail).delete();
    await File(_reels.value[_reels.value.indexOf(model)].video).delete();
    _reels.value.remove(model);
    await _box.delete(key);
  }
}
