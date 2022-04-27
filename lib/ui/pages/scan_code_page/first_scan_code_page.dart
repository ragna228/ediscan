
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/common_helper.dart';
import '../../bottom_navigation/bloc/bottom_bloc.dart';
import '../../bottom_navigation/bloc/bottom_event.dart';

class FirstScanCodePage extends StatelessWidget{
  const FirstScanCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        useCamera(context),
        Container(
            color: Colors.black38,
            height: 0.8,
            margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15)
        ),
        useImage(context)
      ],
    );
  }

  Widget useCamera(BuildContext context){
    return Expanded(
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
    );
  }
  Widget useImage(BuildContext context){
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(15),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            child: const Text("Использовать изображение", textAlign: TextAlign.center, style: TextStyle(fontSize: 17))
                        ),
                        onTap: () async {
                          final XFile? image = await Helper.imagePicker.pickImage(source: ImageSource.gallery);
                          if(!await Helper.getControllerFiles(context).analyzeImage(image!.path)){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("На изображении нет кода"),
                            ));
                          }
                        },
                      )
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.image_outlined, color: Colors.black45, size: 100),
                ],
              ),
              margin: const EdgeInsets.all(15),
            )
        )
    );
  }
}