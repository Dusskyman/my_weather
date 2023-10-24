import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_weather/cubit/weather_search_cubit.dart/weather_search_state.dart';

import 'package:my_weather/models/search_weather_model.dart';
import 'package:weather/weather.dart';

class WeatherSearchCubit extends Cubit<WeatherSearchState> {
  WeatherSearchCubit() : super(const WeatherSearchIdle());

  void getWeaterForecast(String name) async {
    final weatherFactory = WeatherFactory('36af6329348ff936daec05f55d30452b');
    final futureWeather = await weatherFactory.fiveDayForecastByCityName(name);
    final weather = await weatherFactory.currentWeatherByCityName(name);
    final List<SearchWeatherModel> forcast = [];
    final List<String> tempWeekdayList = [];
    forcast.add(
      SearchWeatherModel(
        imageUrl: _createUrlFromCode(weather.weatherIcon!),
        temp: _formatTemp(weather.temperature.toString()),
        tempFeelsLike: _formatTemp(weather.tempFeelsLike.toString()),
        weekday: _formatDate(weather.date),
      ),
    );
    for (var element in futureWeather) {
      if (!tempWeekdayList.contains(_formatDate(element.date)) &&
          element.date!.hour >= 12 &&
          element.date!.hour <= 22) {
        tempWeekdayList.add(_formatDate(element.date));
        forcast.add(
          SearchWeatherModel(
            imageUrl: _createUrlFromCode(element.weatherIcon!),
            temp: _formatTemp(element.temperature.toString()),
            tempFeelsLike: _formatTemp(element.tempFeelsLike.toString()),
            weekday: _formatDate(element.date),
          ),
        );
      }
    }
    emit(WeatherSearchFound(searchWeatherModels: forcast));
  }

  String _formatTemp(String temp) {
    if (temp.contains('-')) {
      temp.replaceFirst(' Celsius', '°');
    }
    return '+${temp.replaceFirst(' Celsius', '°')}';
  }

  String _createUrlFromCode(String code) =>
      'https://openweathermap.org/img/wn/$code@2x.png';

  String _formatDate(DateTime? date) => DateFormat.EEEE().format(
        date ?? DateTime.now(),
      );
}
