
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/screens/home_page/gifts_page.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class MostSellsPage extends StatefulWidget {
  const MostSellsPage({Key? key}) : super(key: key);

  @override
  State<MostSellsPage> createState() => _MostSellsPageState();
}
class _MostSellsPageState extends State<MostSellsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerComponent(context, "En Çok satılanlar", true),
          urunListele(refSell,"MostSells"),
          addButton(context, "MostSells"),
        ],
      ),
    );
  }
}