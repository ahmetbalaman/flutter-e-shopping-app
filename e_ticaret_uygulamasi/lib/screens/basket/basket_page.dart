import 'dart:async';
import 'dart:collection';

import 'package:e_ticaret_uygulamasi/components/alert_bar.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/label.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/screens/basket/basket_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../class/class_urun_model.dart';
import '../../class/shared_preferences.dart';
import '../../components/buttons.dart';
import '../home_page/home_page.dart';

class BasketPage extends StatefulWidget  {
   const BasketPage({Key? key}) : super(key: key);
  
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {

  Future<List<String>> kullaniciAl() async {
    List<String> deger = await SharedPreferAl.readList('girisBilgi');
    return deger;
  }

  Future<void> ekle({required key, required List<Urun> items}) async {
    int sira;
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.getString("siraNumarasi$key") == null) {
      sira = 1;
    } else {
      sira = int.parse(sp.getString("siraNumarasi$key")!);
    }

    DatabaseReference refSiparis =FirebaseDatabase.instance.ref("kisiler/$key/siparisler/Siparis $sira");

    var bilgi = HashMap<String, dynamic>();
    for (var i in items) {
      bilgi['urun_id'] = i.urun_id;
      bilgi['urun_isim'] = i.urun_isim;
      bilgi['urun_foto'] = i.urun_resim;
      bilgi['urun_fiyat'] = i.urun_fiyat;
      bilgi['urun_kategori'] = i.urun_kategori;
      await refSiparis.push().set(bilgi);
    }
    sira++;
    sp.setString("siraNumarasi$key", sira.toString());
    Items.items.clear();
    setState(() {});
  }
  void yenile(bool deger){
    if(deger==true){
      setState(() {
        
      });
    }
  }
Timer scheduleTimeout([int milliseconds = 10000]) =>
    Timer(Duration(milliseconds: milliseconds), handleTimeout);

void handleTimeout() {  // callback function
  setState(() {
    
  });
}

  var text = "Lütfen Ürün Ekleyiniz";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: buildBaslik(context, "Sepetiniz")),
            Items.items.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: context.height * 0.4,
                      ),
                      headStyle1(text, Colors.blue),
                    ],
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var deger = Items.items[index];
                              return basketList(context, deger,index);
                            },
                            itemCount: Items.items.length,
                          ),
                        ),
                        SizedBox(
                            height: context.height * 0.05,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Toplam Fiyat"),
                                Text(" ${Items.toplamFiyatGoster()} TL"),
                              ],
                            )),
                        FutureBuilder<List<String>>(
                          future: kullaniciAl(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> deger = snapshot.data!;
                              return buttonWidget1(context, "Sipariş Ver!",
                                  () {
                                    alertDailogAreYouSure(context, "Siparis vermekten emin misiniz?", () {
                                      
                                ekle(key: deger[0], items: Items.items);
                                snackBarGoster(
                                    context, "Şiparişiniz Alınmıştır");
                                text = "Siparisler kısmına eklenmiştir";
                                
                  Navigator.pop(context);
                  return null;
                                    },);
                                return null;
                              });
                            } else {
                              return const Center(
                                child: Text("Hata"),
                              );
                              
                            }
                          },
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
Widget basketList(BuildContext context, Urun deger,index) {
  return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
          height: context.height * 0.2,
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
              const SizedBox(width: 5,),
              Flexible(
                  child:
                      labelHead2("${deger.urun_isim}",)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("${deger.urun_fiyat.toString()} TL"),
                ],
              ),
                IconButton(onPressed: (){
                  alertDailogAreYouSure(context, "Ürünü silmekten emin misiniz?", () {
                  Items.items.removeAt(index);
                  snackBarGoster(context, "Silindi");
                  setState(() {    
                  });
                  Navigator.pop(context);
                  return null;
                  },);
                  }, icon: const Icon(Icons.delete),iconSize: context.height*0.04,)
            ],
          )));
}

}

/*
adet sayisi

 ,
              Row(
               
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              IconButton(onPressed: (){
                
                adet--;
                setState(() {
                  
                });
              }, icon: Icon(Icons.arrow_left_rounded,size: context.width*0.15,)),
              Text(Items.adet.toString()),
              IconButton(onPressed: (){
                 adet++;
                                 setState(() {
                  
                });
              }, icon: Icon(Icons.arrow_right_rounded,size: context.width*0.15,)),
                ],
              )

              */