import 'package:e_ticaret_uygulamasi/class/shared_preferences.dart';
import 'package:e_ticaret_uygulamasi/screens/basket/basket_items.dart';
import 'package:e_ticaret_uygulamasi/screens/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/navigate_page.dart';

DatabaseReference refUrunler = FirebaseDatabase.instance.ref("urunler");
DatabaseReference refKisi = FirebaseDatabase.instance.ref("kisiler");
DatabaseReference refGifts = FirebaseDatabase.instance.ref("gifts");
DatabaseReference refSell = FirebaseDatabase.instance.ref("bestsellers");
DatabaseReference refReklam = FirebaseDatabase.instance.ref("reklamUrun");
bool adminGirdi = false;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  final sp = await SharedPreferences.getInstance();
  Items.key = await SharedPreferAl.readStr("girisYapilanKisi") ?? "0";
  final bool girisYapildi = sp.getBool('girisYapildi') ?? false;
  adminGirdi = sp.getBool('adminGirdi') ?? false;
  runApp(MyApp(girisYapildi));
}

class MyApp extends StatelessWidget {
  final bool? girisYapildi;
  const MyApp(this.girisYapildi, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E Ticaret Uygulamasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: girisYapildi! ? const NavigatorPage() : const IntroductionPage(),
    );
  }
}
