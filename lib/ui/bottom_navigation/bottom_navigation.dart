

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bottom_bloc.dart';
import 'bloc/bottom_event.dart';
import 'bloc/bottom_state.dart';

class BottomNavigation extends StatelessWidget{
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          return Align(
              alignment: const Alignment(0, 0.96),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                margin: const EdgeInsets.only(right: 20, left: 20),
                color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: bottomItem(data: "Сканер", iconData: Icons.scanner, ind: 0, isCard: state is GetFirstPage, context:  context, right: true)
                    ),
                    Expanded(
                        child:
                        bottomItem(data: "История", iconData: Icons.history, ind: 1, isCard: state is GetSecondPage, context: context, right: false)),
                  ],
                ),
              ));
        });
  }

  Widget bottomItem({required String data, required IconData iconData, required int ind, required bool isCard, required BuildContext context, required bool right}){
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
    BorderRadius r = right ? const BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)) :
    const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5));
    return InkWell(
        borderRadius: r,
        child: isCard ? Card(
          margin: const EdgeInsets.all(10),
          color: Colors.black12,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5)
            ),
            child: c,
          ),
        ) : Container(
          margin: const EdgeInsets.all(10),
          color: Colors.transparent,
          child: c,
        ),
        onTap: () {
          context.read<BottomNavigationBloc>().add(PageTapped(index: ind));
        }
    );
  }

}