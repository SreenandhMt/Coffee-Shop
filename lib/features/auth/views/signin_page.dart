import 'package:coffee_app/features/auth/view_models/auth_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/auth/views/profile_details_page.dart';
import 'package:provider/provider.dart';

final emailController = TextEditingController();

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthHadingTexts(title: "Welcome back 👋", subtitle: "Please enter your email & password to sign in"),
            InputWithText(controller: emailController,hintText: "Email",icon: Icons.email,obscureText: false),
            height5,
            InputWithText(controller: TextEditingController(),hintText: "Password",icon: Icons.lock,obscureText: true),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CupertinoCheckbox(value: false, onChanged: (value) {},inactiveColor: AppColors.primaryColor,activeColor: AppColors.primaryColor),
                  width5,
                  const Text("Remember me",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const Spacer(),
                  InkWell(onTap: () => context.push("/welcome/signin/resetPassword-step-1"),child: const Text("Forget password?",style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: AppColors.primaryColor))),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Divider(thickness: 0.1),
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Don't have an account?",style: TextStyle(fontSize: 15),),
                width5,
                InkWell(onTap: () {
                  if (context.canPop()) context.pop();
                  context.push("/welcome/signup");
                },child: const Text("Sign up",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w700),))
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: Size(size.width*0.9, 60),
                  ),
                  onPressed: () {
                    context.read<AuthViewModel>().signin("", "");
                  },
                  child: const Text("Sign in",style: TextStyle(color: Colors.white, fontSize: 17)),
                ),
              ],
            ),
            height15,
          ],
        ),
      ),
    );
  }

}

class DialogBox extends StatefulWidget {
  const DialogBox({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.autoFunction,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final String subtitle;
  final Function()? autoFunction;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),widget.autoFunction);
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
            CircleAvatar(radius: 60,backgroundColor: AppColors.primaryColor,child: Icon(widget.icon,size: 60,),),
            height30,
            Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: AppColors.primaryColor),),
            height20,
            Text(widget.subtitle,textAlign: TextAlign.center,style: subtitleFont(fontSize: 16),),
            height35,
            const SizedBox(width: 70,height: 70,child: LoadingIndicator(indicatorType: Indicator.ballRotateChase,colors: [AppColors.primaryColor],)),
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
              validator: widget.validator??(value){
                if(value!.isEmpty)
                {
                  return "Enter ${widget.hintText}";
                }
              },
              controller: widget.controller,
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.themeColor(context)),
              obscureText: _isObscured,

              decoration: InputDecoration(
                filled: true,
                //text
                hintText: widget.hintText,
                suffixIcon:!widget.obscureText?null:IconButton(
                  icon: Icon(
                    _isObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                        color: widget.controller.text.isNotEmpty?AppColors.themeColor(context):Colors.grey.shade500,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
                //icon
                prefixIcon:widget.icon==null?null:
                    Icon(widget.icon, color: widget.controller.text.isNotEmpty?AppColors.themeColor(context):Colors.grey.shade500, size: 20),
                //style
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                fillColor: AppColors.secondaryColor(context),
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
    required this.hintText, this.validator,
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
              validator: widget.validator??(value){
                if(value!.isEmpty)
                {
                  return "Enter ${widget.hintText}";
                }
              },
              onChanged: (value) {
                setState(() {});
              },
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.themeColor(context)),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                DateInputFormatter(),
              ],
              decoration: InputDecoration(
                filled: true,
                //text
                hintText: "00/00/0000",
                suffixIcon:IconButton(
                  icon: Icon(Icons.calendar_month_rounded,
                        color: widget.controller.text.isNotEmpty?AppColors.themeColor(context):Colors.grey.shade500,
                  ),
                  onPressed: () {
                    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now()).then((value) {
                      if (value!=null) {
                        widget.controller.text = "${value.day}/${value.month}/${value.year}";
                      }
                    });
                  },
                ),
                //style
                hintStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.w600),
                fillColor: AppColors.secondaryColor(context),
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