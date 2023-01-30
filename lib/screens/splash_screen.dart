import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_good/controllers/change_theme.dart';
import 'package:weather_good/theme/color.dart';

import '../fetch/weather.dart';
import 'location_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double latitude;
  late double longitude;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? ColorPalette.black_800 : Colors.white,
      body: Center(
        child: Lottie.asset('assets/day-night.zip'),
        // SpinKitWave(
        //   color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        //   size: 100.0,
        // ),
      ),
    );
  }
}
