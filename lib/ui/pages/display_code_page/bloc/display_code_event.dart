part of 'display_code_bloc.dart';

@immutable
abstract class DisplayCodeEvent {}

class Share extends DisplayCodeEvent {
  String data;
  Share(this.data);
}

class Copy extends DisplayCodeEvent{
  String data;
  Copy(this.data);
}
