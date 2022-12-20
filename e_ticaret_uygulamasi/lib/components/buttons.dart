

import 'package:e_ticaret_uygulamasi/constants/context_extension.dart';
import 'package:flutter/Material.dart';

import 'header.dart';

SizedBox buttonWidget1(
    BuildContext context, text, Function? Function() onClick) {
  return SizedBox(
    width: double.infinity,
    height: context.height / 12,
    child: ElevatedButton(
        onPressed: onClick, child: headStyle1(text, Colors.white)),
  );
}