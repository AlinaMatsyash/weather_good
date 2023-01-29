import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_good/controllers/change_theme.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: themeProvider.isDarkMode
                ? const AssetImage('assets/images/black_background.png')
                : const AssetImage('assets/images/light_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.30)
                          : Colors.white.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(16.0)),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    decoration: InputDecoration(
                      icon: Image.asset('assets/images/city.png'),
                      hintText: 'Enter City Name',
                      hintStyle: themeProvider.isDarkMode
                          ? TextStyle(color: Colors.white.withOpacity(0.55))
                          : TextStyle(color: Colors.black.withOpacity(0.55)),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      cityName = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Get Weather',
                  style: TextStyle(
                      fontSize: 32,
                      decoration: TextDecoration.underline,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
