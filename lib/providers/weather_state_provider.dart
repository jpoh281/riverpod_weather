import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/models/weather.dart';
import 'package:riverpod_weather/providers/city_provider.dart';
import 'package:riverpod_weather/providers/providers.dart';

class WeatherState {
  final bool loading;
  final Weather weather;
  final String error;

  WeatherState({this.loading, this.weather, this.error});

  WeatherState copyWith({bool loading, Weather weather, String error}) {
    return WeatherState(
        loading: loading ?? this.loading,
        weather: weather ?? this.weather,
        error: error ?? this.error);
  }
}

final currentWeatherProvider = StateNotifierProvider<CurrentWeather>(
    (ref) {
      print('>>> In currentWeather');
      return CurrentWeather(ref.read);
    }
);

class CurrentWeather extends StateNotifier<WeatherState>{
  final Reader read;

  static WeatherState initialWeatherState = WeatherState();


  CurrentWeather(this.read) : super(initialWeatherState);

  Future<void> fetchWeather() async{
    state = state.copyWith(loading: true, error: '');
    final String city = read(cityProvider).state;
    try{
      final Weather weather = await read(weatherRepositoryProvider).getWeather();
      print("도시는 " + weather.city);
      state = state.copyWith(loading: false, weather: weather, error: '');
    }catch(e){
      state = state.copyWith(loading: false, error: 'Can not fetch the weather of $city');
    }
  }
}

final weatherStateProvider = Provider<WeatherState>((ref) {
  print('>>> In weatherStateProvider');
  final WeatherState weatherState = ref.watch(currentWeatherProvider.state);
  return weatherState;
});