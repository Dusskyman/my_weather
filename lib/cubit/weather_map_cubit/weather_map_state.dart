import 'package:equatable/equatable.dart';
import 'package:my_weather/models/map_weather_model.dart';
import 'package:latlong2/latlong.dart';

abstract class WeatherMapState extends Equatable {
  const WeatherMapState();
}

class WeatherMapIdle extends WeatherMapState {
  final LatLng? latLng;
  const WeatherMapIdle({this.latLng});

  @override
  List<Object?> get props => [];
}

class WeatherMapLoading extends WeatherMapState {
  const WeatherMapLoading();

  @override
  List<Object?> get props => [];
}

class WeatherMapMarked extends WeatherMapState {
  final MapWeatherModel mapWeatherModel;
  const WeatherMapMarked({required this.mapWeatherModel});

  @override
  List<Object?> get props => [mapWeatherModel];
}
