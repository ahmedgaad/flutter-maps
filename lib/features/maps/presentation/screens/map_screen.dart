// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/core/helpers/location_helper.dart';
import 'package:maps/core/utils/color_manager.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  //PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.0,
      tilt: 0.0,
      zoom: 16.0);
  Future<void> getCurrentLocation() async {
    position = await LocationHelper.determinePosition().whenComplete(() {
      setState(() {});
    });
    /*position = await Geolocator.getLastKnownPosition().whenComplete(() {
      setState(() {});
    });*/
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: myCurrentLocationCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController googleMapController) {
        _mapController.complete(googleMapController);
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blue,
                  ),
                ),
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          onPressed: _goToMyCurrentLocation,
          backgroundColor: ColorManager.blue,
          child: const Icon(Icons.place),
        ),
      ),
    );
  }
}


// SafeArea(
//       child: BlocProvider<PhoneAuthCubit>(
//         create: (context) => PhoneAuthCubit(),
//         child: Scaffold(
//           body: Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 phoneAuthCubit.signOut();
//                 Navigator.pushReplacementNamed(context, Routes.phoneAuthRoute);
//               },
//               style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(110, 50),
//                   backgroundColor: Colors.black,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6.0))),
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
