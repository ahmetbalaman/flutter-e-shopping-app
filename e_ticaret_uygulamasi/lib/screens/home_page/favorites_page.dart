
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerComponent(context, "Favoriler", true),
          Column(children: [
            const SizedBox(height: 10,),
            Center(child: headStyle1("Favorileriniz Bulunamamaktadır.", Colors.blue),)
          ],)
        ],
      ),
    );
  }
}