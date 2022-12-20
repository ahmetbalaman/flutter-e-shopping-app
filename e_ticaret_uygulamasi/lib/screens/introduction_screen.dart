import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  void _bitir(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('anaEkranGoster', true);
    
    // ignore: use_build_context_synchronously
    navigate(context, const LoginPage());
  }

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.asset("assets/images/laptop1.png"),
        title: "İstediğiniz kadar ürün tek bir yerde",
        body: "Evet yanlış duymadınız ürünleri satın almak için en iyi yer",
        footer: const Text("Alt başlk"),
      ),
      PageViewModel(
        image: Image.asset("assets/images/laptop2.webp"),
        title: "üstteki fotoğraflar ne alaka?",
        body: "dediğinizi duyar gibiyim inanın bana başka fotoğraf",
        footer: const Text("bulamadım."),
      ),
      PageViewModel(
        image: Image.asset("assets/images/telefon1.png"),
        title: "Uygulamaya Hazır mısınız!",
        body: "öylesinizdir",
        footer: const Text("bence"),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: IntroductionScreen(
            showDoneButton: true,
            showSkipButton: true,
            showNextButton: true,
            onDone: () async {
              _bitir(context);
            },
            pages: getPages(),
            globalBackgroundColor: Colors.white,
            done: const Text(
              "Anladım!",
              style: TextStyle(color: Colors.black),
            ),
            next: const Text("Sıradaki"),
            skip: const Text("Biliyorum!"),
          ),
        ),
      ),
    );
  }
}
