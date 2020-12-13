import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';

class Cameras extends InheritedWidget {
  const Cameras({
    Key key,
    @required this.cameraService,
    @required Widget child,
  })  : assert(cameraService != null),
        assert(child != null),
        super(key: key, child: child);

  final CameraService cameraService;

  static Cameras of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Cameras>();
  }

  @override
  bool updateShouldNotify(Cameras oldCameras) =>
      cameraService != oldCameras.cameraService;
}
