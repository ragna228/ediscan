import 'package:EdiScan/ui/bottom_navigation/bloc/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom_navigation/bloc/bottom_event.dart';
import 'package:EdiScan/ui/bottom_navigation/bloc/bottom_state.dart';
import 'package:EdiScan/ui/bottom_navigation/bottom_navigation.dart';
import 'package:EdiScan/ui/pages/display_code_page/bloc/display_code_bloc.dart';
import 'package:EdiScan/ui/pages/history_code_page/bloc/code_bloc.dart';
import 'package:EdiScan/ui/pages/scan_code_page/first_scan_code_page.dart';
import 'package:EdiScan/ui/pages/scan_code_page/scan_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EdiScan/ui/pages/history_code_page/history_code_page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const CoreApp());
}

class CoreApp extends StatelessWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
      child: BlocProvider<CodeBloc>(
          create: (context) => CodeBloc(),
          child: BlocProvider<DisplayCodeBloc>(
            create: (context) => DisplayCodeBloc(),
            child: const UIApp(),
          )
      )
    );
  }
}

class UIApp extends StatelessWidget {
  const UIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AppScreen());
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Body()
        )
    );
  }
}

class Body extends StatelessWidget with WidgetsBindingObserver {

  late BottomNavigationBloc bloc;
  FirstScanCodePage firstScannerPage = const FirstScanCodePage();

  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addObserver(this);
    bloc = context.read<BottomNavigationBloc>();
    return Stack(children: [
      BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is GetFirstPage) {
            if (state.status == PermissionStatus.granted) {
              return ScanCodePage();
            } else if (state.status == PermissionStatus.denied) {
              return firstScannerPage;
            } else if(state.status == PermissionStatus.permanentlyDenied){
              openAppSettings();
            }
          }
          if (state is GetSecondPage) {
            return const SecondPage();
          }
          return Container();
        },
      ),
      const BottomNavigation()
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    bloc.add(PageTapped(index: 0));
  }
}

