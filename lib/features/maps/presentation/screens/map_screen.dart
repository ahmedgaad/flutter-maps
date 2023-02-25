// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/core/helpers/location_helper.dart';
import 'package:maps/core/utils/color_manager.dart';
import 'package:maps/features/maps/presentation/cubit/map_cubit.dart';
import 'package:maps/features/maps/presentation/cubit/map_states.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/place_item.dart';

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
  List<dynamic> places = [];
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
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

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: floatingSearchBarController,
      elevation: 6.0,
      hint: 'Find a place ...',
      hintStyle: const TextStyle(fontSize: 18.0),
      queryStyle: const TextStyle(fontSize: 18.0),
      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      margins: const EdgeInsets.fromLTRB(20, 70, 20, 0),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      physics: const BouncingScrollPhysics(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(
              Icons.place,
              color: Colors.black.withOpacity(0.6),
            ),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      // borderRadius: BorderRadius.circular(5.0),
      border: BorderSide.none,
      axisAlignment: isPortrait ? 0.0 : -1.0,
      width: isPortrait ? 600 : 500,
      height: 52.0,
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      transition: CircularFloatingSearchBarTransition(),
      onFocusChanged: (_) {},
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      builder: (BuildContext context, Animation<double> animation) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionBloc(),
            ],
          ),
        );
      },
    );
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = const Uuid().v4();
    BlocProvider.of<MapCubit>(context)
        .showPlacesSuggestions(query, sessionToken);
  }

  Widget buildSuggestionBloc() {
    return BlocBuilder<MapCubit, MapStates>(
      builder: (context, state) {
        if (state is AutoCompletePlacesSuccessfullyState) {
          places = state.places;
          if (places.isNotEmpty) {
            return buildListOfPlace();
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget buildListOfPlace() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return InkWell(
          onTap: () {
            floatingSearchBarController.close();
          },
          child: PlaceItem(suggestionModel: places[index]),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
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
      drawer: CustomDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blue,
                  ),
                ),
          buildFloatingSearchBar(),
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
