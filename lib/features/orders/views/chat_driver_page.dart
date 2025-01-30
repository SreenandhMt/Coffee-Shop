import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatDriverPage extends StatelessWidget {
  const ChatDriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reyford Chemail", style: appBarTitleFont),
        actions: [
          IconButton(
              onPressed: () => NavigationUtils.voiceCallDriverPage(context),
              icon: const Icon(Icons.call)),
          IconButton(
              onPressed: () => NavigationUtils.videoCallDriverPage(context),
              icon: const Icon(Icons.videocam_rounded)),
          width10,
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "I'm Reyford, I'll be right over and take your order. Please wait.. ⌛",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              height10,
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "09.00",
                              style: TextStyle(color: Colors.white),
                            ),
                            width5,
                            Icon(
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColor(context),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(10),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "I'm Reyford, I'll be right over and take your order. Please wait.. ⌛",
                                style: TextStyle(fontSize: 16),
                              ),
                              height10,
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "10.00",
                              style: TextStyle(),
                            ),
                            width5,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 16, color: AppColors.themeColor(context)),
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        prefixIcon: const Icon(Icons.emoji_emotions_outlined),
                        suffixIcon: const Icon(Icons.attach_file),
                        fillColor: AppColors.secondaryColor(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
