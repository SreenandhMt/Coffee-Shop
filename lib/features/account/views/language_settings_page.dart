import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../core/fonts.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  int selectedLanguageIndex = 0;
  List<Map<String, dynamic>> languages = [
    {
      "name": "English (US)",
      "url":
          "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1280px-Flag_of_the_United_States.svg.png"
    },
    {
      "name": "English (UK)",
      "url":
          "https://cdn.pixabay.com/photo/2015/11/06/13/29/union-jack-1027898_1280.jpg"
    },
    {
      "name": "Mandarin",
      "url":
          "https://media.istockphoto.com/id/1409691380/vector/national-flag-of-china.jpg?s=612x612&w=0&k=20&c=eZj7NFRw2cEdNkJ063WDDIYsa_42-bCGsVOw9upABPA="
    },
    {
      "name": "Spanish",
      "url":
          "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/1200px-Flag_of_Spain.svg.png"
    },
    {
      "name": "Hindi",
      "url":
          "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png"
    },
    {
      "name": "French",
      "url": "https://cdn.britannica.com/82/682-004-F0B47FCB/Flag-France.jpg"
    },
    {
      "name": "Arabic",
      "url":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/2560px-Flag_of_the_United_Arab_Emirates.svg.png"
    },
    {
      "name": "Russian",
      "url":
          "https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/1200px-Flag_of_Russia.svg.png"
    },
    {
      "name": "Japanese",
      "url":
          "https://wallpapers.com/images/hd/japan-flag-with-black-outline-hgww8s6h84z1fh1l.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleData.accountLanguageTitle.getString(context),
            style: appBarTitleFont),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              selectedLanguageIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: index == selectedLanguageIndex
                    ? Border.all(width: 2, color: AppColors.primaryColor)
                    : Border.all(width: 0.1)),
            child: Row(
              children: [
                Image.network(
                  languages[index]["url"],
                  width: 90,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                width20,
                Text(languages[index]["name"],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                if (index == selectedLanguageIndex) ...[
                  const Spacer(),
                  const Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
