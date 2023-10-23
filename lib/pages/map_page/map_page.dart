import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:my_weather/widgets/layouts/main_layout.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng markerPoint = LatLng(0.0, 0.0);
  bool showHint = false;

  ///TODO: Remove GeoCoding and add it's logic to bloc, add geolocator, refactor widget to method/file.

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    onTap: (tapPosition, point) => _removeMarker(),

                    ///TODO: Just for testing remove any async onTap after bloc will be added
                    onLongPress: (tapPosition, point) async {
                      markerPoint = point;
                      final placeMarks =
                          await GeoCoding.placemarkFromCoordinates(
                        point.latitude,
                        point.longitude,
                        localeIdentifier: 'en',
                      );
                      setState(() {});
                    },

                    ///TODO: Change to actual geolocation
                    center: LatLng(
                      48.383022,
                      31.1828699,
                    ),
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        _buildMarkes(),
                      ],
                    ),
                  ],
                ),
                const SafeArea(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildMarkes() {
    if (markerPoint.latitude != 0.0 && markerPoint.longitude != 0.0) {
      return Marker(
        point: markerPoint,
        height: 125.0,
        width: 250.0,
        anchorPos: AnchorPos.align(AnchorAlign.top),
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: showHint,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: const [
                    Icon(Icons.sunny),
                    Text(
                      'Text, Text,',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showHint = true;
                setState(() {});
              },
              child: Transform.rotate(
                angle: pi,
                child: const Icon(
                  Icons.navigation,
                  color: Colors.black,
                  size: 50.0,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Marker(
      point: markerPoint,
      builder: (context) => const SizedBox(),
    );
  }

  void _removeMarker() {
    markerPoint = LatLng(0.0, 0.0);
    showHint = false;
    setState(() {});
  }
}
