import 'package:latlong2/latlong.dart';

class MapWeatherModel {
  final String imageUrl;
  final String temp;
  final String tempFeelsLike;
  final String contry;
  final String localy;
  final LatLng point;

  MapWeatherModel({
    required this.imageUrl,
    required this.temp,
    required this.tempFeelsLike,
    required this.contry,
    required this.localy,
    required this.point,
  });
}
