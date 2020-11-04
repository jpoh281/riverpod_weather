import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/providers/settings_provider.dart';

class SettingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentTempUnit = watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings")
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, top: 20, right: 10),
        child: ListTile(
          title: Text('Temperature Unit'),
          subtitle: Text('Celcius or or Fahrenheit\nDefalut: Celcius'),
          trailing: Switch(
            value: currentTempUnit.state == TemperatureUnit.celsius,
            onChanged: (_){
              currentTempUnit.state = currentTempUnit.state == TemperatureUnit.celsius ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius;
            },
          ),
        ),
      ),
    );
  }
}
