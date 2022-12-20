import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/categori_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';

  var refFilmler=FirebaseDatabase.instance.ref("urunler");
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> kategoriler = [
    "Hepsi",
    "Bilgisayarlar",
    "Aksesuarlar",
    "Akıllı Telefonlar",
    "Akıllı Cihazlar",
    "Hoparlörler"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerComponent(context, "Kategoriler", true),
                // buildKategoriList(olcuGenislik, kategoriler: kategoriler),
                Expanded(
                    child: ListView(
                  children: kategoriler
                      .map((String e) => buildKategoriList(
                            gidilecekSayfa: CategoriPage(kategoriIsim: e),
                            kategoriler: e,
                            context: context,
                          ))
                      .toList(),
                ))
              ],
            )));
  }
}

Widget buildKategoriList(
    {required Widget gidilecekSayfa,
    required String kategoriler,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () => navigate(context, gidilecekSayfa),
    child: Padding(
      padding: const EdgeInsets.only(top:16.0),
      child: Container(
        height: context.height / 12,
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
        child: FittedBox(
          fit: BoxFit.fitHeight,
          alignment: Alignment.topLeft,
          child: Text(
            kategoriler,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}
