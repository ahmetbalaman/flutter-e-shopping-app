import 'dart:collection';
import 'dart:io';
import 'package:e_ticaret_uygulamasi/components/snackbar_show.dart';
import 'package:e_ticaret_uygulamasi/screens/add_product/fire_storage_service.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../../main.dart';

class AddProductPageDetail extends StatefulWidget {
  const AddProductPageDetail({Key? key}) : super(key: key);

  @override
  State<AddProductPageDetail> createState() => AddProductPageDetailState();
}

UploadTask? task;
File? file;
TextEditingController isim = TextEditingController();
TextEditingController fiyat = TextEditingController();
TextEditingController aciklama = TextEditingController();
String kategori = "Kategori";

class AddProductPageDetailState extends State<AddProductPageDetail> {
  Future<void> _urunEkle(String isim, int fiyat, String aciklama,
      String kategori, String resim) async {
    var urun = HashMap<dynamic, dynamic>();
    urun["urun_id"] = "";
    urun["urun_isim"] = isim;
    urun["urun_fiyat"] = fiyat;
    urun["urun_aciklama"] = aciklama;
    urun["urun_kategori"] = kategori;
    urun["urun_foto"] = resim;
    refUrunler.push().set(urun);
  }

  Future _fotoYukle() async {
    final results = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg']);
    if (results == null) {
      return null;
    }
    final path = results.files.single.path!;
    setState(() => file = File(path));
  }

  Future _yuklemeBasla(String kategori) async {
    if (file == null) return;
    final fileName = basename(file!.path);
    final destination = 'urunler/$kategori/$fileName';
    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final indirmeLink = await snapshot.ref.getDownloadURL();
    _urunEkle(
        isim.text, int.parse(fiyat.text), aciklama.text, kategori, indirmeLink);
  }

  @override
  Widget build(BuildContext context) {
    double olcu = context.height * 0.08;
    final fileName = file != null ? basename(file!.path) : "Fotoğraf seçilmedi";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerComponent(context, "Ürün Ekleme", true),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: "Ürün isim"),
                      controller: isim,
                    ),
                    SizedBox(height: olcu),
                    TextField(
                      controller: aciklama,
                      decoration:
                          const InputDecoration(hintText: "Ürün Açıklama"),
                    ),
                    SizedBox(height: olcu),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: fiyat,
                      decoration: const InputDecoration(hintText: "Ürün Fiyat"),
                    ),
                    SizedBox(height: olcu),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Ürün Kategori:"),
                        popKategoriButon(context),
                      ],
                    ),
                    SizedBox(height: olcu),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Ürün Fotoğraf"),
                        ElevatedButton(
                            onPressed: _fotoYukle,
                            child: const Text("Foto yükle")),
                      ],
                    ),
                    Text(fileName),
                    task != null ? buildUploadTask(task!) : Container(),
                    SizedBox(
                      height: olcu,
                      width: olcu * 3,
                      child: ElevatedButton(
                          onPressed: () async {
                            await _yuklemeBasla(kategori);
                            isim.text = "";
                            aciklama.text = "";
                            fiyat.text = "";
                            kategori = "Kategoriler";
                            // ignore: use_build_context_synchronously
                            snackBarGoster(
                                context, "Ürününüz Başarıyla Yüklendi");

                            setState(() {});
                          },
                          child: const Text("Dosyayı Yükle")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<int> popKategoriButon(BuildContext context) {
    return PopupMenuButton(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(1)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              kategori,
              style: TextStyle(fontSize: context.width * 0.1),
            ),
            const Icon(Icons.arrow_downward_rounded),
          ],
        ),
      ),
      itemBuilder: (context) => const [
        PopupMenuItem(value: 1, child: Text("Bilgisayarlar")),
        PopupMenuItem(value: 2, child: Text("Aksesuarlar")),
        PopupMenuItem(value: 3, child: Text("Akıllı Telefonlar")),
        PopupMenuItem(value: 4, child: Text("Akıllı Cihazlar")),
        PopupMenuItem(value: 5, child: Text("Hoparlörler")),
      ],
      onSelected: (secilenKategori) {
        switch (secilenKategori) {
          case 1:
            setState(() {
              kategori = "Bilgisayarlar";
            });
            break;
          case 2:
            setState(() {
              kategori = "Aksesuarlar";
            });
            break;
          case 3:
            setState(() {
              kategori = "Akıllı Telefonlar";
            });
            break;
          case 4:
            setState(() {
              kategori = "Akıllı Cihazlar";
            });
            break;
          case 5:
            setState(() {
              kategori = "Hoparlörler";
            });
            break;
        }
      },
    );
  }
}

Widget buildUploadTask(UploadTask task) => StreamBuilder<TaskSnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percengte = (progress * 100).toStringAsFixed(2);
          return Text(
            '$percengte%',
            style: const TextStyle(color: Colors.blue, fontSize: 25),
          );
        } else {
          return Container();
        }
      },
      stream: task.snapshotEvents,
    );
