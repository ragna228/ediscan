import 'package:permission_handler/permission_handler.dart';

abstract class BottomNavigationState {
  const BottomNavigationState();
}
class GetFirstPage extends BottomNavigationState {
  PermissionStatus status;

  GetFirstPage(this.status);
}

class GetSecondPage extends BottomNavigationState {
  GetSecondPage();
}

class GetHolder extends BottomNavigationState {
  GetHolder();
}
class AppStartedB extends BottomNavigationState{

}