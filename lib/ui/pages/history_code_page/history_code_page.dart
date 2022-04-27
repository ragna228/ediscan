import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/code_bloc.dart';
import 'bloc/code_event.dart';
import 'bloc/code_state.dart';
import 'widgets/list_code_widget.dart';

class SecondPage extends StatelessWidget {

   const SecondPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("История сканов")),
      body: BlocBuilder<CodeBloc, CodeState>(
        builder: (BuildContext context, CodeState state) {
          if(state is CodeInitial){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is DataReady){
            context.read<CodeBloc>().add(GetData());
          }
          else if(state is GetDataState){
            if(state.codes.isNotEmpty) {
              return
                Container(
                  child: ListCodeWidget(state.codes),
                  margin: const EdgeInsets.only(bottom: 100),
                );
            }
            else{
              return placeHolder();
            }
          }
          return Container();
        }
      )
    );
  }

  Widget placeHolder(){
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "Пока еще ничего нет",
              style: TextStyle(fontSize: 25),
            )
          ],
        )
    );
  }
}
