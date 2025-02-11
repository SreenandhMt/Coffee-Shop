import 'package:coffee_app/core/progress_bar.dart';
import 'package:coffee_app/features/address/view_models/address_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_colors.dart';
import '../../../core/fonts.dart';
import '../../../core/size.dart';

class ManageAddressPage extends ConsumerStatefulWidget {
  const ManageAddressPage({super.key});

  @override
  ConsumerState<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends ConsumerState<ManageAddressPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        ref.read(addressViewModelProvider.notifier).getAddresses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(addressViewModelProvider);
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
      body: viewModel.isLoading
          ? const AppProgressBar()
          : Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: viewModel.addresses.length,
                  itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(15),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: AppColors.secondaryColor(context))),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              viewModel.addresses[index].title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            if (viewModel.addresses[index].isSelected) ...[
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
                            Text(viewModel.addresses[index].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700)),
                            width20,
                            Text("(${viewModel.addresses[index].phoneNumber})")
                          ],
                        ),
                        height10,
                        Row(
                          children: [
                            Expanded(
                                child:
                                    Text(viewModel.addresses[index].address)),
                            if (viewModel.addresses[index].isSelected) ...[
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
                              child: InkWell(
                                onTap: () {
                                  ref
                                      .read(addressViewModelProvider.notifier)
                                      .changeAddress(
                                          viewModel.addresses[index]);
                                  NavigationUtils.addNewAddressPage(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1.5)),
                                  child: const Text(
                                    "Change Address",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                            if (!viewModel.addresses[index].isSelected) ...[
                              width10,
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      ref
                                          .read(
                                              addressViewModelProvider.notifier)
                                          .selectAddress(
                                              viewModel.addresses[index].id);
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                            size: 25),
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
                                      ref
                                          .read(
                                              addressViewModelProvider.notifier)
                                          .removeAddress(
                                              viewModel.addresses[index].id);
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
                                          color: AppColors.primaryColor,
                                          width: 1.5)),
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
