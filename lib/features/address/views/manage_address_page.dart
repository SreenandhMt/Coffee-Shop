import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  final List<Map<String, dynamic>> address = [
    {
      "title": "Home",
      "name": "Andrew Ainsley",
      "number": "+1 111 467 378 399",
      "address": "701 7th Ave, New York, NY 10036, USA",
      "pin": true,
      "select": true
    },
    {
      "title": "Apartment",
      "name": "Andrew Ainsley",
      "number": "+1 111 467 378 399",
      "address": "Liberty Lsland, New York, NY 10036, USA",
      "pin": true,
      "select": false
    },
    {
      "title": "Mom's House",
      "name": "Jenny Wilson",
      "number": "+1 111 467 378 399",
      "address": "Central Park, New York, NY 10036, USA",
      "pin": true,
      "select": false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => NavigationUtils.addNewAddressPage(context),
              icon: const Icon(Icons.add)),
          width10
        ],
        title: Text("Saved Address", style: appBarTitleFont),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: address.length,
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.secondaryColor(context))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        address[index]["title"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      if (address[index]["select"]) ...[
                        width20,
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          child: const Text(
                            "Main Address",
                            style: TextStyle(
                                fontSize: 10, color: AppColors.primaryColor),
                          ),
                        ),
                      ],
                      const Spacer(),
                      const Icon(Icons.share_outlined)
                    ],
                  ),
                  height30,
                  Row(
                    children: [
                      Text(address[index]["name"],
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700)),
                      width20,
                      Text("(${address[index]['number']})")
                    ],
                  ),
                  height10,
                  Row(
                    children: [
                      Text(address[index]["address"]),
                      if (address[index]["select"]) ...[
                        const Spacer(),
                        const Icon(Icons.done)
                      ]
                    ],
                  ),
                  height10,
                  const Row(
                    children: [
                      Icon(Icons.location_on_rounded),
                      Text("Pinpoint already")
                    ],
                  ),
                  height10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 1.5)),
                          child: const Text(
                            "Change Address",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      if (!address[index]["select"]) ...[
                        width10,
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  for (var element in address) {
                                    element["select"] = false;
                                  }
                                  address[index]["select"] = true;
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 25),
                                  width10,
                                  Text(
                                    "Set As Primary Address",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  address.removeAt(index);
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.red,
                                  ),
                                  width10,
                                  Text(
                                    "Delete Address",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          ],
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 1.5)),
                            child: const Icon(Icons.more_vert),
                          ),
                        )
                      ],
                    ],
                  )
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
