import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/getaway/Camera.dart';

class CameraService {
  final CameraGetaway cameraGetaway;

  const CameraService(this.cameraGetaway);

  double get aspectRatio => cameraGetaway.aspectRatio;

  set refresh(Function refresh) => cameraGetaway.refresh = refresh;

  Future<void> get isReady async => cameraGetaway.isReady;

  Future<String> takePhoto() async {
    return await cameraGetaway.takePhoto();
  }

  Future<void> changeCamera() async {
    await cameraGetaway.changeCamera();
  }

  Widget cameraRender() {
    return cameraGetaway.cameraRender();
  }
}
