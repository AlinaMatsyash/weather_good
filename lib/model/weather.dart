class Weather {
  final String name;
  final String country;
  final double currentTemp;
  final String condition;
  final int code;
  final List<TempWeather> daysTemp;

  Weather(
      {required this.name,
      required this.country,
      required this.currentTemp,
      required this.condition,
      required this.daysTemp,
      required this.code});
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        daysTemp: (json['forecast']['forecastday'] as List)
            .map((item) => TempWeather.fromJson(item))
            .toList(),
        currentTemp: json['current']['temp_c'],
        country: json['location']['country'],
        condition: json['current']['condition']['text'],
        code: json['current']['condition']['code'],
        name: json['location']['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'forecast': daysTemp,
      'temp_c': currentTemp,
      'country': country,
      'name': name,
      'text': condition
    };
  }
}

class TempWeather {
  List<Times> times;
  double maxTemp;
  double minTemp;
  String condition;
  int code;

  TempWeather(
      {required this.times,
      required this.maxTemp,
      required this.minTemp,
      required this.condition,
      required this.code});
  factory TempWeather.fromJson(Map<String, dynamic> json) {
    return TempWeather(
      times:
          (json['hour'] as List).map((item) => Times.fromJson(item)).toList(),
      condition: json['day']['condition']['text'] as String,
      code: json['day']['condition']['code'],
      minTemp: json['day']['mintemp_c'],
      maxTemp: json['day']['maxtemp_c'],
    );
  }
}

class Times {
  String time;
  double temp;
  String condition;
  int code;

  Times(
      {required this.time,
      required this.temp,
      required this.condition,
      required this.code});

  factory Times.fromJson(Map<String, dynamic> json) {
    return Times(
      time: json['time'] as String,
      temp: json['temp_c'],
      condition: json['condition']['text'] as String,
      code: json['condition']['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temp': temp,
      'text': condition,
    };
  }
}
