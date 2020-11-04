import 'package:flutter_riverpod/all.dart';

enum TemperatureUnit {
  celsius,
  fahrenheit
}

final settingsProvider = StateProvider<TemperatureUnit>((ref) {
  print('>>> In settingsProvider');
  return TemperatureUnit.celsius;
});