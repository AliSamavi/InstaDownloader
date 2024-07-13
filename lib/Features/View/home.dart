// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:InstaDownloader/Core/Constants/assets.dart';
import 'package:InstaDownloader/Core/Services/services.dart';
import 'package:InstaDownloader/Core/Utils/data_keeper.dart';
import 'package:InstaDownloader/Core/Widgets/video_card.dart';
import 'package:InstaDownloader/Features/Controller/downloaded_controller.dart';
import 'package:InstaDownloader/Features/View/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DownloadedController downloadedCtrl = Get.put(DownloadedController());
  TextEditingController textCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  late Map<String, dynamic> videoData;

  RxBool error = false.obs;
  RxBool loading = false.obs;
  ReceivePort port = ReceivePort();

  @override
  void initState() {
    IsolateNameServer.registerPortWithName(port.sendPort, "port");
    port.listen((dynamic data) {
      if (DownloadTaskStatus.fromInt(data[1]) == DownloadTaskStatus.complete) {
        downloadedCtrl.addVideo(
          url: videoData["url"],
          thumbnail: videoData["thumbnail"],
          video: videoData["video"],
        );
        loading.value = false;
      }
    });

    FlutterDownloader.registerCallback(callback);
    super.initState();
  }

  @override
  void dispose() {
    textCtrl.dispose();
    focusNode.dispose();
    port.close();
    Get.delete<DownloadedController>();
    super.dispose();
  }

  static void callback(String id, int status, int progress) {
    SendPort? send = IsolateNameServer.lookupPortByName("port");
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF140F2D),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Insta\nDownloader",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 6,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return TextField(
                            controller: textCtrl,
                            focusNode: focusNode,
                            readOnly: loading.value,
                            keyboardType: TextInputType.url,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Paste reels link here...",
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  Assets.link,
                                  colorFilter: ColorFilter.mode(
                                    Colors.grey.shade600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              error.value = false;
                            },
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Obx(() {
                        return GestureDetector(
                          onTap: loading.value ? null : onTap,
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF413DB5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: loading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2.5,
                                  )
                                : SvgPicture.asset(Assets.download),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Obx(() {
                  return Visibility(
                    visible: error.value,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Please enter a valid link",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          DraggableScrollableSheet(
            snap: true,
            maxChildSize: 0.95,
            minChildSize: 0.65,
            initialChildSize: 0.65,
            builder: (_, controller) {
              return ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                child: Container(
                  color: Colors.white,
                  child: GetX<DownloadedController>(
                    builder: (downloadedCtrl) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        controller: controller,
                        padding: const EdgeInsets.all(8),
                        itemCount: downloadedCtrl.reels.length,
                        itemBuilder: (_, index) {
                          final reel = downloadedCtrl.reels[index];
                          return VideoCard(
                            reel: reel,
                            index: index,
                            delete: () {
                              downloadedCtrl.deleteVideo(reel.key);
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void onTap() async {
    String text = textCtrl.text;
    textCtrl.clear();
    if (!text.startsWith("https://www.instagram.com/reel/")) {
      error.value = true;
    } else {
      focusNode.unfocus();
      loading.value = true;
      List<String> parts = text.replaceAll(" ", "").split("/");

      Directory directory =
          Directory("/storage/emulated/0/Download/InstaDownloader");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      File file = File("${directory.path}/${parts[4]}.mp4");
      if (await file.exists()) {
        snackBar("This reel has already been downloaded");
      } else {
        final data = await Services.get(
          "${parts[0]}//${parts[2]}/${parts[3]}/${parts[4]}?__a=1&__d=dis",
          DataKeeper().cookies,
        );
        if (data["error"] == "connection") {
          snackBar("Please check your connection");
        } else if (data["error"] == "login") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const LoginView(),
          ));
          loading.value = false;
        } else {
          Map<String, dynamic> reel = data["items"][0];
          final Directory? downloadsDir = await getDownloadsDirectory();
          await Dio().download(reel["image_versions2"]["candidates"][0]["url"],
              "${downloadsDir!.path}/${parts[4]}.jpg");
          videoData = {
            "url": text,
            "thumbnail": "${downloadsDir.path}/${parts[4]}.jpg",
            "video": file.path,
          };
          await FlutterDownloader.enqueue(
            url: reel["video_versions"][0]["url"],
            savedDir: directory.path,
            fileName: "${parts[4]}.mp4",
          );
        }
      }
    }
  }

  void snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Text(message),
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(30),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
    loading.value = false;
  }
}
