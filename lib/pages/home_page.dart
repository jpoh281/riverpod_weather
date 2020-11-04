import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:riverpod_weather/pages/search_page.dart';
import 'package:riverpod_weather/pages/setting_page.dart';
import 'package:riverpod_weather/providers/city_provider.dart';
import 'package:riverpod_weather/providers/providers.dart';

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
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
             context.read(cityProvider).state = await  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
             print('City : ${context.read(cityProvider).state}');
             if(context.read(cityProvider).state != null){
                await cwp.fetchWeather();
             }
            },
          ),
        ],
      ),
      body: buildBody(watch(currentWeatherProvider.state), context),
    );
  }
  Widget buildBody(WeatherState weatherState, BuildContext context){
    if(weatherState == CurrentWeather.initialWeatherState){
      return Center(
        child: Text(
          'Select a city',
        ),
      );
    }
    return Container();
  }
}
