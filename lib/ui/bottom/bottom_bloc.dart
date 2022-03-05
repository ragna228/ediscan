
import 'package:flutter_bloc/flutter_bloc.dart';

import './bottom_state.dart';
import './bottom_event.dart';


class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() :
        super(GetFirstPage()){
    on<PageTapped>((event, emit) => emitter(event, emit));
  }

  int currentIndex = 0;

  void emitter(BottomNavigationEvent event, Emitter<BottomNavigationState> emit) {
    if (event is PageTapped) {
      currentIndex = event.index;
      if (currentIndex == 0) {
        emit(GetFirstPage());
      }
      else if(currentIndex == 1){
        emit(GetSecondPage());
      }
    }
  }
}