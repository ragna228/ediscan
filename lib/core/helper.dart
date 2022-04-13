


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
}