
import 'package:e_ticaret_uygulamasi/class/shared_preferences.dart';
import 'package:e_ticaret_uygulamasi/components/alert_bar.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/main.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/screens/person/person_screens/change_person.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';


Future<List<String>?> listeGetir() async {
  List<String>? deger = await SharedPreferAl.readList('girisBilgi');
  return deger;
}

Future<void> hesabiSil(String id) async {
  await refKisi.child(id).remove();
  SharedPreferAl.saveBl('girisYapildi', false);
  SharedPreferAl.saveStr('girisYapilanKisi', "");
  SharedPreferAl.saveList("girisBilgi", []);
}

class MyInformationPage extends StatefulWidget {
  const MyInformationPage({Key? key}) : super(key: key);

  @override
  State<MyInformationPage> createState() => _MyInformationPageState();
}

TextEditingController sifre = TextEditingController();

class _MyInformationPageState extends State<MyInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: headerComponent(context, "Giriş Bilgileriniz", true),
            ),
            FutureBuilder<List<String>?>(
              future: listeGetir(),
              builder: (context, snapshot) {
                
                if (snapshot.hasData) {
                  var deger = snapshot.data!;
            
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      
                      cardKisim(context, "Adı ve Soyadı :${deger[1]}"),
                      cardKisim(context, "E posta :${deger[2]}"),
                      cardKisim(context, "Adresiniz :${deger[4]}"),
                      cardKisim(context, "Telefon Numaranız:${deger[5]}"),
                      const SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                width: context.width / 3,
                                height: context.height / 15,
                                child: ElevatedButton(
                                    onPressed: () {
                                      textBoxluAlertDialog(context,
                                          "Lütfen Bilgierinizi değiştirmek için şifre giriniz",sifre,
                                          () {
                                        if (sifre.text == deger[3]) {
                                          navigate(context, const ChangePersonPage());
                                       
                                        } else {
                                           Navigator.pop(context);
                                          snackBarGoster(
                                              context, "Şifreniz Yanlıştır :(");
                                        }
                                        return null;
                                      });
                                    },
                                    child: const Text("Değiştir"))),
                            SizedBox(
                                width: context.width / 3,
                                height: context.height / 15,
                                child: ElevatedButton(
                                    onPressed: () {
                                      textBoxluAlertDialog(context,
                                          "Lütfen Silmek istediğiniz hesap için şifreyi giriniz",sifre,
                                          () {
                                        if (sifre.text == deger[3]) {
                                          hesabiSil(deger[0]);
                                          snackBarGoster(context,
                                              "Hesabınız silinmiştir :(");
                                              navigateReplace(context, const LoginPage());
                                   
                                        }else{ Navigator.pop(context);
                                          snackBarGoster(
                                              context, "Şifreniz Yanlıştır :(");
                                        }
                                        return null;
                                      });
                                    },
                                    child: const Text("Hesabını Sil"))),
                          ])
                    ],
                  );
                } else {
                  return const Center();
                }
              },
            )
          ],
        ),
      ),
    ));
  }

}

Widget cardKisim(BuildContext context, text) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: context.height * 0.1,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4)
          ]),
      width: context.width,
      child: FittedBox(
        alignment: Alignment.topLeft,
        fit: BoxFit.contain,
        child: Text(
          text,
          style: TextStyle(
            fontSize: context.height*0.0008,
          ),
        ),
      ),
    ),
  );
}
