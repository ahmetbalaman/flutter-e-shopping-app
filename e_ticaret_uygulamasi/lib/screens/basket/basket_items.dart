import 'package:e_ticaret_uygulamasi/class/class_urun_model.dart';

class Items{
  static String key="";
  static List<Urun> items=[]; 
  static int toplamFiyatGoster(){
    var toplamfiyat=0;
    for(var i in items){
      toplamfiyat+=i.urun_fiyat!;
    }
    return toplamfiyat;
  }
}