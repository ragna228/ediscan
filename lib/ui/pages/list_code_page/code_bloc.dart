import 'package:EdiScan/core/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:EdiScan/core/dao/database_helper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/dao/entity/code.dart';
part 'code_event.dart';
part 'code_state.dart';

class CodeBloc extends Bloc<CodeEvent, CodeState> {

  CodeBloc() : super(CodeInitial()) {
    on<CodeEvent>((event, emit) async {
      if(event is AppStarted){
        emit(DataReady());
      }
      else if(event is Add){
        Code code = Code(null, event.text, event.date, Helper.convertFormatToLang(event.format), Helper.convertType(event.type));
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
