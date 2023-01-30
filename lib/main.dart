import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:weather_good/screens/location_screen.dart';
import 'package:weather_good/screens/splash_screen.dart';
import 'package:weather_good/theme/app_text_styles.dart';
import 'controllers/change_theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ProjectTheme.light(),
          darkTheme: ProjectTheme.dark(),
          home: SplashScreen(),
        );
      });
}
