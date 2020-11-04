class Weather{
  final String weatherStateName;
  final String created;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final String city;
  final int woeid;
  final DateTime lastUpdated;

  Weather({this.weatherStateName, this.created, this.minTemp, this.maxTemp, this.theTemp, this.city, this.woeid, this.lastUpdated});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
    weatherStateName : json['weather_state_name'],
    created : json['created'],
    minTemp : json['min_temp'] as double,
    maxTemp : json['max_temp'] as double,
    theTemp : json['the_temp'] as double,
    city : json['city'],
    woeid : json['woeid'] as int,
    lastUpdated : DateTime.now());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weatherStateName'] = this.weatherStateName;
    data['created'] = this.created;
    data['minTemp'] = this.minTemp;
    data['maxTemp'] = this.maxTemp;
    data['theTemp'] = this.theTemp;
    data['city'] = this.city;
    data['woeid'] = this.woeid;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}
