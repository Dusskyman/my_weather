import 'package:equatable/equatable.dart';
import 'package:my_weather/models/search_weather_model.dart';

abstract class WeatherSearchState extends Equatable {
  const WeatherSearchState();
}

class WeatherSearchIdle extends WeatherSearchState {
  const WeatherSearchIdle();

  @override
  List<Object?> get props => [];
}

class WeatherSearchLoading extends WeatherSearchState {
  const WeatherSearchLoading();

  @override
  List<Object?> get props => [];
}

class WeatherSearchFound extends WeatherSearchState {
  final List<SearchWeatherModel> searchWeatherModels;
  const WeatherSearchFound({required this.searchWeatherModels});

  @override
  List<Object?> get props => [searchWeatherModels];
}
