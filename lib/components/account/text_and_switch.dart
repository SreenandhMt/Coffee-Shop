import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWithSwitch extends StatefulWidget {
  const TextWithSwitch({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<TextWithSwitch> createState() => _TextWithSwitchState();
}

class _TextWithSwitchState extends State<TextWithSwitch> {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            onChanged: (value) {
              setState(() {
                this.value = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
