import 'package:EdiScan/core/dao/database_helper.dart';
import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom/bottom_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EdiScan/core/dao/entity/code.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../display_code_page/display_code_page.dart';
import 'code_bloc.dart';

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
              return ListCode(state.codes);
            }
            else{
              return const PlaceHolder();
            }
          }
          return Container();
        }
      )
    );
  }
}


class PlaceHolder extends StatelessWidget{
  const PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class ListCode extends StatelessWidget{
  List<Code> list;

  ListCode(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, pos)  {
          return ItemCode(list[list.length - 1 - pos]);
        }
    );
  }
}

class ItemCode extends StatelessWidget{
  Code code;

  ItemCode(this.code);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      "тип: ${code.format}",
                      textAlign: TextAlign.center
                    ),
                    flex: 2
                ),
                Expanded(
                    child: Text(
                        code.date,
                        textAlign: TextAlign.center
                    ),
                    flex: 2
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                      code.value.length > 100 ? "${code.value.substring(0,100)}..." : code.value,
                      textAlign: TextAlign.center
                    ),
                    flex: 3
                ),
              ],
            ),
          ),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPage(code.value, code.date, code.format)));
            context.read<BottomNavigationBloc>().add(PageTapped(index: 1));
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
    );
  }
}