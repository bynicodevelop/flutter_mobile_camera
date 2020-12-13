import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/CameraServiceException.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' show join;

class CameraGetaway {
  final List<CameraDescription> cameras;

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  Function _refresh;
  int _index = 0;
  String _imagePath = '';

  CameraGetaway(
    this.cameras,
  ) {
    _refresh = () => null;
    _init();
  }

  Future<void> _init() async {
    await _setCamera(cameras[_index]);
  }

  Future<void> _setCamera(CameraDescription camera) async {
    if (_controller != null) {
      await _controller.dispose();
    }

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    // _controller.addListener(_refresh);

    if (_controller.value.hasError) {
      print('Camera Error ${_controller.value.errorDescription}');
    }

    _initializeControllerFuture = _controller.initialize();

    _refresh();
  }

  set refresh(Function refresh) => _refresh = refresh;

  Future<void> get isReady async => _initializeControllerFuture;

  double get aspectRatio => _controller.value.aspectRatio;

  Future<String> takePhoto() async {
    try {
      await _initializeControllerFuture;

      if (_imagePath.isNotEmpty && File(_imagePath).existsSync()) {
        await File(_imagePath).delete();
        _imagePath = '';
      }

      _imagePath = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      await _controller.takePicture(_imagePath);

      return _imagePath;
    } on CameraException {
      throw new CameraServiceException(
        code: CameraServiceException.TAKE_PHOTO_ERROR,
      );
    }
  }

  Future<void> changeCamera() async {
    _index = _index == 0 ? 1 : 0;

    await _setCamera(cameras[_index]);
  }

  Widget cameraRender() {
    return CameraPreview(_controller);
  }
}
