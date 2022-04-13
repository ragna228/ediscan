import 'package:permission_handler/permission_handler.dart';

abstract class BottomNavigationEvent {
  const BottomNavigationEvent();
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({required this.index});
}


class RequestChanged extends BottomNavigationEvent{
  final PermissionStatus permission;

  RequestChanged({required this.permission});
}

class Init extends BottomNavigationEvent{

}