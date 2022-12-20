import 'dart:math';
import 'package:e_ticaret_uygulamasi/class/class_urun_model.dart';
import 'package:e_ticaret_uygulamasi/components/alert_bar.dart';
import 'package:e_ticaret_uygulamasi/components/label.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/choose_item_page.dart';
import 'package:e_ticaret_uygulamasi/screens/categories_page.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/favorites_page.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/gifts_page.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/most_sells.dart';
import 'package:e_ticaret_uygulamasi/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

Urun? reklam;
List<Urun> telefonlar = [];
List<Urun> bilgisayarlar = [];

Future<List<Urun>?> reklamGetir() async {
  List<Urun> reklamlar = [];
  await refReklam.once().then((value) {
    var gelenReklam = value.snapshot.value as dynamic;
    if (gelenReklam != null) {
      gelenReklam.forEach((key, nesne) {
        var gelenReklam = UrunReklam.fromJson(key, nesne);
        reklam = Urun(
            gelenReklam.urun_id,
            gelenReklam.urun_isim,
            gelenReklam.urun_kategori,
            gelenReklam.urun_fiyat,
            gelenReklam.urun_aciklama,
            gelenReklam.urun_resim);
      });
    }
  });
  await refUrunler.once().then((value) {
    var gelenReklamlar = value.snapshot.value as dynamic;
    if (gelenReklamlar != null) {
      gelenReklamlar.forEach((key, nesne) {
        var gelenReklam = Urun.fromJson(key, nesne);
        if (gelenReklam.urun_kategori == "Bilgisayarlar") {
          bilgisayarlar.add(gelenReklam);
        }
        if (gelenReklam.urun_kategori == "Akıllı Telefonlar") {
          telefonlar.add(gelenReklam);
        }
        reklamlar.add(gelenReklam);
      });
    }
  });
  return reklamlar;
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: FutureBuilder<List<Urun>?>(
      future: reklamGetir(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: [
                    //Başlk kısmı
                    buildBaslik(context, "Anasayfa"), //ANASAYFA
                    //Reklam Kısmı
                    buildBanner(
                        context, reklam), //BURAYI DA BİZ SEÇEREK DEĞİŞTİRCEZ
                    // 4 tane tek satırlı düğme
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //ikon1
                          buildNavigateIconButton(
                              text: "Kategori",
                              icon: Icons.menu,
                              context: context,
                              gidilecekSayfa: const CategoriesPage()),
                          buildNavigateIconButton(
                              text: "Favoriler",
                              icon: Icons.favorite,
                              context: context,
                              gidilecekSayfa: const FavoritesPage()),
                          buildNavigateIconButton(
                              text: "Hediyeler",
                              icon: Icons.card_giftcard,
                              context: context,
                              gidilecekSayfa: const GiftsPage()),
                          buildNavigateIconButton(
                              text: "En Çok Satılanlar",
                              icon: Icons.people,
                              context: context,
                              gidilecekSayfa: const MostSellsPage()),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: Text(
                      "Yeni Gelenler",

                      //BURAYA RASTGELE BİZİM ÜRÜNLERDEN 3 TANE VERİ ÇEKİP GÖSTERCEK
                      style: TextStyle(
                          fontSize: context.width / 8,
                          fontWeight: FontWeight.bold),
                    )),
                    const SizedBox(
                      height: 16,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildHomePageReklam(context,
                              urunler: telefonlar,
                              isimBaslik: "Akıllı Telefonlar"),
                          buildHomePageReklam(context,
                              urunler: bilgisayarlar,
                              isimBaslik: "Bilgisayarlar"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Center(child: Text("HATA"))],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: CircularProgressIndicator(),
              ),
              Center(child: Text("Lütfen internete bağlanınız."))
            ],
          );
        }
      },
    ));
  }

  Padding buildBanner(BuildContext context, Urun? deger) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            width: double.infinity,
            child: reklam == null
                ? Column(
                    children: const [
                      Center(
                        child: Text(
                          "Reklam Bulunamamaktadır",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () => navigate(
                        context,
                        ProductDetailPage(
                            product: deger!, whereCameFrom: "reklam")),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //VERİ TABANINA BAĞLANIP REKLAM VERECEK.
                                Text(deger!.urun_isim.toString(),
                                    style: TextStyle(
                                      fontSize: context.height / 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                Text("${deger.urun_fiyat} TL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: context.height / 50,
                                    )),
                              ],
                            ),
                            SizedBox(
                                width: context.width / 5,
                                child:
                                    Image.network(deger.urun_resim.toString())),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
          Visibility(
            visible: adminGirdi,
            child: Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  alertDailogAreYouSure(
                    context,
                    "Ürünü değiştirmek mi istiyorsunuz?",
                    () {
                      Navigator.pop(context);
                      navigate(context, AddItemPage(whereCameFrom: "banner"));
                      return null;
                    },
                  );
                },
                icon: const Icon(Icons.change_circle),
                color: Colors.white,
                iconSize: 35,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildBaslik(BuildContext context, text) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(top: context.height * 0.02),
      child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: context.width / 10)),
    ),
  );
}

Widget buildNavigateIconButton(
    {required String text,
    required IconData icon,
    required BuildContext context,
    Widget? gidilecekSayfa}) {
  return GestureDetector(
    onTap: () {
      if (gidilecekSayfa != null) {
        navigate(context, gidilecekSayfa);
        //context.router.navigate(gidilecekSayfa);
      }
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 22),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.shade400,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(text,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

Widget buildHomePageReklam(
  BuildContext context, {
  required List<Urun>? urunler,
  required String isimBaslik,
}) {
  Random rnd = Random();
  return urunler == null
      ? const Text("Ürün bulunamamaktadır")
      : Container(
          width: context.width / 2.5,
          padding: const EdgeInsets.all(20),
          child: urunler.length < 3
              ? const Center(child: Text("Yetersiz Urun"))
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  label("Yeni"),
                  CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (context, i, id) {
                        return GestureDetector(
                          onTap: () {
                            navigate(
                                context,
                                ProductDetailPage(
                                    product: urunler[i],
                                    whereCameFrom: "Kategori"));
                          },
                          child: SizedBox(
                              width: context.height / 4,
                              height: context.height / 4,
                              child: Image.network("${urunler[i].urun_resim}")),
                        );
                      },
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 1.0,
                          autoPlayInterval:
                              Duration(seconds: (rnd.nextInt(5) + 3)))),
                  const SizedBox(height: 4),
                  Center(
                    child: Text(
                      isimBaslik,
                      style: TextStyle(
                          fontSize: context.width / 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
        );
}
