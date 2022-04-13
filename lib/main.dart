import 'package:EdiScan/ui/bottom/bottom_event.dart';
import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
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
          create: (context) => CodeBloc(), child: const UIApp()),
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
    return const SafeArea(
        child: Scaffold(
      body: Body(),
    ));
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is GetFirstPage) {
            if (state.status == PermissionStatus.granted) {
              return const FirstPage();
            } else if (state.status == PermissionStatus.denied) {
              return const FirstPageWithPermission();
            } else if (state.status == PermissionStatus.permanentlyDenied) {
              return FirstPagePermanent();
            }
          }
          if (state is GetSecondPage) {
            return const SecondPage();
          }
          if (state is GetHolder) {
            return Container();
          }
          return Container();
        },
      ),
      Align(
          alignment: const Alignment(0, 0.96),
          child: Card(
            margin: const EdgeInsets.only(right: 20, left: 20),
            color: Colors.black45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: BottomItem(data: "Сканер", iconData: Icons.scanner, ind: 0)),
                Expanded(
                    child:
                        BottomItem(data: "История", iconData: Icons.history, ind: 1)),
              ],
            ),
          ))
    ]);
  }
}

class BottomItem extends StatelessWidget {
  String data;
  IconData iconData;
  int ind;

  BottomItem({Key? key, required this.data, required this.iconData, required this.ind}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Icon(iconData, color: Colors.white60),
            Text(data, style: const TextStyle(color: Colors.white60)),
            const SizedBox(height: 10)
          ]
      ),
      onTap: () {
        context.read<BottomNavigationBloc>().add(PageTapped(index: ind));
      }
    );
  }
}