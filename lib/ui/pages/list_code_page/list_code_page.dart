import 'package:EdiScan/core/dao/database_helper.dart';
import 'package:EdiScan/core/helper.dart';
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
              return
                Container(
                  child: ListCode(state.codes),
                  margin: const EdgeInsets.only(bottom: 100),
                );
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
    BarcodeType type = Helper.decodeType(code.formatData);
    return Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Helper.getIconFromType(type), color: Colors.black45, size: 30),
                const SizedBox(width: 20),
                Expanded(

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Helper.getStringFromType(type), style: const TextStyle(color: Colors.black, fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(code.value.length > 50 ? "${code.value.substring(0, 35)}..." : code.value, style: const TextStyle(color: Colors.black45, fontSize: 15)),
                      Text(code.date, style: const TextStyle(color: Colors.black45, fontSize: 15))

                    ],
                  )
                )
              ],
            ),
          ),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPage(code.value, code.date, code.formatCode, code.formatData)));
            context.read<BottomNavigationBloc>().add(PageTapped(index: 1));
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
    );
  }
}