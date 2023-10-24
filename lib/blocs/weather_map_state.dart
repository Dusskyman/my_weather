import 'package:equatable/equatable.dart';

abstract class WeatherMapState extends Equatable {
  const WeatherMapState();
}

class WeatherMapIdle extends WeatherMapState {
  const WeatherMapIdle();

  @override
  List<Object?> get props => [];
}
