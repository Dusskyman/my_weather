import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:my_weather/cubit/weather_map_cubit/weather_map_state.dart';

import 'package:my_weather/models/map_weather_model.dart';
import 'package:weather/weather.dart';

class WeatherMapCubit extends Cubit<WeatherMapState> {
  WeatherMapCubit() : super(const WeatherMapLoading());

  void initialMark() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      final position = await Geolocator.getCurrentPosition();
      LatLng point = LatLng(position.latitude, position.longitude);
      emit(WeatherMapIdle(latLng: point));
    } catch (e) {
      emit(const WeatherMapIdle());
    }
  }

  void removeMark() => emit(const WeatherMapIdle());

  void getWeaterWithPoint(LatLng point) async {
    final placeMarks = await GeoCoding.placemarkFromCoordinates(
      point.latitude,
      point.longitude,
      localeIdentifier: 'en',
    );
    final weather = await WeatherFactory(
      '36af6329348ff936daec05f55d30452b',
    ).currentWeatherByLocation(
      point.latitude,
      point.longitude,
    );
    emit(
      WeatherMapMarked(
        mapWeatherModel: MapWeatherModel(
          contry: placeMarks.first.country!,
          imageUrl: _createUrlFromCode(weather.weatherIcon!),
          localy: placeMarks.first.locality!,
          temp: _formatTemp(weather.temperature.toString()),
          tempFeelsLike: _formatTemp(weather.tempFeelsLike.toString()),
          point: point,
        ),
      ),
    );
  }

  String _formatTemp(String temp) {
    if (temp.contains('-')) {
      temp.replaceFirst(' Celsius', '°');
    }
    return '+${temp.replaceFirst(' Celsius', '°')}';
  }

  String _createUrlFromCode(String code) =>
      'https://openweathermap.org/img/wn/$code@2x.png';
}
