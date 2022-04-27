import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:meta/meta.dart';

part 'display_code_event.dart';
part 'display_code_state.dart';

class DisplayCodeBloc extends Bloc<DisplayCodeEvent, DisplayCodeState> {
  DisplayCodeBloc() : super(DisplayCodeInitial()) {
    on<DisplayCodeEvent>((event, emit) async {
      if(event is Copy){
        Clipboard.setData(ClipboardData(text: event.data));
      }
      else if(event is Share){
        if(Uri.parse(event.data).isAbsolute) {
          await FlutterShare.share(title: "Поделитесь ссылкой", linkUrl: event.data, text: "ссылка");
        }
        else{
          await FlutterShare.share(title: "Поделитесь текстом", text: event.data);
        }
      }
    }
    );
  }
}
