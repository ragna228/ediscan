import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/common_helper.dart';
import '../../../../core/dao/entity/code.dart';
import '../../../bottom_navigation/bloc/bottom_bloc.dart';
import '../../../bottom_navigation/bloc/bottom_event.dart';
import '../../display_code_page/display_code_page.dart';

class ListCodeWidget extends StatelessWidget{
  List<Code> list;

  ListCodeWidget(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, pos)  {
          return itemCode(list[list.length - 1 - pos], context);
        }
    );
  }

  Widget itemCode(Code code, BuildContext context){
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
                      Text(code.value.length > 30 ? "${code.value.substring(0, 20)}..." : code.value, style: const TextStyle(color: Colors.black, fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(Helper.getDisplayStringFromType(type), style: const TextStyle(color: Colors.black45, fontSize: 15)),
                      Text(code.date, style: const TextStyle(color: Colors.black45, fontSize: 15))

                    ],
                  )
              )
            ],
          ),
        ),
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayCodePage(code.value, code.date, code.formatCode, code.formatData)));
          context.read<BottomNavigationBloc>().add(PageTapped(index: 1));
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}