
import 'package:flutter/Material.dart';

ScaffoldFeatureController snackBarGoster(BuildContext context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
      backgroundColor: Colors.white,
      content: Text(message,
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))));
}
