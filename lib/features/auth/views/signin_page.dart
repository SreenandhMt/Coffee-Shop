import 'dart:developer';

import 'package:coffee_app/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';

import '../../../route/navigation_utils.dart';

final emailController = TextEditingController();

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends ConsumerState<SigninPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authViewModelProvider);
    final size = MediaQuery.sizeOf(context);
    return Form(
      key: _key,
      child: Scaffold(
        appBar:
            AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AuthHadingTexts(
                          title: LocaleData.signinWelcomeMessage
                              .getString(context),
                          subtitle:
                              LocaleData.signinSubtitle.getString(context)),
                      InputWithText(
                        controller: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!isValidEmail(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      height5,
                      InputWithText(
                        controller: passwordController,
                        hintText: "Password",
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length <= 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(thickness: 0.1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CupertinoCheckbox(
                                value: false,
                                onChanged: (value) {},
                                activeColor: AppColors.primaryColor,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.disabled)) {
                                    return CupertinoColors.white
                                        .withOpacity(0.4);
                                  }
                                  if (states.contains(WidgetState.selected)) {
                                    return AppColors.primaryColor;
                                  }
                                  return AppColors.primaryColor;
                                })),
                            width5,
                            const Text("Remember me",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)),
                            const Spacer(),
                            InkWell(
                                onTap: () => context.push(
                                    "/welcome/signin/resetPassword-step-1"),
                                child: const Text("Forget password?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors.primaryColor))),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(thickness: 0.1),
                      ),
                      height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LocaleData.haveAccount.getString(context),
                            style: const TextStyle(fontSize: 15),
                          ),
                          width5,
                          InkWell(
                              onTap: () {
                                if (context.canPop()) context.pop();
                                context.push("/welcome/signup");
                              },
                              child: Text(
                                LocaleData.authSignup.getString(context),
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      fixedSize: Size(size.width * 0.9, 60),
                    ),
                    onPressed: () async {
                      //*validating
                      if (!_key.currentState!.validate()) return;

                      //*function calling
                      await ref.read(authViewModelProvider.notifier).signIn(
                          emailController.text, passwordController.text);

                      //*mounted checking
                      if (!mounted) return;
                      final currentState = ref.read(authViewModelProvider);
                      //*response
                      currentState.fold((left) {
                        //!success message
                        if (left == AuthState.success) {
                          _showDialogBox();
                        }
                      }, (right) {
                        //!error massage
                        //TODO: show error message on user
                        log(right);
                      });
                    },
                    child: Text(LocaleData.authSignin.getString(context),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17)),
                  ),
                ],
              ),
              height15,
            ],
          ),
        ),
      ),
    );
  }

  void _showDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => DialogBox(
            autoFunction: () {
              if (!mounted) return;
              NavigationUtils.replaceHomePage(context);
            },
            icon: Icons.person,
            title: "Sign in Successful!",
            subtitle:
                "Please wait... \n Your will be directed to the home page."));
  }

  bool isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}

class DialogBox extends StatefulWidget {
  const DialogBox({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.autoFunction,
    this.child,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final Function()? autoFunction;
  final Widget? child;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), widget.autoFunction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            height20,
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                widget.icon,
                size: 60,
              ),
            ),
            height30,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.primaryColor),
              ),
            ),
            height25,
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: subtitleFont(fontSize: 16),
              ),
            ),
            if (widget.child != null) ...[
              height20,
              widget.child!
            ] else ...[
              height35,
              const SizedBox(
                  width: 70,
                  height: 70,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballRotateChase,
                    colors: [AppColors.primaryColor],
                  )),
            ]
          ],
        ),
      ),
    );
  }
}

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
