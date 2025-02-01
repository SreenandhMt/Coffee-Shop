import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/size.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({
    super.key,
    required this.title,
    required this.currentValue,
    required this.values,
    required this.onTap,
  });
  final String title;
  final Map<String, dynamic>? currentValue;
  final List<dynamic> values;
  final Function(Map<String, dynamic>, double, double?) onTap;

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  bool isHide = false;
  List<Map<String, dynamic>> mapValue = [];

  @override
  void initState() {
    for (var element in widget.values) {
      mapValue.add(element);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            width5,
            const Text("(Optional)", style: TextStyle(fontSize: 15)),
            const Spacer(),
            const Text("Max 1",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800)),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    isHide = !isHide;
                  });
                },
                icon: Icon(
                    isHide
                        ? Icons.keyboard_arrow_down_rounded
                        : Icons.keyboard_arrow_up_rounded,
                    color: AppColors.primaryColor))
          ],
        ),
        if (!isHide)
          ...List.generate(
            mapValue.length,
            (index) => Row(
              children: [
                Text(
                  mapValue[index]["name"],
                  style: const TextStyle(fontSize: 17),
                ),
                const Spacer(),
                Text("+ \$${mapValue[index]["price"]}",
                    style: const TextStyle(fontSize: 15)),
                Radio(
                  fillColor:
                      const WidgetStatePropertyAll(AppColors.primaryColor),
                  value: mapValue[index],
                  groupValue: widget.currentValue,
                  onChanged: (c) => widget.onTap(
                      c!,
                      double.parse(c["price"]),
                      widget.currentValue != null
                          ? double.parse(widget.currentValue!["price"])
                          : null),
                ),
              ],
            ),
          ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            thickness: 0.03,
          ),
        )
      ],
    );
  }
}
