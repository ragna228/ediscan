import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:EdiScan/ui/bottom/bottom_bloc.dart';
import 'package:EdiScan/ui/bottom/bottom_event.dart';
import 'package:EdiScan/ui/pages/display_code_page/display_code_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/helper.dart';
import '../list_code_page/code_bloc.dart';


class FirstScannerPage extends StatelessWidget{
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisSize: MainAxisSize.max,
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.camera_alt_outlined, size: 100, color: Colors.black45,),
                    const SizedBox(height: 20),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            child: const Text("Использовать камеру", textAlign: TextAlign.center, style: TextStyle(fontSize: 17))
                        ),
                        onTap: () async {
                          context.read<BottomNavigationBloc>().add(RequestChanged(permission: await Permission.camera.request()));
                        }
                      )
                    )
                  ],
                )
              ),
              margin: const EdgeInsets.only(bottom: 30),
            )
        ),
        Container(
          color: Colors.black38,
          height: 0.8,
          margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15)
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.all(15),
                child: Wrap(
                  children: [
                    InkWell(
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.image, color: Colors.black45),
                            SizedBox(width: 10),
                            Text("Использовать изображение")
                          ],
                        ),
                        margin: const EdgeInsets.all(15),
                      ),
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        MobileScannerController co = MobileScannerController();
                        co.barcodes.listen((event) async {

                          Barcode code = event;

                          String date = Helper.format.format(DateTime.now());
                          String text = Helper.getTextFromType(code);
                          context.read<CodeBloc>().add(Add(text, date, code.format, code.type));
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  DisplayPage(text, date, Helper.convertFormatToLang(code.format), Helper.convertType(code.type)
                                  )
                              )
                          );

                          await co.stop();
                        });
                        if(!await co.analyzeImage(image!.path)){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("На изображении нет кода"),
                          ));
                        }


                      },
                      borderRadius: BorderRadius.circular(15),
                    )
                  ],
                )
            )
        )
      ],
    );
  }

}
class ScannerPage extends StatelessWidget with WidgetsBindingObserver{
  late MobileScannerController controller;
  final ImagePicker _picker = ImagePicker();

  ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = MobileScannerController(formats: [BarcodeFormat.all]);

    MobileScanner scanner = MobileScanner(allowDuplicates: false, onDetect:  (code, args) async{
      await controller.stop();
      String date = Helper.format.format(DateTime.now());
      String text = Helper.getTextFromType(code);
      context.read<CodeBloc>().add(Add(text, date, code.format, code.type));
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              DisplayPage(text, date, Helper.convertFormatToLang(code.format), Helper.convertType(code.type)
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
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: controller.torchState,
                    builder: (context, state, child) {
                      switch (state as TorchState) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off, color: Colors.white);
                        case TorchState.on:
                          return const Icon(Icons.flash_on, color: Colors.white);
                      }
                    },
                  ),
                  iconSize: 30,
                  onPressed: () => controller.toggleTorch(),
                ),
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    color: Colors.white,
                    icon: ValueListenableBuilder(
                      valueListenable: controller.cameraFacingState,
                      builder: (context, state, child) {
                        switch (state as CameraFacing) {
                          case CameraFacing.front:
                            return const Icon(Icons.camera_front, color: Colors.white);
                          case CameraFacing.back:
                            return const Icon(Icons.photo_camera_back, color: Colors.white);
                        }
                      },
                    ),
                    iconSize: 30,
                    onPressed: () => controller.switchCamera(),
                  )
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Colors.white,
                      icon: const Icon(Icons.browse_gallery_outlined),
                      iconSize: 30,
                      onPressed: () async {
                        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        MobileScannerController co = MobileScannerController();
                        co.barcodes.listen((event) async {

                          Barcode code = event;

                          String date = Helper.format.format(DateTime.now());
                          String text = Helper.getTextFromType(code);
                          context.read<CodeBloc>().add(Add(text, date, code.format, code.type));
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  DisplayPage(text, date, Helper.convertFormatToLang(code.format), Helper.convertType(code.type)
                                  )
                              )
                          );
                          context.read<BottomNavigationBloc>().add(PageTapped(index: 0));


                          await co.stop();
                        });
                        if(!await co.analyzeImage(image!.path)){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("На изображении нет кода"),
                          ));
                        }
                      }
                    )
                )
              ],
            )
        )
      ],
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("assssssssssssssssss: " + state.name);
    controller.start();
  }
}