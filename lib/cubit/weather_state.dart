part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState{}

class WeatherDone extends WeatherState{
  var weather;
  WeatherDone({required this.weather});
}

class WeatherError extends WeatherState{
  var error;
  WeatherError({required this.error});
}