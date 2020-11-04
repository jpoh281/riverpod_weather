import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/repositories/weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref){
  print('>>> In WeatherRepositoryProvider');
  return WeatherRepository(read: ref.read);
});