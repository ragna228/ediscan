import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pp/core/dao/db.dart';
import 'package:pp/core/dao/entity/code.dart';

part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {
  late AppDatabase database;

  CodeBloc() : super(CodeInitial()) {
    on<CodeEvent>((event, emit) async {
      if(event is AppStarted){
        database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
        emit(DataReady());
      }
      else if(event is Add){
        await database.codeDao.insertCode(Code(null, event.text));
        emit(DataReady());
      }
      else if(event is GetData){
        emit(GetDataState(await database.codeDao.getAll()));
      }
    });

    add(AppStarted());
  }

}
