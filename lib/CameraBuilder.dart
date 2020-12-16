import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/getaway/Camera.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CameraBuilder extends StatelessWidget {
  final Widget child;

  const CameraBuilder({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox.shrink();
        }

        CameraGetaway cameraGetaway = CameraGetaway(snapshot.data);

        return Provider(
          create: (context) => CameraService(
            cameraGetaway,
          ),
          child: child,
        );
      },
    );
  }
}
