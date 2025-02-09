import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/views/screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/views/screens/page_switcher.dart';

String l_status = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  l_status = prefs.getString('isLoggedIn').toString();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDYRRzkkH6sb5U7tsaXQkvh1zelVRRrztU",
            authDomain: "fir-shop-2f168.firebaseapp.com",
            projectId: "fir-shop-2f168",
            storageBucket: "fir-shop-2f168.firebasestorage.app",
            messagingSenderId: "758135970972",
            appId: "1:758135970972:web:9c4352678bd7b32e186159",
            measurementId: "G-N49QKGQJ20"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColor.primary,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Nunito',
      ),
      // home: l_status == "login" ? const PageSwitcher() : WelcomePage(),
      home: l_status == "login" ? const PageSwitcher() : PageSwitcher(),
    );
  }
}
