
import 'package:flutter/Material.dart';

Future<dynamic> alertDailogAreYouSure(BuildContext context,text,Function? Function() func) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(text),
              actions: [
                TextButton(
                    onPressed: func,
                    child: const Text("Evet")),
                TextButton(
                    onPressed: () {
Navigator.pop(context, false);
                    },
                    child: const Text("Hayır")),
              ],
            ));
  }
  
  textBoxluAlertDialog(
      BuildContext context, text,TextEditingController sifre, Function? Function() onClick) {
        sifre.text="";
    return showDialog(

        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              text,
              style: const TextStyle(color: Colors.blue),
            ),
            content: TextField(
              obscureText: true,
              controller: sifre,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Vazgeç")),
              TextButton(onPressed: onClick, child: const Text("Gir")),
            ],
          );
        });
  }