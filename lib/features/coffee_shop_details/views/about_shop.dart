import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

class AboutShopPage extends StatefulWidget {
  const AboutShopPage({super.key});

  @override
  State<AboutShopPage> createState() => _AboutShopPageState();
}

class _AboutShopPageState extends State<AboutShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child:
                Text("Caffely Astoria Aromas", style: titleFonts(fontSize: 25)),
          ),
          height15,
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              "About",
              style: titleFonts(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "Welcome to Caffely Astoria Aromas, a coffee haven nestled in the heart of the vibrant Astoria neighborhood. Our branch is a testament to the fusion of aromatic coffees. community warmth, and urban energy. Step inside and immerse yourself in an atmosphere where every sip tells a story and every visit is a memorable journey.",
              style: subtitleFont(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          height20,
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text("Monday - Friday       : 10:00 - 22.00",
                style: titleFonts(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text("Saturday - Sunday   : 12:00 - 20.00",
                style: titleFonts(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          height20,
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              "Address",
              style: titleFonts(fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.location_on_rounded, color: Colors.green),
                width10,
                Text(
                  "350 5th Ave, New York, NY 10118, USA",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 250,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                    image: AssetImage("assets/location.png"))),
          )
        ],
      ),
    );
  }
}
