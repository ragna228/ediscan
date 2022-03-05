import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp/ui/bottom/bottom.dart';
import 'package:pp/ui/bottom/bottom_bloc.dart';
import 'package:pp/ui/bottom/bottom_state.dart';
import 'package:pp/ui/pages/first_page/first_page.dart';
import 'package:pp/ui/pages/second_page/code_bloc.dart';
import 'package:pp/ui/pages/second_page/second_page.dart';



void main() => runApp(const CoreApp());

class CoreApp extends StatelessWidget{
  const CoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
        create: (context) => BottomNavigationBloc(),
        child: BlocProvider<CodeBloc>(
          create: (context) => CodeBloc(),
          child: const UIApp()
        ),
    );
  }
}

class UIApp extends StatelessWidget{
  const UIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AppScreen()
    );
  }

}

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Body(),
        bottomNavigationBar: BottomNav()
    );
  }
}

class Body extends StatelessWidget{
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (BuildContext context, BottomNavigationState state) {
        if (state is GetFirstPage) {
          return const FirstPage();
        }
        if (state is GetSecondPage) {
          return const SecondPage();
        }
        return Container();
      },
    );
  }

}