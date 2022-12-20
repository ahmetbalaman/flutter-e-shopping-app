import 'package:e_ticaret_uygulamasi/class/class_urun_model.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/screens/categori_page.dart';
import 'package:e_ticaret_uygulamasi/screens/product_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

String? aramaKismi;

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (arama) {
                setState(() {
                  aramaKismi = arama;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                hintText: "Arama",
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            StreamBuilder<DatabaseEvent>(
              stream: refUrunler.onValue,
              builder: (context, event) {
                if (event.hasData) {
                  var liste = <Urun>[];
                  var gelenDegerler = event.data?.snapshot.value as dynamic;
                  if (gelenDegerler != null) {
                    gelenDegerler.forEach((key, nesne) {
                      var gelenKisi = Urun.fromJson(key, nesne);
                      if (gelenKisi.urun_isim!
                          .toLowerCase()
                          .contains(aramaKismi.toString())) {
                        liste.add(gelenKisi);
                      }
                      if (aramaKismi == "") {
                        liste.clear();
                      }
                    });
                  }
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
                            navigate(context, ProductDetailPage(
                                      product: deger,
                                      whereCameFrom: "Kategori"));
                            return null;
                          }, deger: deger, context: context);
                        }),
                  );
                } else {
                  return const Center();
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
