import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:flutter/material.dart';
Widget headerComponent(BuildContext context,text,bool active){
  return SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                        
                    Visibility(visible: active,child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: context.height / 18),
                      ),
                    ),
      ],
    ),
  );
}

Widget headStyle1(text, Color renk) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: renk,
      ),
    ),
  );
}