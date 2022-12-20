import 'package:e_ticaret_uygulamasi/class/class_urun_model.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/product_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';

// ignore: must_be_immutable
class CategoriPage extends StatefulWidget {
  String? kategoriIsim;
  CategoriPage({Key? key, required this.kategoriIsim}) : super(key: key);

  @override
  State<CategoriPage> createState() => CategoriPageState();
}

class CategoriPageState extends State<CategoriPage> {
  void onItemTapped(int index) {
    setState(() {
      index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerComponent(context, widget.kategoriIsim, true),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<DatabaseEvent>(
              stream: (widget.kategoriIsim == "Hepsi")
                  ? refUrunler.onValue
                  : refUrunler
                      .orderByChild("urun_kategori")
                      .equalTo(widget.kategoriIsim)
                      .onValue,
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
                            navigate(context, ProductDetailPage(
                                      product: deger,
                                      whereCameFrom: "Kategori"));
                            
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
    ));
  }
}

Widget categoriItem(Function? Function() ontap,
    {required deger, required BuildContext context}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            color: Colors.black.withOpacity(0.008),
            offset: const Offset(0, 16),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(children: [
          Expanded(
            child: FadeInImage.assetNetwork(
                placeholder: "assets/loading.gif", image: deger.urun_resim),
          ),
          ListTile(
            title: Text(
              deger.urun_isim,
              style: TextStyle(
                  fontSize: context.width / 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${deger.urun_fiyat} TL",
              style: const TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    ),
  );
}


/*

  if(filtreSec==2){
                      
                      listeFiyat.add(gelenUrun.urun_fiyat!);
                    listeFiyat.sort();
                    print(listeFiyat);
                      for(int i in listeFiyat){
                        liste.add(gelenUrun);
                      }
                      print("2 seçildi");
                    }
                    if(filtreSec==3){
                      print("3 seçildi");
                    }
sıralama filtreleme çalışmsı



PopupMenuButton(
      child: Container(
        decoration: BoxDecoration(
              border: Border.all(width: 0.4),
              borderRadius: BorderRadius.circular(2)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
              Text(
                filtre,
                style: TextStyle(fontSize: context.width * 0.1),
              ),
          ],
        ),
      ),
      itemBuilder: (context) => const [
         PopupMenuItem(value: 1, child:  Text("Önerilen")),
         PopupMenuItem(value: 2, child:  Text("En Düşük Fiyat")),
         PopupMenuItem(value: 3, child:  Text("En Yüksek Fiyat")),
      ],
      onSelected: (secilenKategori) {
        switch (secilenKategori) {
          case 1:
              setState(() {
                filtre = "Önerilen";
                filtreSec=1;
              });
              break;
              case 2:
              setState(() {
                filtre = "En Düşük Fiyat";
                filtreSec=2;
              });
              break;
          case 3:
              setState(() {
                filtre = "En Yüksek Fiyat";
                filtreSec=3;
              });
              break;
        }
      },
    ),

    */