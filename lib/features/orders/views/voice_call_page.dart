import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoiceCallPage extends StatelessWidget {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueAccent,
        Color.fromARGB(255, 53, 101, 184),
        Color.fromARGB(255, 53, 101, 184),
        Color.fromARGB(255, 109, 57, 102),
        Color.fromARGB(255, 205, 79, 40)
      ], begin: Alignment.topCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            foregroundColor: AppColors.backgroundColor(context),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black,
                ),
                height15,
                Text(
                  "Rayford Chemail",
                  style: TextStyle(
                      color: AppColors.backgroundColor(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                height10,
                Text(
                  "10:05s",
                  style: TextStyle(color: AppColors.backgroundColor(context)),
                )
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 35,
                  child: Icon(Icons.call_end_rounded),
                ),
                width15,
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  radius: 35,
                  child: const Icon(Icons.volume_up_rounded),
                ),
                width15,
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.5),
                  radius: 35,
                  child: const Icon(Icons.mic_none_rounded),
                )
              ],
            ),
            height20,
          ],
        ),
      ),
    );
  }
}
