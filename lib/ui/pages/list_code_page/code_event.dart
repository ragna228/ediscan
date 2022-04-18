part of 'code_bloc.dart';

class CodeEvent {
  const CodeEvent();
}

class AppStarted extends CodeEvent{
}

class GetData extends CodeEvent{
}


class Add extends CodeEvent{
  String text;
  String date;
  BarcodeFormat format;
  BarcodeType type;

  Add(this.text, this.date, this.format, this.type);
}