// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:e_ticaret_uygulamasi/screens/home_page/most_sells.dart';
import 'package:e_ticaret_uygulamasi/screens/navigate_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import '../../main.dart';

import 'package:e_ticaret_uygulamasi/screens/home_page/gifts_page.dart';

import '../class/class_urun_model.dart';
import '../components/alert_bar.dart';
import '../components/header.dart';
import '../components/navigate_components.dart';
import '../components/snackbar_show.dart';
import '../main.dart';
import 'categori_page.dart';

// ignore: must_be_immutable
class AddItemPage extends StatefulWidget {
  String whereCameFrom;
  AddItemPage({
    Key? key,
    required this.whereCameFrom,
  }) : super(key: key);

  @override
  State<AddItemPage> createState() => AddItemPageState();
}

void esle(HashMap<String, dynamic> guncelBilgi, Urun deger) {
  guncelBilgi["urun_isim"] = deger.urun_isim;
  guncelBilgi["urun_kategori"] = deger.urun_kategori;
  guncelBilgi["urun_foto"] = deger.urun_resim;
  guncelBilgi["urun_aciklama"] = deger.urun_aciklama;
  guncelBilgi["urun_fiyat"] = deger.urun_fiyat;
}

Future<void> ekleGifts(Urun deger) async {
  var guncelBilgi = HashMap<String, dynamic>();
  esle(guncelBilgi, deger);
  guncelBilgi["urun_fiyat"] = 0;
  refGifts.push().set(guncelBilgi);
}

Future<void> ekleSells(Urun deger) async {
  var guncelBilgi = HashMap<String, dynamic>();
  esle(guncelBilgi, deger);
  refSell.push().set(guncelBilgi);
}

Future<void> ekleBanner(Urun deger) async {
  var guncelBilgi = HashMap<String, dynamic>();
  esle(guncelBilgi, deger);
  refReklam.child("-NBwFrydcMt68r9FmvGF").update(guncelBilgi);
}

class AddItemPageState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          headerComponent(context, "Lütfen Ürünü Seçiniz.", true),
          StreamBuilder<DatabaseEvent>(
              stream: refUrunler.onValue,
              builder: (context, event) {
                var liste = <Urun>[];
                var gelenDeger = event.data?.snapshot.value as dynamic;
                if (gelenDeger != null) {
                  gelenDeger.forEach((key, nesne) {
                    var gelenUrun = Urun.fromJson(key, nesne);
                    liste.add(gelenUrun);
                  });
                  return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: liste.length,
                        itemBuilder: (context, index) {
                          var deger = liste[index];
                          return categoriItem(() {
                            alertDailogAreYouSure(
                              context,
                              "Bu ürünü seçmek istediğinizden emin misiniz?",
                              () {
                                snackBarGoster(
                                    context, "${deger.urun_isim} seçildi");
                                if (widget.whereCameFrom == "Gifts") {
                                  ekleGifts(deger);

                                  navigateReplace(context, const GiftsPage());
                                } else if (widget.whereCameFrom ==
                                    "MostSells") {
                                  ekleSells(deger);
                                  navigateReplace(
                                      context, const MostSellsPage());
                                } else if (widget.whereCameFrom == "banner") {
                                  ekleBanner(deger);
                                  navigateReplace(
                                      context, const NavigatorPage());
                                }
                                return null;
                              },
                            );
                            return null;
                          }, deger: deger, context: context);
                        }),
                  );
                } else if (event.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 7,
                    ),
                  );
                }
                return const Center(
                  child: Text("Şu anlık Bir ürün bulunamamaktadır."),
                );
              }),
        ],
      ),
    );
  }
}
