

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_bloc.dart';
import 'bottom_event.dart';
import 'bottom_state.dart';

class BottomNav extends StatelessWidget{
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          return Align(
              alignment: const Alignment(0, 0.96),
              child: Card(
                margin: const EdgeInsets.only(right: 20, left: 20),
                color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: BottomItem(data: "Сканер", iconData: Icons.scanner, ind: 0, isCard: state is GetFirstPage)
                    ),
                    Expanded(
                        child:
                        BottomItem(data: "История", iconData: Icons.history, ind: 1, isCard: state is GetSecondPage)),
                  ],
                ),
              ));
        });
  }

}
class BottomItem extends StatelessWidget {
  String data;
  IconData iconData;
  int ind;
  bool isCard;

  BottomItem({Key? key, required this.data, required this.iconData, required this.ind, required this.isCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Column c = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Icon(iconData, color: Colors.white60),
          Text(data, style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 10)
        ]
    );
    return InkWell(
        borderRadius: BorderRadius.circular(5),
        child: isCard ? Card(
          margin: const EdgeInsets.all(10),
          color: Colors.black12,
          child: c,
        ) : c,
        onTap: () {
          context.read<BottomNavigationBloc>().add(PageTapped(index: ind));
        }
    );
  }
}