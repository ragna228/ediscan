import 'package:EdiScan/ui/bottom/bottom_navigation.dart';
import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom/bottom_state.dart';
import 'package:EdiScan/ui/pages/list_code_page/code_bloc.dart';
import 'package:EdiScan/ui/pages/scan_code_page/scan_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EdiScan/ui/pages/list_code_page/list_code_page.dart';
import 'package:permission_handler/permission_handler.dart';



void main() {
  runApp(const CoreApp());
}

class CoreApp extends StatelessWidget{
  const CoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
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
    return SafeArea(
        child: Scaffold(
            body: const Body(),
            bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (BuildContext c, BottomNavigationState state){
                  if(state is AppStartedB) {
                    return Container();
                  }
                  else{
                    return const BottomNav();
                  }
                }
            )
        )
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
          if(state.status == PermissionStatus.granted) {
            return const FirstPage();
          }
          else if(state.status == PermissionStatus.denied){
            return const FirstPageWithPermission();
          }
          else if(state.status == PermissionStatus.permanentlyDenied){
            return FirstPagePermanent();
          }
        }
        if (state is GetSecondPage) {
          return const SecondPage();
        }
        if(state is GetHolder){
          return Container();
        }
        if(state is AppStartedB){
          return const Center(child: Image(image: AssetImage('assets/icon/icon.png'), width: 50, height: 50,));
        }
        return Container();
      },
    );
  }

}