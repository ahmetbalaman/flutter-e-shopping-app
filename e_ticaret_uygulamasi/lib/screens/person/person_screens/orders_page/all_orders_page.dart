import 'package:e_ticaret_uygulamasi/class/class_kisi_model.dart';
import 'package:e_ticaret_uygulamasi/components/label.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/basket/basket_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../components/alert_bar.dart';
import '../../../../components/header.dart';
import '../../../../main.dart';
import 'my_orders_page/my_orders_page.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

int? sayi;

class _AllOrdersPageState extends State<AllOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            headerComponent(context, "Kullanıcılar:", true),
            StreamBuilder<DatabaseEvent>(
                stream: refKisi.onValue,
                builder: (context, event) {
                  if (event.hasData) {
                    List<Kisi> liste = <Kisi>[];
                    var gelenDeger = event.data?.snapshot.value as dynamic;
                    if (gelenDeger != null) {
                      gelenDeger.forEach((key, nesne) {
                        var gelenKisi = Kisi.fromJson(key, nesne);
                        liste.add(gelenKisi);
                      });
                    }
                    return Expanded(
                      child: ListView.builder(
                          itemCount: liste.length,
                          itemBuilder: (context, index) {
                            var deger = liste[index];
                            return basketList(context, deger);
                          }),
                    );
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: context.height * 0.3,
                        ),
                        Center(
                            child: headStyle1(
                                "Kullanıcılar Bulunmamaktadır", Colors.blue))
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

Widget basketList(BuildContext context, Kisi deger) {
  return GestureDetector(
    onTap: () {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrdersPage(kisi: deger),));
      Items.key = deger.kullanici_id.toString();
      navigate(context, const MyOrdersPage());
     
    },
    child: Padding(
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                labelHead2(deger.ad_soyad),
                labelHead2(deger.telefon_no),
            IconButton(onPressed: (){
              alertDailogAreYouSure(context, "Kullanıcıyı silmek istediğinizden emin misiniz?", (){
                if(deger.e_posta=="admin"){
                  snackBarGoster(context, "Kendi Hesabınızı silemezsiniz.");
                    Navigator.pop(context,true);
                }else{
refKisi.child(deger.kullanici_id.toString()).remove();
                Navigator.pop(context,true);
              
                }
                return null;
                });

            }, icon: const Icon(Icons.delete),color: Colors.blue.shade700,iconSize: context.height*0.05,),
            
              ],
            ))),
  );
}
