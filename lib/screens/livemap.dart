import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;

import '../main.dart';

const darkMapStyle = 'assets/json/map-dark-mode-style.json';
const lightMapStyle = 'assets/json/map-light-mode-style.json';

class MyMap1 extends StatefulWidget {
  final String user_id;
  const MyMap1(this.user_id, {super.key});
  @override
  _MyMap1State createState() => _MyMap1State();
}

class _MyMap1State extends State<MyMap1> {
  final geo.Geolocator geolocator = geo.Geolocator();
  late GoogleMapController _controller;
  bool _added = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('location').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (_added) {
              mymap(snapshot);
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return GoogleMap(
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                // compassEnabled: false,
                mapType: MapType.normal,
                markers: {
                  Marker(
                    position: LatLng(
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['latitude'],
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['longitude'],
                    ),
                    markerId: const MarkerId('id'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta),
                  ),
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['latitude'],
                      snapshot.data!.docs.singleWhere((element) =>
                          element.id == widget.user_id)['longitude'],
                    ),
                    zoom: 16),
                // onMapCreated: (GoogleMapController controller) async {
                //   setState(
                //     () {
                //       _controller = controller;
                //       _added = true;
                //     },
                //   );
                // },
                onMapCreated: (GoogleMapController controller) async {
                  _controller = controller;

                  // Use appStore to check if dark mode is enabled
                  String mode =
                      appStore.isDarkMode ? darkMapStyle : lightMapStyle;

                  // Load the map style based on dark/light mode
                  String style =
                      await DefaultAssetBundle.of(context).loadString(mode);

                  // Apply the map style
                  _controller.setMapStyle(style);

                  setState(() {
                    _added = true;
                  });
                });
          }),
    );
  }

  Future<void> mymap(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['latitude'],
              snapshot.data!.docs.singleWhere(
                  (element) => element.id == widget.user_id)['longitude'],
            ),
            zoom: 15),
      ),
    );
  }
}
