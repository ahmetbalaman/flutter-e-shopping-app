import 'package:e_ticaret_uygulamasi/class/class_kisi_model.dart';
import 'package:e_ticaret_uygulamasi/class/shared_preferences.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/navigate_page.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/screens/register_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

int input = 0;

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController ePosta = TextEditingController();
  TextEditingController sifre = TextEditingController();
  bool sifreGorunmeSecenek = true;
  bool progressGorunmeSecenek = false;

  Future<void> araKullanici(String eposta, String sifre) async {
    refKisi.onValue.listen((event) {
      var gelenDeger = event.snapshot.value as dynamic;
      if (gelenDeger != null) {
        gelenDeger.forEach((key, nesne) async {
          var gelenKisi = Kisi.fromJson(key, nesne);
          if (gelenKisi.e_posta == eposta && gelenKisi.sifre == sifre) {
            input = 1;
            List<String> deger = [
              key,
              gelenKisi.ad_soyad!,
              gelenKisi.e_posta!,
              gelenKisi.sifre!,
              gelenKisi.adres!,
              gelenKisi.telefon_no!
            ];
            if (gelenKisi.e_posta == "admin" && gelenKisi.sifre == "admin") {
            SharedPreferAl.saveBl('adminGirdi', true);
            adminGirdi=true;
            }
            snackBarGoster(context, "Giriş Başarılı! Hoşgeldin ${deger[1]}");
            SharedPreferAl.saveBl('girisYapildi', true);
            SharedPreferAl.saveStr('girisYapilanKisi', key);
            SharedPreferAl.saveList("girisBilgi", deger.toList());
            navigateReplace(context, const NavigatorPage());
        
          }
        });
        input == 0
            ? snackBarGoster(context, "Kullanıcı veya şifre hatalı!")
            : null;
        setState(() {
          progressGorunmeSecenek = !progressGorunmeSecenek;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerComponent(context, "Giriş Yap!", false),
                SizedBox(height: context.height * 0.2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "E Posta"),
                          controller: ePosta,
                          validator: (ePosta) {
                            if (ePosta!.isEmpty) {
                              return "Lütfen E postanızı giriniz";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: sifreGorunmeSecenek,
                          decoration: InputDecoration(
                            labelText: "Şifre",
                            suffixIcon: IconButton(
                                icon: Icon(sifreGorunmeSecenek
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    sifreGorunmeSecenek = !sifreGorunmeSecenek;
                                  });
                                }),
                          ),
                          controller: sifre,
                          validator: (sifre) {
                            if (sifre!.isEmpty) {
                              return "Lütfen Şifrenizi giriniz";
                            }
                            return null;
                          },
                        ),
                      ]),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () => navigate(context, const RegisterPage()),
                          child: const Text(
                            "Hesabınız Yok mu?",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          )),
                    ),
                    const SizedBox(height: 40),
                    Visibility(
                        visible: progressGorunmeSecenek,
                        child: const CircularProgressIndicator()),
                    const SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100)),
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              progressGorunmeSecenek = !progressGorunmeSecenek;
                            });
                            bool deger = formKey.currentState!.validate();
                            if (deger) {
                              araKullanici(ePosta.text, sifre.text);
                            }
                          },
                          child: const Text("Giriş Yap!")),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
