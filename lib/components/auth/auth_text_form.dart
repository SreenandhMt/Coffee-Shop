import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';

class InputWithText extends StatefulWidget {
  const InputWithText({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    required this.obscureText,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  State<InputWithText> createState() => InputWithTextState();
}

class InputWithTextState extends State<InputWithText> {
  late bool _isObscured;
  @override
  void initState() {
    _isObscured = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              validator: widget.validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return "Enter ${widget.hintText}";
                    }
                    return null;
                  },
              controller: widget.controller,
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor(context)),
              obscureText: _isObscured,
              decoration: InputDecoration(
                filled: true,
                //text
                hintText: widget.hintText,
                suffixIcon: !widget.obscureText
                    ? null
                    : IconButton(
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: widget.controller.text.isNotEmpty
                              ? AppColors.themeColor(context)
                              : Colors.grey.shade500,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      ),
                //icon
                prefixIcon: widget.icon == null
                    ? null
                    : Icon(widget.icon,
                        color: widget.controller.text.isNotEmpty
                            ? AppColors.themeColor(context)
                            : Colors.grey.shade500,
                        size: 20),
                //style
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10)),
                fillColor: AppColors.secondaryColor(context).withOpacity(0.4),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateInputBox extends StatefulWidget {
  const DateInputBox({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  State<DateInputBox> createState() => DateInputBoxState();
}

class DateInputBoxState extends State<DateInputBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextFormField(
              controller: widget.controller,
              validator: widget.validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return "Enter ${widget.hintText}";
                    }
                    return null;
                  },
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor(context)),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DateInputFormatter(),
              ],
              decoration: InputDecoration(
                filled: true,
                //text
                hintText: "00/00/0000",
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: widget.controller.text.isNotEmpty
                        ? AppColors.themeColor(context)
                        : Colors.grey.shade500,
                  ),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now())
                        .then((value) {
                      if (value != null) {
                        widget.controller.text =
                            "${value.day}/${value.month}/${value.year}";
                      }
                    });
                  },
                ),
                //style
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                fillColor: AppColors.secondaryColor(context).withOpacity(0.4),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Automatically format the date while typing (MM/DD/YYYY)
    if (text.length > 8) return oldValue;

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/'); // Add '/' after MM and DD
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
