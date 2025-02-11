import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/address/models/address_model.dart';
import 'package:coffee_app/features/address/view_models/address_view_model.dart';
import 'package:coffee_app/features/auth/views/forgot_password/email_conform_page.dart';
import 'package:coffee_app/features/checkout/view_models/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../route/navigation_utils.dart';

class ChooseAddressPage extends ConsumerStatefulWidget {
  const ChooseAddressPage({super.key});

  @override
  ConsumerState<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends ConsumerState<ChooseAddressPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(addressViewModelProvider.notifier).getAddresses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final address = ref.watch(addressViewModelProvider).addresses;
    final checkout = ref.watch(checkoutViewModelProvider).selectedAddress;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => NavigationUtils.addNewAddressPage(context),
              icon: const Icon(Icons.add)),
          width10
        ],
        title: Text("Choose Delivery Address", style: appBarTitleFont),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: address.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: InkWell(
                onTap: () {
                  ref
                      .read(checkoutViewModelProvider.notifier)
                      .selectAddress(address[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: checkout == address[index]
                          ? Border.all(color: AppColors.primaryColor, width: 2)
                          : Border.all(
                              color: AppColors.secondaryColor(context))),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            address[index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          if (checkout == address[index]) ...[
                            width20,
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: AppColors.primaryColor)),
                              child: const Text(
                                "Main Address",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primaryColor),
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
                          Text(address[index].name,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w700)),
                          width20,
                          Text("(${address[index].phoneNumber})")
                        ],
                      ),
                      height10,
                      Row(
                        children: [
                          Expanded(child: Text(address[index].address)),
                          if (checkout == address[index]) ...[
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
          AuthButton(
            text: "OK",
            onPressed: () {
              if (ref.read(checkoutViewModelProvider).selectedAddress == null) {
                ref
                    .read(checkoutViewModelProvider.notifier)
                    .selectAddress(address[0]);
              }
              context.pop();
            },
          )
        ],
      ),
    );
  }
}
