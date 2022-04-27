
import 'package:mobile_scanner/mobile_scanner.dart';

class CodeEvent {
  const CodeEvent();
}

class AppStarted extends CodeEvent{
}

class GetData extends CodeEvent{
}


class ScanFileData extends CodeEvent{
  String data;

  ScanFileData(this.data);
}

class Add extends CodeEvent{
  Barcode code;
  String date;

  Add(this.code, this.date);
}