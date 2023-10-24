import 'package:latlong2/latlong.dart';

class SearchWeatherModel {
  final String imageUrl;
  final String temp;
  final String tempFeelsLike;
  final String weekday;

  SearchWeatherModel({
    required this.imageUrl,
    required this.temp,
    required this.tempFeelsLike,
    required this.weekday,
  });
}
