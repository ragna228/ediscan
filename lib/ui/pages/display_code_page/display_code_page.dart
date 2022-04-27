
import 'package:EdiScan/core/common_helper.dart';
import 'package:EdiScan/ui/pages/display_code_page/bloc/display_code_bloc.dart';
import 'package:EdiScan/ui/pages/display_code_page/widgets/action_item_widget.dart';
import 'package:EdiScan/ui/pages/display_code_page/widgets/scrol_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexagon/hexagon.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class DisplayCodePage extends StatelessWidget{
  String value;
  String date;
  String type;
  String codeType;

  DisplayCodePage(this.value, this.date,this.type,this.codeType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Значение")),
        body: Stack(
          children: [
            cardCode(value, date, type, codeType, context),
          ],
        )
      );
    }

    Widget cardCode(String value, String date, String type, String codeType, BuildContext context){
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              child:
              HexagonWidget.pointy(
                width: 80,
                color: Colors.black38,
                cornerRadius: 5,
                padding: 4.0,
                child: Icon(Helper.getIconFromType(Helper.decodeType(codeType)), size: 50, color: Colors.white)
              ),
              alignment: Alignment.center,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text("Дата скана: $date"),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.center,
              child: Text("тип данных: ${Helper.getDisplayStringFromType(Helper.decodeType(codeType))}"),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.center,
              child: Text("тип кода: ${type}"),
            ),
            Container(
              child: Align(
                child: ScrollTextWidget(value: value, isUrl: Helper.decodeType(codeType) == BarcodeType.url),
                alignment: Alignment.center,
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(left: 25, right: 25, bottom: 0),
                  child: Card(
                    color: Colors.black38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ActionItemWidget("Скопировать", Icons.copy, () {
                          context.read<DisplayCodeBloc>().add(Copy(value));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Скопировано в буфер обмена"),
                          ));

                        }),
                        ActionItemWidget("Поделиться", Icons.share, () {
                          context.read<DisplayCodeBloc>().add(Share(value));
                        }),
                      ],
                    ),
                  ),
                )
            )
          ]
        ),
        margin: const EdgeInsets.all(15),
      );
    }
}