import 'package:e_ticaret_uygulamasi/components/label.dart';
import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/basket/basket_items.dart';
import 'package:e_ticaret_uygulamasi/screens/person/person_screens/my_information.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../../components/header.dart';
import '../../../../../main.dart';
import 'my_orders_detail_page.dart';


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({ Key? key}) : super(key: key);
  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}
int? sayi;
DatabaseReference refSiparis =
    FirebaseDatabase.instance.ref("kisiler/${Items.key}/siparisler");

class _MyOrdersPageState extends State<MyOrdersPage> {
 
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
            headerComponent(context, "Siparisler:", true),
            Align(alignment: Alignment.topRight,child: Visibility(visible: adminGirdi,child: IconButton(onPressed: () => navigate(context, const MyInformationPage()), icon: const Icon(Icons.person)))),


            StreamBuilder<DatabaseEvent>(
                stream: refSiparis.onValue,
                builder: (context, event) {
                  var liste =<String> [];
                  var gelenDeger = event.data?.snapshot.value as dynamic;
                  if (gelenDeger != null) {
                    gelenDeger.forEach((key,nesne) {
                      liste.add(key);
                    });
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
                                "Siparişiniz Bulunmamaktadır", Colors.blue))
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

Widget basketList(BuildContext context, String deger) {
  return GestureDetector(
    onTap: () {
      navigate(context, MyOrdersDetailPage(siparisNo: deger));
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                labelHead2(deger.toString()),
              ],
            ))),
  );
}
