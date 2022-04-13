

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
          return BottomNavigationBar(
            currentIndex:
            context.select((BottomNavigationBloc bloc) => bloc.currentIndex),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.scanner, color: Colors.black),
                label: 'Сканер',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, color: Colors.black),
                label: 'История',
              ),
            ],
            onTap: (index) => context
                .read<BottomNavigationBloc>()
                .add(PageTapped(index: index)),
          );
        });
  }

}