
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';



class FirebaseApi{
  static UploadTask? uploadFile(String destination,File file){
    try{
    final ref=FirebaseStorage.instance.ref(destination);
    return ref.putFile(file);
  }on FirebaseException {
    return null;
  }
  }
   static UploadTask? uploadBytes(String destination,Uint8List data){
    try{
    final ref=FirebaseStorage.instance.ref(destination);
    return ref.putData(data);
  }on FirebaseException {
    return null;
  }
  }
  
}


/*

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  //resim ekleme kısmı
  Future<void> uploadFile(context,String filePath, String? filename) async {
    File file=File(filePath);
    try{
      await _firebaseStorage.ref('test/$filename').putFile(file);
    }on FirebaseException catch(e){
    SnackBarGoster(context, "Fotoğraf Yüklenemedi");
    }
  }
  Future<ListResult> listFiles() async{
    ListResult results=await _firebaseStorage.ref('test').listAll();
    results.items.forEach((Reference ref) {
      print("Found file: $ref");
     });
    return results;
  }
  Future<String> downloadURL(String name) async{
    String downloadURL=await _firebaseStorage.ref('test/$name').getDownloadURL();
    return downloadURL;
  }
}


*/