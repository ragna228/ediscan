


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Helper{
  static late DateFormat format = DateFormat("dd-MM-yyyy HH:mm:ss");

  static String convertFormatToLang(BarcodeFormat format){
    switch(format){
      case BarcodeFormat.dataMatrix:
        return "матрикс код";
      case BarcodeFormat.qrCode:
        return "qr код";
      case BarcodeFormat.codebar:
        return "баркод";
    }
    return format.name;
  }

  static String convertType(BarcodeType type){
    return type.toString();
  }

  static BarcodeType decodeType(String type){
    return BarcodeType.values.firstWhere((element) => element.toString() == type);
  }

  static IconData getIconFromType(BarcodeType type){
    switch(type){
      case BarcodeType.url:
        return Icons.link;
      case BarcodeType.email:
        return Icons.email;
    }
    return Icons.text_fields;
  }

  static String getStringFromType(BarcodeType type){
    switch(type){
      case BarcodeType.url:
        return "Веб-сайт";
      case BarcodeType.email:
        return "Email";
    }
    return "Текст";
  }

  static String getTextFromType(Barcode code){
    switch(code.type){
      case BarcodeType.url:
        return code.url!.url!;
      case BarcodeType.email:
        return code.email!.address!;
    }
    return code.rawValue!;
  }

}