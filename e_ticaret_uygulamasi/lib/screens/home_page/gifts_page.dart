
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/screens/choose_item_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../class/class_urun_model.dart';
import '../../main.dart';
import '../categori_page.dart';
import '../product_detail_page.dart';

class GiftsPage extends StatefulWidget {
  const GiftsPage({Key? key}) : super(key: key);

  @override
  State<GiftsPage> createState() => _GiftsPageState();
}



class _GiftsPageState extends State<GiftsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerComponent(context, "Hediyeler", true),
          urunListele(refGifts,"Gifts"),
          addButton(context,"Gifts")
        ],
      ),
    );
  }



 
}
  StreamBuilder<DatabaseEvent> urunListele(DatabaseReference deger,String text) {
    return StreamBuilder<DatabaseEvent>(
            stream: deger.onValue,
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
                          navigate(context, ProductDetailPage(product: deger,whereCameFrom:text),);
                          return null;
                        }, deger: deger, context: context);
                      }),
                );
              } 
              else if(event.connectionState==ConnectionState.waiting){
   return const Center(
     child: CircularProgressIndicator(
       strokeWidth: 7,
     ),
   );
              }
              return const Center(child: Text("Şu anlık Bir ürün bulunamamaktadır."),);
            });
  }
 Widget addButton(BuildContext context,String text) {
    return Visibility(
      visible: adminGirdi,
            child: Card(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    navigate(context, AddItemPage(whereCameFrom: text));

                  }, icon: const Icon(Icons.add))
                ],
              ),
            ),
          ),
        ));
  }