import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/dao/database_helper.dart';
import 'bottom_event.dart';
import 'bottom_state.dart';


class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() :
        super(AppStartedB()){
    on<BottomNavigationEvent>((event, emit) => emitter(event, emit));
    add(Init());
  }

  int currentIndex = 0;

  void emitter(BottomNavigationEvent event, Emitter<BottomNavigationState> emit) async {
    if (event is PageTapped) {
      if(currentIndex != event.index) {
        currentIndex = event.index;
        if (currentIndex == 0) {
          emit(GetFirstPage(await Permission.camera.status));
        }
        else if (currentIndex == 1) {
          emit(GetSecondPage());
        }
      }
    }
    else if(event is RequestChanged){
      emit(GetFirstPage(event.permission));
    }
    else if(event is Init){
      await DbHelper.init();
      emit(GetFirstPage(await Permission.camera.status));
    }
  }
}