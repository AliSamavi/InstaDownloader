import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Insta",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Downloader",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Paste post link here...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          "assets/icons/link.svg",
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
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment(0, -1),
                        end: Alignment(0, 1),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 5,
                          offset: Offset(0, -2.5),
                        ),
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 5,
                          offset: Offset(0, 2.5),
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/download.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF140F2D),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
