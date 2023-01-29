import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_good/controllers/change_theme.dart';
import 'package:weather_good/model/weather.dart';

import '../fetch/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int currentTemp;
  late String name;
  late String country;
  late String condition;
  late int code;
  late List<Times> times1;
  late List<TempWeather> times2;
  bool oneday = true;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        currentTemp = 0;
        name = 'Error';
        country = '';
        return;
      }
      code = weatherData.code;
      currentTemp = weatherData.currentTemp.toInt();
      name = weatherData.name;
      country = weatherData.country;
      condition = weatherData.condition;
      times1 = weatherData.daysTemp[0].times;
      times2 = weatherData.daysTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool number = themeProvider.isDarkMode ? true : false;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: themeProvider.isDarkMode
                ? const AssetImage('assets/images/black_background.png')
                : const AssetImage('assets/images/light_background.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8),
              BlendMode.dst,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Switch(
                    activeThumbImage: const AssetImage(
                      'assets/images/moon.png',
                    ),
                    inactiveThumbImage:
                        const AssetImage('assets/images/suni.png'),
                    activeColor: Theme.of(context).shadowColor,
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        number = !number;
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                var weatherData =
                                    await weather.getLocationWeather();
                                updateUI(weatherData);
                              },
                              child: Image.asset('assets/images/location.png'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 290,
                              child: Text(
                                name,
                                style: const TextStyle(
                                    fontSize: 38, fontFamily: 'NotoSerif'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () async {
                              var typedName = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const CityScreen();
                                  },
                                ),
                              );
                              if (typedName != null) {
                                var weatherData =
                                    await weather.getCityWeather(typedName);

                                updateUI(weatherData);
                              }
                            },
                            child: Image.asset('assets/images/city.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              oneday == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${currentTemp.toString().contains('-') ? currentTemp : "+ $currentTemp"}°',
                          style: const TextStyle(
                              fontSize: 100, fontFamily: 'NotoSerif'),
                        ),
                        weather.getWeatherIcon(code, 150),
                      ],
                    )
                  : const SizedBox(),
              if (oneday == true)
                Container(
                  decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.55)
                          : Colors.white.withOpacity(0.55),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 35, fontFamily: 'NotoSerif'),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  oneday = false;
                                });
                              },
                              child: const Text(
                                '7 days >',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'NotoSerif',
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: times1.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text('${times1[index].temp.toString()}°',
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontFamily: 'NotoSerif')),
                                  const SizedBox(height: 10),
                                  weather.getWeatherIcon(
                                      times1[index].code, 60),
                                  const SizedBox(height: 10),
                                  Text(
                                      DateFormat.Hm().format(
                                          DateTime.parse(times1[index].time)),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'NotoSerif')),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.55)
                          : Colors.white.withOpacity(0.55),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 42),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  oneday = true;
                                });
                              },
                              child: const Text(
                                '< 1 day',
                                style: TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 225,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: times2.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(13),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      daysWeek[index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'NotoSerif'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  weather.getWeatherIcon(
                                      times2[index].code, 50),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 135,
                                    child: Text(
                                      times2[index].condition,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'NotoSerif',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                      '${times2[index].maxTemp.toString().contains('-') ? times2[index].maxTemp.toString() : '+${times2[index].maxTemp.toString()}'}°',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'NotoSerif')),
                                  const SizedBox(width: 3),
                                  Text(
                                      '${times2[index].minTemp.toString().contains('-') ? times2[index].minTemp.toString() : '+${times2[index].minTemp.toString()}'}°',
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'NotoSerif',
                                          color: Color(0xff504E4E))),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> daysWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
