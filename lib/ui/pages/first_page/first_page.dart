import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:pp/ui/bottom/bottom_bloc.dart';
import 'package:pp/ui/bottom/bottom_event.dart';
import 'package:pp/ui/pages/second_page/code_bloc.dart';

class FirstPage extends StatelessWidget {

  const FirstPage() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        child: const ScannerPage()
    );
  }
}

class ScannerPage extends StatelessWidget{

  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QRBarScannerCamera(
      onError: (context, error) =>
          Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red)
            )
          ),

          qrCodeCallback: (code) {
            context.read<CodeBloc>().add(Add(code.toString()));
            context.read<BottomNavigationBloc>().add(PageTapped(index: 1));
          },
    );
  }
}