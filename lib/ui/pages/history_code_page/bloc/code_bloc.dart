import 'package:EdiScan/core/common_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:EdiScan/core/dao/database_helper.dart';
import '../../../../core/dao/entity/code.dart';
import 'code_event.dart';
import 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {

  CodeBloc() : super(CodeInitial()) {
    on<CodeEvent>((event, emit) async {
      if(event is AppStarted){
        emit(DataReady());
      }
      else if(event is Add){
        String text = Helper.getValueFromType(event.code);
        Code code = Code(null, text, event.date, Helper.getDisplayFormat(event.code.format), event.code.type.name);
        await DbHelper.daoCodeService().insert(code);
        emit(DataReady());
      }
      else if(event is GetData){
        emit(GetDataState(await DbHelper.daoCodeService().getAll()));
      }

    });

    add(AppStarted());
  }

}
