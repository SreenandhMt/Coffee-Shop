import 'dart:async';
import 'dart:developer';

import 'package:coffee_app/core/app_colors.dart';
import 'package:coffee_app/core/fonts.dart';
import 'package:coffee_app/core/progress_bar.dart';
import 'package:coffee_app/core/size.dart';
import 'package:coffee_app/features/address/view_models/address_view_model.dart';
import 'package:coffee_app/route/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/google_map_style.dart';
import 'package:geocoding/geocoding.dart';

class AddNewAddressPage extends ConsumerStatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  ConsumerState<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends ConsumerState<AddNewAddressPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(addressViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New Address", style: appBarTitleFont),
        actions: const [
          Icon(
            Icons.search_rounded,
            size: 30,
          ),
          width10,
        ],
      ),
      body: viewModel.isLoading
          ? const AppProgressBar()
          : Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: AppColors.secondaryColor(context)),
                    child: const GoogleMapWidget(
                      draggable: true,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.state,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(viewModel.userAddress),
                      height10,
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: const Size(double.infinity, 60),
                            ),
                            onPressed: () {
                              if (viewModel.isLoading ||
                                  viewModel.userAddress.isEmpty) {
                                return;
                              }
                              context.pop();
                              NavigationUtils.fillUpAddressPage(context);
                            },
                            child: const Text(
                                "Select Location & Continue Fill Address",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class GoogleMapWidget extends ConsumerStatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.draggable = false,
  });
  final bool draggable;

  @override
  ConsumerState<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends ConsumerState<GoogleMapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isLoading = true;
  LatLng userLocation = const LatLng(37.42796133580664, -122.085749655962);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> getUserCurrentLocation() async {
    try {
      final GoogleMapController GoogleMapcontroller = await _controller.future;
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) async {
        await Geolocator.requestPermission();
        log("ERROR$error");
      });
      final position = await Geolocator.getCurrentPosition();
      userLocation = LatLng(position.latitude, position.longitude);
      final cameraPosition = CameraPosition(
        target: userLocation,
        zoom: 14,
      );
      GoogleMapcontroller.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition));
      createMarker();
      await getAddress(userLocation);
    } catch (e) {
      log(e.toString());
    }
  }

  void createMarker() {
    final marker = Marker(
      draggable: widget.draggable,
      markerId: const MarkerId('place_name'),
      onDragEnd: (value) {
        userLocation = value;
        getAddress(value);
      },
      position: userLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(),
    );
    if (!mounted) return;
    setState(() {
      markers[const MarkerId('place_name')] = marker;
    });
  }

  Future<void> getAddress(LatLng latLng) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    // log("${placeMarks.first.street}, ${placeMarks.first.subLocality} ${placeMarks.first.locality}, ${placeMarks.first.administrativeArea} ${placeMarks.first.postalCode}, ${placeMarks.first.country}");
    ref.read(addressViewModelProvider.notifier).setUserCurrentAddress(
        "${placeMarks.first.street}, ${placeMarks.first.subLocality} ${placeMarks.first.locality}, ${placeMarks.first.administrativeArea} ${placeMarks.first.postalCode}, ${placeMarks.first.country}",
        placeMarks.first.locality!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          style: Theme.of(context).brightness == Brightness.dark
              ? GoogleMapStyles.mapStyle
              : GoogleMapStyles.mapStyleLightMode,
          markers: Set<Marker>.of(markers.values),
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            getUserCurrentLocation();
            Future.delayed(
              const Duration(seconds: 1),
              () => setState(
                () {
                  isLoading = false;
                },
              ),
            );
            createMarker();
          },
          initialCameraPosition: CameraPosition(
            target: userLocation,
            zoom: 14,
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
