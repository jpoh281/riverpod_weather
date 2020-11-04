import'package:http/http.dart' as http;
import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/repositories/weather_api_client.dart';

final weatherApiClientProvider = Provider<WeatherApiClient>(
    (ref){
      print('>>> In WeatherProvider');
      return WeatherApiClient(httpClient: http.Client());
    });