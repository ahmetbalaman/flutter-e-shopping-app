import 'package:e_ticaret_uygulamasi/class/class_siparis_model.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/label.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/basket/basket_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'my_orders_page.dart';

// ignore: must_be_immutable
class MyOrdersDetailPage extends StatefulWidget {
  MyOrdersDetailPage({required this.siparisNo, Key? key}) : super(key: key);
  String? siparisNo;
  @override
  State<MyOrdersDetailPage> createState() => _MyOrdersDetailPageState();
}

class _MyOrdersDetailPageState extends State<MyOrdersDetailPage> {
  Future<void> siparisSil() async {
    refSiparis.child(widget.siparisNo.toString()).remove();
  }

  @override
  Widget build(BuildContext context) {
    int toplamfiyat = 0;
    DatabaseReference refSiparis = FirebaseDatabase.instance.ref("kisiler/${Items.key}/siparisler/${widget.siparisNo}");
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            headerComponent(context, widget.siparisNo, true),
            StreamBuilder<DatabaseEvent>(
                stream: refSiparis.onValue,
                builder: (context, event) {
                  var liste = <Siparis>[];
                  var gelenDeger = event.data?.snapshot.value as dynamic;
                  if (gelenDeger != null) {
                    gelenDeger.forEach((key, nesne) {
                      var gelenUrun = Siparis.fromJson(key, nesne);
                      liste.add(gelenUrun);
                    });
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: liste.length,
                                itemBuilder: (context, index) {
                                  var deger = liste[index];
                                  toplamfiyat += deger.urun_fiyat!;
                                  return Column(
                                    children: [
                                      SizedBox(
                                          child: basketList(context, deger)),
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                              height: context.height * 0.15,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text("Toplam Fiyat"),
                                      Text(" $toplamfiyat TL"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            alertGoster(context,
                                                "Siparis silmek istediğinizden emin misiniz?");
                                          },
                                          child: const Text("Siparis Sil")),
                                      ElevatedButton(
                                          onPressed: () {
                                            alertGoster(context,
                                                "Siparisiniz geldi mi?");
                                          },
                                          child: const Text("Siparisim Tamamlandı ")),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.3,
                        ),
                        Center(
                            child: headStyle1(
                                "Siparişiniz Bulunmamaktadır", Colors.blue)),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<dynamic> alertGoster(BuildContext context, text) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(text),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      siparisSil();
                    },
                    child: const Text("Evet")),

                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("Hayır")),
              ],
            )).then((value) => value ?? false);
  }
}

Widget basketList(BuildContext context, Siparis deger) {
  return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
          height: context.width * 0.2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(deger.urun_resim.toString()),
              ),
              Flexible(
                  child:labelHead2(deger.urun_isim)
                      
                      ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("${deger.urun_fiyat.toString()} TL")],
              )
            ],
          )));
}
