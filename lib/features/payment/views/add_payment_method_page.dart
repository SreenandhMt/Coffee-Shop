import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({super.key});

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  final images = [
    "https://cdn-icons-png.flaticon.com/512/2504/2504802.png",
    "https://w7.pngwing.com/pngs/63/1016/png-transparent-google-logo-google-logo-g-suite-chrome-text-logo-chrome.png",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2XR3uve98Zaune2n4CVHaAjR6ReZwmcwHYg&s",
    "https://static-00.iconduck.com/assets.00/mastercard-icon-2048x1286-s6y46dfh.png",
    "https://w7.pngwing.com/pngs/167/298/png-transparent-card-credit-logo-visa-logos-and-brands-icon-thumbnail.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment Method", style: appBarTitleFont),
        actions: const [
          Icon(Icons.document_scanner_outlined),
          width10,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          height10,
          const inputWithLabelWidget("Card Number", "Enter Card Number"),
          const inputWithLabelWidget(
              "Card Holder Name", "Enter Card Holder Name"),
          _CardDetailsFormField(MediaQuery.sizeOf(context)),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Supported Payments:",
              style: subtitleFont(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            children: List.generate(
              images.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 15 : 5,
                  top: 5,
                  right: 5,
                ),
                child: Image.network(
                  images[index],
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const Spacer(),
          AuthButton(
            text: "Add Card",
            onPressed: () {
              context.pop();
            },
          )
        ],
      ),
    );
  }

  Widget _CardDetailsFormField(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LimitedBox(
          maxWidth: (size.width / 2) * 0.9,
          child: const inputWithLabelWidget("Expiry Date", "00/00",
              icon: Icons.date_range_outlined),
        ),
        LimitedBox(
          maxWidth: (size.width / 2) * 0.9,
          child: const inputWithLabelWidget("CVV", "000"),
        )
      ],
    );
  }
}

class inputWithLabelWidget extends StatelessWidget {
  const inputWithLabelWidget(this.label, this.hintText, {this.icon, super.key});
  final String label;
  final String hintText;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: subtitleFont(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextFormField(
            style: TextStyle(
                color: AppColors.themeColor(context),
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              suffixIcon: icon != null ? Icon(icon) : null,
              filled: true,
              fillColor: AppColors.secondaryColor(context).withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
