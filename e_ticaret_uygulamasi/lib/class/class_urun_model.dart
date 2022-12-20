class Urun {
  String? urun_id;
  String? urun_isim;
  String? urun_kategori;
  int? urun_fiyat;
  String? urun_aciklama;
  String? urun_resim;
  //List<UrunFotograf> fotograflar;
  Urun(this.urun_id, this.urun_isim, this.urun_kategori, this.urun_fiyat,
      this.urun_aciklama, this.urun_resim);
  factory Urun.fromJson(key, Map<dynamic, dynamic> json) {
   // List jsonArray = json["fotograflar"];
   // List<UrunFotograf> urunFotograflar =jsonArray.map((e) => UrunFotograf.fromJson(e)).toList();
    return Urun(key, json["urun_isim"] as String, json["urun_kategori"]as String, json["urun_fiyat"]as int , json["urun_aciklama"]as String,
     json["urun_foto"] as String );
  }
}
class UrunReklam {
String? urun_id;
  String? urun_isim;
  String? urun_kategori;
  int? urun_fiyat;
  String? urun_aciklama;
  String? urun_resim;
  UrunReklam(this.urun_id, this.urun_isim, this.urun_kategori, this.urun_fiyat,
      this.urun_aciklama, this.urun_resim);
  factory UrunReklam.fromJson(key, Map<dynamic, dynamic> json) {
    return UrunReklam(key, json["urun_isim"] as String, json["urun_kategori"]as String, json["urun_fiyat"]as int , json["urun_aciklama"]as String,
     json["urun_foto"] as String );
  }
}
/*
class UrunKategori{
  String? kategori_id;
  String? kategori_ad;
  UrunKategori(this.kategori_id, this.kategori_ad);
  factory UrunKategori.fromJson(String key,Map<dynamic, dynamic> json) {
    return UrunKategori(
        key, json["kategori_ad"] as String);
  }
}
class UrunFotograf {
  String? urun_fotograf1;
  String? urun_fotograf2;
  String? urun_fotograf3;
  UrunFotograf(this.urun_fotograf1, this.urun_fotograf2, this.urun_fotograf3);
  factory UrunFotograf.fromJson(Map<dynamic, dynamic> json) {
    return UrunFotograf(json["urun_fotograf1"] as String,
        json["urun_fotograf2"] as String, json["urun_fotograf3"] as String);
  }
}*/


