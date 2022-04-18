import 'package:EdiScan/ui/bottom/bottom_event.dart';
import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom/bottom_navigation.dart';
import 'package:EdiScan/ui/bottom/bottom_state.dart';
import 'package:EdiScan/ui/pages/list_code_page/code_bloc.dart';
import 'package:EdiScan/ui/pages/scan_code_page/scan_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EdiScan/ui/pages/list_code_page/list_code_page.dart';
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
          create: (context) => CodeBloc(), child: const UIApp()
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
  FirstScannerPage firstScannerPage = FirstScannerPage();

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
              return ScannerPage();
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
      const BottomNav()
    ]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("assssssssssssssssss1: " + state.name);

    bloc.add(PageTapped(index: 0));
  }
}

