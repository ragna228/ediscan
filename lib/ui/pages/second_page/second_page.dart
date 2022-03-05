import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp/core/dao/entity/code.dart';
import 'package:pp/ui/pages/second_page/code_bloc.dart';

class SecondPage extends StatelessWidget {

  const SecondPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CodeBloc, CodeState>(
        builder: (BuildContext context, CodeState state) {
          if(state is CodeInitial){
            return const Center(child: CircularProgressIndicator());
          }
          else if(state is DataReady){
            context.read<CodeBloc>().add(GetData());
          }
          else if(state is GetDataState){
            return ListCode(state.codes);
          }
          return Container();
        }
      )
    );
  }
}


class ListCode extends StatelessWidget{
  List<Code> list;

  ListCode(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, pos)  {
          return ItemCode(list[pos].id, list[pos].value);
        }
    );
  }
}

class ItemCode extends StatelessWidget{
  int? id;
  String value;

  ItemCode(this.id, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Text("номер: " + id.toString(), textAlign: TextAlign.center)),
              Expanded(child: Text("значение: " + value, textAlign: TextAlign.center)),
            ],
          ),
        )
    );
  }
}