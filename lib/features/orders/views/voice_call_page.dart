import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key});

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueAccent,
        Colors.blueGrey,
        Colors.pink,
        Colors.deepOrange
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
