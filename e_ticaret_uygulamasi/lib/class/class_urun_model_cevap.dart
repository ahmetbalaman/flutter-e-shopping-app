
class UrunCevap{
  String? urun_id;
  String? urun_isim;
  String? urun_kategori;
  String? urun_aciklama;
  int? urun_fiyat;
  int? urun_adet;
  String? urun_resim;
  //List<UrunFotograf> fotograflar;
  UrunCevap(this.urun_id, this.urun_isim, this.urun_kategori,urun_aciklama, this.urun_fiyat,this.urun_adet,
      this.urun_resim);
/*
  factory UrunCevap.fromJson(key, Map<dynamic, dynamic> json) {
   // List jsonArray = json["fotograflar"];
   // List<UrunFotograf> urunFotograflar =jsonArray.map((e) => UrunFotograf.fromJson(e)).toList();
    return UrunCevap(key, json["urun_isim"] as String, json["urun_kategori"]as String, json["urun_fiyat"]as int ,json["urun_adet"]as int ,
     json["urun_foto"] as String );
  }
  */
}