import 'package:flutter/material.dart';

class ActionItemWidget extends StatelessWidget{

  String value;
  IconData data;
  VoidCallback function;

  ActionItemWidget(this.value, this.data, this.function, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(data, color: Colors.white60,),
                const SizedBox(height: 10),
                Text(value, style: const TextStyle(fontSize: 16, color: Colors.white60)),
              ],
            ),
          ),
          onTap: function,
        )
    );
  }

}