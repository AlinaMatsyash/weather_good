import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_good/banner_inline_page.dart';
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
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    int date = DateTime.now().hour;
    if (date == 0 || date == 1 || date == 2 || date == 3 || date == 4) {
    } else if (date == 19 ||
        date == 20 ||
        date == 21 ||
        date == 22 ||
        date == 23) {
      _controller = ScrollController(initialScrollOffset: 23 * 80);
    } else {
      _controller = ScrollController(initialScrollOffset: date * 60.0);
    }
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        currentTemp = 0;
        name = 'Error';
        country = '';
        code = 0;
        condition = '';
        times1 = [Times(time: '', temp: 0, condition: condition, code: code)];
        times2 = [
          TempWeather(times: [
            Times(time: '', temp: 0, condition: condition, code: code)
          ], condition: condition, code: code, maxTemp: 0, minTemp: 0)
        ];
        return;
      }
      code = weatherData.code;
      currentTemp = weatherData.currentTemp.toInt();
      name = weatherData.name;
      country = weatherData.country;
      condition = weatherData.condition;
      times1 = weatherData.daysTemp[0].times;
      times2 = weatherData.daysTemp;
      print(times2);
    });
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  String message = "";

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
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Transform.scale(
                      scale: 1.8,
                      child: Switch(
                        activeTrackColor: Colors.black.withOpacity(0.8),
                        activeThumbImage: const AssetImage(
                          'assets/images/moon.png',
                        ),
                        inactiveThumbImage:
                            AssetImage('assets/images/suni.png'),
                        activeColor: Colors.black87,
                        inactiveThumbColor: Color(0x8C44464D),
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            number = !number;
                            final provider = Provider.of<ThemeProvider>(context,
                                listen: false);
                            provider.toggleTheme(value);
                          });
                        },
                      ),
                    ),
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
                            SizedBox(
                              width: 8.w,
                            ),
                            SizedBox(
                              width: 245.w,
                              child: Text(
                                name == 'Null' ? country : name,
                                style: const TextStyle(
                                    fontSize: 38, fontFamily: 'NotoSerif'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.w),
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
                          style: TextStyle(
                              fontSize: 100.sp, fontFamily: 'NotoSerif'),
                        ),
                        weather.getWeatherIcon(code, 150),
                      ],
                    )
                  : const SizedBox(),
              Column(
                children: [
                  oneday == true
                      ? Container(
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 42.w, vertical: 16.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                          fontSize: 35.sp,
                                          fontFamily: 'NotoSerif'),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          oneday = false;
                                        });
                                      },
                                      child: Text(
                                        '3 days >',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: 'NotoSerif',
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 190.h,
                                child: ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: times1.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Text(
                                              '${times1[index].temp.toString()}°',
                                              style: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontFamily: 'NotoSerif')),
                                          SizedBox(height: 10.h),
                                          weather.getWeatherIcon(
                                              times1[index].code, 60),
                                          SizedBox(height: 10.h),
                                          Text(
                                              DateFormat.Hm().format(
                                                  DateTime.parse(
                                                      times1[index].time)),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
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
                      : Container(
                          decoration: BoxDecoration(
                              color: themeProvider.isDarkMode
                                  ? Colors.black.withOpacity(0.55)
                                  : Colors.white.withOpacity(0.55),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 42.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          oneday = true;
                                        });
                                      },
                                      child: Text(
                                        '< 1 day',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 600.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: times2.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 45.w,
                                            child: Text(
                                              DateFormat.E().format(
                                                  DateTime.parse(times2[index]
                                                      .times
                                                      .first
                                                      .time)),
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontFamily: 'NotoSerif'),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          weather.getWeatherIcon(
                                              times2[index].code, 50),
                                          SizedBox(width: 10.w),
                                          SizedBox(
                                            width: 117.w,
                                            child: Text(
                                              times2[index].condition,
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                fontFamily: 'NotoSerif',
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                              '${times2[index].maxTemp.toString().contains('-') ? times2[index].maxTemp.toString() : '+${times2[index].maxTemp.toString()}'}°',
                                              style: TextStyle(
                                                  fontSize: 19.sp,
                                                  fontFamily: 'NotoSerif')),
                                          SizedBox(width: 5.w),
                                          Text(
                                              '${times2[index].minTemp.toString().contains('-') ? times2[index].minTemp.toString() : '+${times2[index].minTemp.toString()}'}°',
                                              style: TextStyle(
                                                  fontSize: 19.sp,
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
                  Container(
                    color: themeProvider.isDarkMode
                        ? Colors.black.withOpacity(0.55)
                        : Colors.white.withOpacity(0.55),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: BannerInlinePage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// List<String> daysWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
