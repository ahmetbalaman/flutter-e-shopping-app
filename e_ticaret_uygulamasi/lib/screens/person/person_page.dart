import 'package:e_ticaret_uygulamasi/components/navigate_components.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/add_product/add_product_page.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/home_page.dart';
import 'package:e_ticaret_uygulamasi/screens/login_screen.dart';
import 'package:e_ticaret_uygulamasi/screens/person/person_screens/my_information.dart';
import 'package:e_ticaret_uygulamasi/screens/person/person_screens/orders_page/all_orders_page.dart';
import 'package:e_ticaret_uygulamasi/screens/person/person_screens/orders_page/my_orders_page/my_orders_page.dart';
import 'package:flutter/material.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';

import '../../class/shared_preferences.dart';
import '../../components/alert_bar.dart';
import '../../main.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBaslik(context, "Profil"),
            // buildKategoriList(olcuGenislik, kategoriler: kategoriler),
            Expanded(
                child: ListView(
              children: [
                satirGetir(context, "Kişisel Bilgilerim", Icons.person, () {
                  navigate(context, const MyInformationPage());
                  return null;
                }),
                Visibility(
                  visible: adminGirdi,
                  child: satirGetir(context, "Ürün Ekle", Icons.add, () {
                    navigate(context, const AddProductPageDetail());
                    return null;
                  }),
                ),
                satirGetir(context, "Siparislerim", Icons.shopping_basket, () {
                  navigate(context, const MyOrdersPage());

                  return null;
                }),
                Visibility(
                  visible: adminGirdi,
                  child: satirGetir(context, "Bütün Siparisler",
                      Icons.shopping_basket_outlined, () {
                    navigate(context, const AllOrdersPage());

                    return null;
                  }),
                ),
                satirGetir(context, "Çıkış Yap", Icons.exit_to_app_rounded, () {
                  alertDailogAreYouSure(
                      context, "Çıkış yapmak istediğinizden emin misiniz?", () {
                    SharedPreferAl.saveBl('girisYapildi', false);
                    SharedPreferAl.saveStr('girisYapilanKisi', "");
                    adminGirdi = false;
                    snackBarGoster(context, "Başarıyla Çıkış yapıldı!");
                    navigateReplace(context, const LoginPage());
                    return null;
                  });

                  return null;
                }),
              ],
            )),
          ],
        ),
      )
    ])));
  }
}

Widget satirGetir(
    BuildContext context, text, IconData data, Function? Function() onTap) {
  return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: onTap,
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
          width: context.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: context.height / 35, fontWeight: FontWeight.w600),
              ),
              Icon(data)
            ],
          ),
        ),
      ));
}
