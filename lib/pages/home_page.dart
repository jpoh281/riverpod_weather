import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/pages/search_page.dart';
import 'package:riverpod_weather/pages/setting_page.dart';
import 'package:riverpod_weather/providers/city_provider.dart';
import 'package:riverpod_weather/providers/providers.dart';
import 'package:riverpod_weather/providers/settings_provider.dart';
import '../providers/providers.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final cwp = watch(currentWeatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              context
                  .read(cityProvider)
                  .state = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
              print('City : ${context
                  .read(cityProvider)
                  .state}');
              if (context
                  .read(cityProvider)
                  .state != null) {
                await cwp.fetchWeather();
              }
            },
          ),
        ],
      ),
      body: ProviderListener(
          provider: weatherStateProvider,
          onChange: (context, weather) {
            print('>>> In onChange');
            if (weather != null &&
                weather.error != null&& weather.error.isNotEmpty) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                    title: Text('Error'),
                    content: Text(weather.error)
                );
              });
            }
          },
          child: buildBody(watch(weatherStateProvider), watch(settingsProvider).state,context)),
    );
  }

  Widget buildBody(WeatherState weatherState,TemperatureUnit temperatureUnit ,BuildContext context) {
    if (weatherState == CurrentWeather.initialWeatherState) {
      return Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    if (weatherState.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (weatherState.weather == null) {
      return Center(
        child: Text(
          'Select a city',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return ListView(
      children: [
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height / 6),
        Text(weatherState.weather.city,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.0),
        Text(
          '${TimeOfDay.fromDateTime(weatherState.weather.lastUpdated).format(
              context)}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(calculateTemp(temperatureUnit,weatherState.weather.theTemp),
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Max: ${calculateTemp(temperatureUnit,weatherState.weather.maxTemp)}',
                    style: TextStyle(fontSize: 16.0)),
                Text('Min: ${calculateTemp(temperatureUnit,weatherState.weather.minTemp)}',
                    style: TextStyle(fontSize: 16.0))
              ],
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Text(weatherState.weather.weatherStateName,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 32.0))
      ],
    );
  }

  String calculateTemp(TemperatureUnit temperatureUnit, double temp){
    if(temperatureUnit == TemperatureUnit.fahrenheit){
      return ((temp * 9 / 5) + 32).toStringAsFixed(2) + '°F';
    }
    return temp.toStringAsFixed(2) + '°C';
  }
}
