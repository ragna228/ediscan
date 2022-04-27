

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
                margin: const EdgeInsets.only(right: 20, left: 20),
                color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: bottomItem(data: "Сканер", iconData: Icons.scanner, ind: 0, isCard: state is GetFirstPage, context:  context)
                    ),
                    Expanded(
                        child:
                        bottomItem(data: "История", iconData: Icons.history, ind: 1, isCard: state is GetSecondPage, context: context)),
                  ],
                ),
              ));
        });
  }

  Widget bottomItem({required String data, required IconData iconData, required int ind, required bool isCard, required BuildContext context}){
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