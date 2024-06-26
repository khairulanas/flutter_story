import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoding/geocoding.dart' as geo;

class MapsWidget extends StatefulWidget {
  final LatLng latLng;
  const MapsWidget({super.key, required this.latLng});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late GoogleMapController mapController;
  MapType selectedMapType = MapType.normal;
  Set<Marker> markers = <Marker>{};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Center(
        child: Stack(
          children: [
            GoogleMap(
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer())
              },
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              mapType: selectedMapType,
              initialCameraPosition: CameraPosition(
                zoom: 18,
                target: widget.latLng,
              ),
              onMapCreated: (controller) async {
                var street = "";
                var address = "";
                try {
                  final info = await geo.placemarkFromCoordinates(
                      widget.latLng.latitude, widget.latLng.longitude);
                  final place = info[0];
                  street = place.street!;
                  address =
                      '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                } catch (e) {
                  street = "";
                  address = "";
                }

                final marker = Marker(
                  markerId: const MarkerId("source"),
                  position: widget.latLng,
                  infoWindow: InfoWindow(
                    title: street,
                    snippet: address,
                  ),
                );
                setState(() {
                  markers.add(marker);
                  mapController = controller;
                });
              },
            ),
            zoomInZoomOutButton(),
            changeMapTypePopUpButton(),
          ],
        ),
      ),
    );
  }

  Positioned zoomInZoomOutButton() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Column(
        children: [
          FloatingActionButton.small(
            heroTag: "zoom-in",
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            heroTag: "zoom-out",
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Positioned changeMapTypePopUpButton() {
    return Positioned(
      top: 16,
      right: 16,
      child: FloatingActionButton.small(
        heroTag: "-----",
        onPressed: null,
        child: PopupMenuButton<MapType>(
          offset: const Offset(0, 54),
          icon: const Icon(Icons.layers_outlined),
          onSelected: (item) {
            setState(() {
              selectedMapType = item;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<MapType>>[
            const PopupMenuItem<MapType>(
              value: MapType.normal,
              child: Text('Normal'),
            ),
            const PopupMenuItem<MapType>(
              value: MapType.satellite,
              child: Text('Satellite'),
            ),
            const PopupMenuItem<MapType>(
              value: MapType.terrain,
              child: Text('Terrain'),
            ),
            const PopupMenuItem<MapType>(
              value: MapType.hybrid,
              child: Text('Hybrid'),
            ),
          ],
        ),
      ),
    );
  }
}
