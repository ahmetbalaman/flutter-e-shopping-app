import 'dart:collection';

import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DatabaseReference refKisi = FirebaseDatabase.instance.ref("kisiler");

  Future<void> ekle(String adSoyad, String ePosta, String telefonNo,
      String sifre, String adres) async {
    var bilgi = HashMap<dynamic, dynamic>();
    bilgi["kullanici_id"] = "";
    bilgi["ad_soyad"] = adSoyad;
    bilgi["e_posta"] = ePosta;
    bilgi["telefon_no"] = telefonNo;
    bilgi["sifre"] = sifre;
    bilgi["adres"] = adres;
    refKisi.push().set(bilgi);
  }

  GlobalKey<FormState> formRegisterKey = GlobalKey<FormState>();
  TextEditingController adSoyad = TextEditingController();
  TextEditingController ePosta = TextEditingController();
  TextEditingController telefonNo = TextEditingController();
  TextEditingController sifre = TextEditingController();
  var geneSifre = TextEditingController();
  TextEditingController adres = TextEditingController();
  bool sifreGorunmeSecenek = true;
  @override
  Widget build(BuildContext context) {
    var aradakibosluk = context.height * 0.02;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                headerComponent(context, "Kayıt Ol!", true),
                Form(
                  key: formRegisterKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Ad ve Soyad"),
                        controller: adSoyad,
                        validator: (adSoyad) {
                          if (adSoyad!.isEmpty) {
                            return "Lütfen boş alan bırakmayınız";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: aradakibosluk),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "E Posta Adresi"),
                        controller: ePosta,
                        validator: (ePosta) {
                          if (ePosta!.isEmpty) {
                            return "Lütfen boş alan bırakmayınız";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: aradakibosluk),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        decoration: const InputDecoration(
                            labelText: "Telefon Numarası"),
                        controller: telefonNo,
                        validator: (telefonNo) {
                          if (telefonNo!.isEmpty) {
                            return "Lütfen boş alan bırakmayınız";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: aradakibosluk),
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
                      SizedBox(height: aradakibosluk),
                      TextFormField(
                        obscureText: sifreGorunmeSecenek,
                        decoration:
                            const InputDecoration(labelText: "Şifre Tekrar"),
                        controller: geneSifre,
                        validator: (geneSifre) {
                          if (geneSifre!.isEmpty) {
                            return "Lütfen Boşluk girmeyiniz";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: aradakibosluk),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Adres"),
                        controller: adres,
                        validator: (adres) {
                          if (adres!.isEmpty) {
                            return "Lütfen adres giriniz";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: aradakibosluk),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)),
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              bool deger =
                                  formRegisterKey.currentState!.validate();

                              if (geneSifre.text != sifre.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Lütfen Şifreyi aynı giriniz")));
                                deger = false;
                              }
                              if (deger) {
                                ekle(adSoyad.text, ePosta.text, telefonNo.text,
                                    sifre.text, adres.text);
                                snackBarGoster(
                                    context, "Başarıyla Kayıt olundu!");
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Kayıt ol!")),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
