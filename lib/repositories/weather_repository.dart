import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/models/weather.dart';
import 'package:riverpod_weather/providers/city_provider.dart';
import 'package:riverpod_weather/providers/weather_api_client_provider.dart';

class WeatherRepository{
  final Reader read;

  WeatherRepository({this.read});

  Future<Weather> getWeather() async {
    final String city = read(cityProvider).state;

    try{
      final int locationId = await read(weatherApiClientProvider).getLocationId(city);
      return await read(weatherApiClientProvider).fetchWeather(locationId);
    } catch (e) {
      throw e.toString();
    }
  }
}