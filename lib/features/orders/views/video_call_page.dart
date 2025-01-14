import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/size.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.amber),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            foregroundColor: AppColors.backgroundColor(context),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  height: 200,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 35,
                    child: Icon(Icons.call_end_rounded),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: 35,
                    child: const Icon(Icons.videocam_rounded),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: 35,
                    child: const Icon(Icons.volume_up_rounded),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: 35,
                    child: const Icon(Icons.mic_none_rounded),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
