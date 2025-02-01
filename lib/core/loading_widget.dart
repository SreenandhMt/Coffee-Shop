import 'package:flutter/material.dart';

class Skelton extends StatefulWidget {
  const Skelton({
    super.key,
    required this.width,
    required this.height,
    this.color,
  });
  final double? width;
  final double? height;
  final Color? color;

  @override
  State<Skelton> createState() => _SkeltonState();
}

class _SkeltonState extends State<Skelton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color != null
            ? widget.color!.withOpacity(0.4)
            : Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
