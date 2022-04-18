
import 'package:EdiScan/core/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class DisplayPage extends StatelessWidget{
  String value;
  String date;
  String type;
  String codeType;

  DisplayPage(this.value, this.date,this.type,this.codeType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Значение")),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CardPage(value, date, type, codeType),
            )
          ],
        )
      );
    }
}
class CardPage extends StatelessWidget{
  String value;
  String date;
  String type;
  String codeType;

  CardPage(this.value, this.date,this.type,this.codeType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Stack(
          children: [
            Container(
              child: Card(
                  elevation: 12,  // Change this
                  shadowColor: Colors.black,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Panel(date, value, type, Helper.decodeType(codeType))
              ),
              margin: const EdgeInsets.only(top: 30),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Card(
                  elevation: 4,  // Change this
                  shadowColor: Colors.black,  // Change this
                  child: Container(
                    child: Text(Helper.getStringFromType(Helper.decodeType(codeType)), style: const TextStyle(fontSize: 17)),
                    margin: const EdgeInsets.all(10),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

}
class ScrollText extends StatelessWidget{
  String value;
  bool url = true;

  ScrollText(this.value, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      constraints: const BoxConstraints(
        minHeight: 20,
        maxHeight: 200
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(value, style: TextStyle(fontSize: 17, color: (url) ? Colors.blue : Colors.black), textAlign: TextAlign.center),
      )
    );
  }

}
class ItemP extends StatelessWidget{
  String value;
  BarcodeType type;
  ItemP(this.value, this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case BarcodeType.url:
        return InkWell(child: ScrollText(value, true),
            onTap: () => launch(value));
      case BarcodeType.text:
        return ScrollText("Значение: $value", false);
      case BarcodeType.email:
        return InkWell(child: ScrollText(value, true),
            onTap: () => launch("mailto:$value"));
    }
    return Container();
  }
  
}
class Panel extends StatelessWidget{
  String date, value, type;
  BarcodeType typeCode;

  Panel(this.date, this.value, this.type, this.typeCode);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        ItemP(value, typeCode),
        const SizedBox(height: 30),
        Text("Дата скана: $date", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 30),
        Text("Тип кода: $type", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 15),
        Container(height: 0.7, color: Colors.black38, margin: const EdgeInsets.only(right: 30, left: 30)),
        const SizedBox(height: 15),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Item("Копировать", Icons.copy, () async {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Скопировано в буфер обмена"),
                ));
              }),
              Item("Поделиться", Icons.share, () async {
                  if(Uri.parse(value).isAbsolute) {
                    await FlutterShare.share(title: "Поделитесь ссылкой", linkUrl: value, text: "ссылка");
                  }
                  else{
                    await FlutterShare.share(title: "Поделитесь текстом", text: value);
                  }
                }
              )
            ],
          ),
          margin: const EdgeInsets.only(left: 20, right: 20),
        ),
        const SizedBox(height: 30),
      ],
    );
  }


}
class Item extends StatelessWidget{

  String value;
  IconData data;
  VoidCallback function;

  Item(this.value, this.data, this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(data),
                const SizedBox(height: 10),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          onTap: function,
        )
    );
  }

}