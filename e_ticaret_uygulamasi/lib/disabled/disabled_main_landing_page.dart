/*import 'package:e_ticaret_uygulamasi/disabled_app_router_main.dart';
import 'package:e_ticaret_uygulamasi/main.dart';
import 'package:e_ticaret_uygulamasi/screens/introduction_screen.dart';
import 'package:e_ticaret_uygulamasi/screens/navigate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
   LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Future girisYapildi() async{

  final sp = await SharedPreferences.getInstance();
   isLoaded = sp.getBool('girisYapildi') ?? false;

   loading=false;
 setState(() {
   
 });
  }

  bool? isLoaded;
  bool loading=true;
@override
  void initState() {
    super.initState();
    girisYapildi();
  }

  @override
  Widget build(BuildContext context) {
    return loading? CircularProgressIndicator() :isLoaded! ? NavigatorPage():IntroductionPage(); 
  }
}*/