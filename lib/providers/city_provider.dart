import 'package:flutter_riverpod/all.dart';

final cityProvider = StateProvider<String>(
        (ref){
          print('>>> In CityProvider');
          return '';});