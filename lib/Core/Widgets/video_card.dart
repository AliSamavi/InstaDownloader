import 'dart:io';

import 'package:InstaDownloader/Features/Model/downloaded_model.dart';
import 'package:InstaDownloader/Features/View/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class VideoCard extends StatefulWidget {
  const VideoCard(
      {super.key,
      required this.reel,
      required this.index,
      required this.delete});

  final DownloadedModel reel;
  final int index;
  final void Function() delete;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: FileImage(File(widget.reel.thumbnail)),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFBDBDBD),
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayerView(video: widget.reel.video),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade600.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: PopupMenuButton(
              color: Colors.grey.shade200,
              iconColor: Colors.white,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.grey.shade600.withOpacity(0.6),
                ),
                iconSize: const WidgetStatePropertyAll(20),
                minimumSize: const WidgetStatePropertyAll(
                  Size(15, 15),
                ),
              ),
              offset: widget.index % 2 == 0
                  ? const Offset(-125, 5)
                  : const Offset(-5, 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              onSelected: (value) async {
                switch (value) {
                  case 0:
                    await Clipboard.setData(
                        ClipboardData(text: widget.reel.url));
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
                          child: const Center(
                            child: Text("link copied to clipboard"),
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(30),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  case 1:
                    await Share.shareXFiles([XFile(widget.reel.video)]);
                  case 2:
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => deleteVideo(),
                    );
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Copy Link")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_rounded,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Share Video")
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red.shade800,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Delete Video")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Dialog deleteVideo() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: const Color(0xFFFBFCFC),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "This video will be deleted. Are you sure?",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF140F2D),
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB71C1C),
                      elevation: 2.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: widget.delete,
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
