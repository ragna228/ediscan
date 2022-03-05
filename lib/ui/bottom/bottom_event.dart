abstract class BottomNavigationEvent {
  const BottomNavigationEvent();
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({required this.index});
}