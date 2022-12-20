
import 'package:flutter/material.dart';

Widget label(text){
   return Text(
        "$text",
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.blue.shade100),
      );
}

Widget labelHead2(text){
   return Text(
        text,
        style:const TextStyle(
            color: Colors.blue,
          fontSize: 20,
            fontWeight: FontWeight.bold,
        )
      );
}
