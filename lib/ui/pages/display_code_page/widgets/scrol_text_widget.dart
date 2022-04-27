import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollTextWidget extends StatelessWidget{
  final String value;
  final bool isUrl;

  const ScrollTextWidget({required this.value,required this.isUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        constraints: const BoxConstraints(
            minHeight: 400,
            maxHeight: 400
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(value, style: TextStyle(fontSize: 21, color: (isUrl) ? Colors.blue : Colors.black), textAlign: TextAlign.center),
        )
    );
  }

}