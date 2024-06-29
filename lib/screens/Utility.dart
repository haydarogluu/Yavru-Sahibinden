import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Utility {
  static Image imageFromBase64String(String base64String,{double width = 100, double height = 100}) {
    return Image.memory(
      base64Decode(base64String),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }


  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
