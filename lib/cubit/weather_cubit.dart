import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_bloc/services/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherService) : super(WeatherInitial());

  WeatherService weatherService;
  Map<String, dynamic>? weather;

  void getWeather({required String cityName}) async{
    emit(WeatherLoading());
    try{
      weather = await weatherService.getData(cityName: cityName);
      emit(WeatherDone(weather: weather));
    } on Exception catch(e){
      emit(WeatherError(error: e));
    }
  }

  void gotoInitState(){
    emit(WeatherInitial());
  }
}
