/*import 'package:e_ticaret_uygulamasi/class/storage_service.dart';
import 'package:e_ticaret_uygulamasi/components/header.dart';
import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:e_ticaret_uygulamasi/screens/login_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => AddProductPageState();
}

String? fotoisim = 'IMG_20220727_211502.jpg';
TextEditingController isim = TextEditingController();
TextEditingController fiyat = TextEditingController();

class AddProductPageState extends State<AddProductPage> {
  StorageService storage = StorageService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderComponent(context, "Foto", true),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    final results = await FilePicker.platform
                                        .pickFiles(
                                            allowMultiple: false,
                                            type: FileType.custom,
                                            allowedExtensions: [
                                          'png',
                                          'jpg',
                                          'jpeg'
                                        ]);
                                    if (results == null) {
                                      SnackBarGoster(context,
                                          "Dosya uzantısı desteklemiyor");
                                      return null;
                                    }
                                    final path = results.files.single.path!;

                                    final name = results.files.single.name;
                                    print(name);
                                    print(path);
                                    storage
                                        .uploadFile(context,path, name)
                                        .then((value) => print("Done"));
                                    Navigator.pop(context);
                                  },
                                  child: Text("Kaydet"))
                            ],
                            content: SizedBox(
                              height: context.height / 3,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: isim,
                                  ),
                                  TextField(
                                    controller: fiyat,
                                  ),
                                ],
                              ),
                            ),
                            title: Text("İnfo"),
                          );
                        });
                  },
                  child: Text("Dosya yükle")),
              FutureBuilder(
                future: storage.listFiles(),
                builder:
                    (BuildContext context, AsyncSnapshot<ListResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    var deger = snapshot.data!;
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.5
                                  ),
                          itemCount: deger.items.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future:
                                  storage.downloadURL(deger.items[index].name),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  var deger = snapshot.data!;
                                  return Container(
                                    width: context.width,
                                    height: context.height / 2,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.25),
                                              offset: const Offset(0, 4),
                                              blurRadius: 4)
                                        ]),
                                    child: Column(
                                      children: [
                                        Image.network(deger),
                                        Text(isim.text),
                                        Text(fiyat.text)
                                      ],
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting &&
                                    !snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                return Container();
                              },
                            );
                          }),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Center();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

                      // urunEkle(isim.text, int.parse(fiyat.text), aciklama.text);
                      /* try {
                        storage
                            .uploadFile(context, path, name)
                            .then((value) => print("Done"));
                      } catch (e) {
                        SnackBarGoster(context, "Bir hata oluştu");
                      }*/

*/