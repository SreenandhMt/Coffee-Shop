import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PointRewardPage extends StatefulWidget {
  const PointRewardPage({super.key});

  @override
  State<PointRewardPage> createState() => _PointRewardPageState();
}

class _PointRewardPageState extends State<PointRewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZsy7A2C7fKO0PkIHpoz58JT0B9EiQlKfSyQ&s",
                    ),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
          height20,
          const Text(
            "Congratulations!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          height10,
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "You earn 25 points from this order. You can see the points on the Caffely Points menu.",
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          AuthButton(
              text: "OK",
              onPressed: () {
                NavigationUtils.userResponsePage(context);
              })
        ],
      ),
    );
  }
}
