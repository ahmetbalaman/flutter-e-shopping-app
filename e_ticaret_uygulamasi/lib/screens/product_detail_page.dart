// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:e_ticaret_uygulamasi/class/class_urun_model.dart';
import 'package:e_ticaret_uygulamasi/components/alert_bar.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import '../../main.dart';

import '../components/buttons.dart';
import '../main.dart';
import 'basket/basket_items.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  Urun product;
  String whereCameFrom;
  ProductDetailPage({
    Key? key,
    required this.product,
    required this.whereCameFrom,
  }) : super(key: key);
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  IconData favoriIcon = Icons.favorite_border_outlined;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: headerComponent(
                        context, widget.product.urun_isim, true)),
                Row(
                  children: [
                    Visibility(
                      visible: adminGirdi,
                      child: IconButton(
                        onPressed: () {
                          alertDailogAreYouSure(context,
                              "Ürünü silmek istediğinizden emin misiniz?", () {
                            if (widget.whereCameFrom == "Kategori") {
                              refUrunler
                                  .child(widget.product.urun_id.toString())
                                  .remove();
                            } else if (widget.whereCameFrom == "Gifts") {
                              refGifts
                                  .child(widget.product.urun_id.toString())
                                  .remove();
                            }else if (widget.whereCameFrom == "MostSells") {
                                  refSell.child(widget.product.urun_id.toString())
                                  .remove();
                            }else if (widget.whereCameFrom == "reklam") {
                                  refReklam.child(widget.product.urun_id.toString())
                                  .remove();
                            }
                            Navigator.pop(context, true);
                            Navigator.pop(context, true);
                            return null;
                          });
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.blue.shade700,
                        iconSize: context.height * 0.04,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (favoriIcon == Icons.favorite) {
                          favoriIcon = Icons.favorite_border_outlined;
                          snackBarGoster(context, "Favorilere Çıkarıldı!");
                        } else {
                          favoriIcon = Icons.favorite;
                          snackBarGoster(context, "Favorilere Eklendi!");
                        }

                        setState(() {});
                      },
                      icon: Icon(favoriIcon),
                      color: Colors.blue.shade700,
                      iconSize: context.height * 0.04,
                    ),
                  ],
                )
              ],
            ), //Eşyalar kısmı
            SizedBox(height: context.height * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView(
                  children: [
                    SizedBox(height: context.height * 0.01),
                    FadeInImage.assetNetwork(
                        placeholder: "assets/loading.gif",
                        image: widget.product.urun_resim!),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        headStyle1("Ürün Fiyat", Colors.black),
                        headStyle1("${widget.product.urun_fiyat.toString()} TL",
                            Colors.blue),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    headStyle1("Ürün Açıklaması", Colors.black),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.product.urun_aciklama!,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Center(
                      child: buttonWidget1(context, "Sepete Ekle!", () {
                        Items.items.add(widget.product);
                        snackBarGoster(context,
                            "${widget.product.urun_isim} Sepete Eklendi");
                        return null;
                      }),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          ])),
    ])));
  }
}
