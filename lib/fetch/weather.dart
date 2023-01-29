import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:weather_good/fetch/location.dart';
import 'package:weather_good/model/weather.dart';
import 'package:http/http.dart' as http;

String api = 'http://api.weatherapi.com/v1/forecast.json';
String key = '';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    final response = await http
        .post(Uri.parse('$api?key=$key&q=$cityName&days=7&aqi=no&alerts=no'));
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Weather.fromJson(decodedResponse);
      print(ret.country);
      print(ret.currentTemp);
      print(ret.name);
      return ret;
    } else {
      print('error');
    }
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    final response = await http.post(Uri.parse(
        '$api?key=$key&q=${location.latitude},${location.longitude}&days=7&aqi=no&alerts=no'));
    if (response.statusCode == 200) {
      var decodedResponse =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      print(decodedResponse);
      var ret = Weather.fromJson(decodedResponse);
      print(ret.name);
      print(ret.country);
      print(ret.currentTemp);

      return ret;
    } else {
      print('error');
      print(response.statusCode);
    }
    print(location.latitude);
    print(location.longitude);
  }

  Image getWeatherIcon(int condition, double height) {
    if (condition == 1000) {
      return Image.asset(
        'assets/images/sun.png',
        height: height,
      ); // солнично
    } else if (condition == 1003) {
      return Image.asset('assets/images/cloudy.png',
          height: height); // переменная облочность
    } else if (condition == 1006 ||
        condition == 1009 ||
        condition == 1030 ||
        condition == 1135 ||
        condition == 1147) {
      return Image.asset('assets/images/cloud.png', height: height); // облочно
    } else if (condition == 1063 ||
        condition == 1171 ||
        condition == 1180 ||
        condition == 1183 ||
        condition == 1186 ||
        condition == 1189 ||
        condition == 1192 ||
        condition == 1195 ||
        condition == 1198 ||
        condition == 1201 ||
        condition == 1204 ||
        condition == 1240 ||
        condition == 1243 ||
        condition == 1246 ||
        condition == 1264) {
      return Image.asset('assets/images/raining.png', height: height);
    } else if (condition == 1066 ||
        condition == 1069 ||
        condition == 1072 ||
        condition == 1114 ||
        condition == 1117 ||
        condition == 1168 ||
        condition == 1207 ||
        condition == 1210 ||
        condition == 1213 ||
        condition == 1216 ||
        condition == 1219 ||
        condition == 1222 ||
        condition == 1225 ||
        condition == 1237 ||
        condition == 1249 ||
        condition == 1252 ||
        condition == 1255 ||
        condition == 1258 ||
        condition == 1261) {
      return Image.asset('assets/images/snow.png', height: height);
    } else if (condition == 1087) {
      return Image.asset('assets/images/lightning.png', height: height);
    } else if (condition == 1150 || condition == 1153) {
      return Image.asset('assets/images/cloudy_sun.png', height: height);
    } else if (condition == 1273 ||
        condition == 1276 ||
        condition == 1279 ||
        condition == 1282) {
      return Image.asset('assets/images/storm.png', height: height);
    }
    return Image.asset('assets/images/sun.png', height: height);
  }
}
