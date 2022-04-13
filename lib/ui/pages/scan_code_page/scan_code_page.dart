import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom/bottom_event.dart';
import 'package:EdiScan/ui/pages/display_code_page/display_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/helper.dart';
import '../list_code_page/code_bloc.dart';

class FirstPage extends StatelessWidget {

  const FirstPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScannerPage()
    );
  }
}
class FirstPageWithPermission extends StatelessWidget {
  const FirstPageWithPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                const Text("для приложения нужно разрешение камеры"),
                MaterialButton(
                  onPressed: () async {
                    context.read<BottomNavigationBloc>().add(RequestChanged(permission: await Permission.camera.request()));
                  },
                  child: Card(
                      child: Container(
                        child: const Text("разрешить"),
                        padding: const EdgeInsets.all(10)
                      )
                  ),
                ),
              ],
            ),
          ]
        )
      ),
    );
  }
}

class FirstPagePermanent extends StatelessWidget with WidgetsBindingObserver{
  late BottomNavigationBloc bloc;

  FirstPagePermanent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc = context.read<BottomNavigationBloc>();
    WidgetsBinding.instance!.addObserver(this);
    return Scaffold(
      body: Center(
          child: Wrap(
              children: [
                Column(
                  children: [
                    const Text("камера навсегда запрещена :("),
                    MaterialButton(
                      onPressed: () async {
                        await openAppSettings();
                        },
                      child: Card(
                          child: Container(
                              child: const Text("открыть настройки"),
                              padding: const EdgeInsets.all(10)
                          )
                      ),
                    ),
                  ],
                ),
              ]
          )
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      bloc.add(PageTapped(index: 0));
    }
  }
  
}

class ScannerPage extends StatelessWidget{
  late MobileScannerController controller;

  ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = MobileScannerController(formats: [BarcodeFormat.all]);
    MobileScanner scanner = MobileScanner(allowDuplicates: false, onDetect:  (code, args) async{
      await controller.stop();
      String date = Helper.format.format(DateTime.now());
      context.read<CodeBloc>().add(Add(code.rawValue!, date, code.format));
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              DisplayPage(code.rawValue!, date, Helper.convertFormatToLang(code.format)
              )
          )
      );
      await controller.start();
    }, controller: controller);
    return Stack(
      children: [
        scanner,
        Container(
            color: Colors.black38,
            margin: const EdgeInsets.all(20),
            height: 50,
            child: Stack(
              children: [
                Align(
                  child: InkWell(
                    child: const Icon(Icons.wb_twighlight, size: 25, color: Colors.white),
                    onTap: () async {
                      await controller.toggleTorch();
                    },
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  child: Container(
                    child: InkWell(
                      child: const Icon(Icons.camera, size: 25, color: Colors.white),
                      onTap: () async {
                        await controller.switchCamera();
                      },
                    ),
                    margin: const EdgeInsets.only(left: 40),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Align(
                  child: Container(
                    child: InkWell(
                      child: const Icon(Icons.camera, size: 25, color: Colors.white),
                      onTap: () async {
                        await controller.switchCamera();
                      },
                    ),
                    margin: const EdgeInsets.only(right: 40),
                  ),
                  alignment: Alignment.centerRight,
                )
              ],
            )
        )
      ],
    );
  }
}