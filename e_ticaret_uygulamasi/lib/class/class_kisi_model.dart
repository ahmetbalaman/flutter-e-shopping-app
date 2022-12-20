class Kisi{
  String? kullanici_id;
  String? ad_soyad;
  String? e_posta;
  String? telefon_no;
  String? sifre;
  String? adres;
  
  Kisi(this.kullanici_id,this.ad_soyad,this.e_posta,this.telefon_no,this.sifre,this.adres);
  factory Kisi.fromJson(key,Map<dynamic,dynamic> json){
    return Kisi(key,json["ad_soyad"] as String, json["e_posta"] as String, json["telefon_no"] as String, json["sifre"] as String, json["adres"] as String);
  }
}
/*
class Kisi{
  String? kullanici_id;
  String? ad_soyad;
  String? e_posta;
  String? telefon_no;
  String? sifre;
  String? adres;

  List<SiparisCevap> siparis;
  Kisi(this.kullanici_id,this.ad_soyad,this.e_posta,this.telefon_no,this.sifre,this.adres,this.siparis);
  factory Kisi.fromJson(key,Map<dynamic,dynamic> json){
    List jsonArray=json["siparisler"];
    List<SiparisCevap> kisilerListe=jsonArray.map((e) => SiparisCevap.fromJson(e)).toList();
    return Kisi(key,json["ad_soyad"] as String, json["e_posta"] as String, json["telefon_no"] as String,
     json["sifre"] as String, json["adres"] as String,kisilerListe );
  }
}
class SiparisCevap{
  String? siparis_say;
  SiparisCevap(this.siparis_say);
  factory SiparisCevap.fromJson(Map<String,String> json){
    return SiparisCevap(json["siparisler"] as String);
  }
}
*/