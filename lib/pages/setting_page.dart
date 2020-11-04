import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            value: true,
            onChanged: (_){
              return true;
            },
          ),
        ),
      ),
    );
  }
}
