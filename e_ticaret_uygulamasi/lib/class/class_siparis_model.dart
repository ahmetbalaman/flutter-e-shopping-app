
class Siparis{
  String? siparis_id;
  String? urun_id;
  String? urun_isim;
  String? urun_kategori;
  String? urun_resim;
  int? urun_fiyat;
  Siparis(this.siparis_id,this.urun_id,this.urun_isim,this.urun_kategori,this.urun_resim,this.urun_fiyat);
  factory Siparis.fromJson(key,Map<dynamic,dynamic> json){
    return Siparis(key,json["urun_id"] as String,json["urun_isim"] as String,json["urun_kategori"] as String,json["urun_foto"] as String,json["urun_fiyat"] as int);
  }
}
