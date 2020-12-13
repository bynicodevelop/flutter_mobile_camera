import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/Cameras.dart';
import 'package:flutter_mobile_camera/getaway/Camera.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CameraBuilder extends StatefulWidget {
  final Widget child;

  const CameraBuilder({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _CameraBuilderState createState() => _CameraBuilderState();
}

class _CameraBuilderState extends State<CameraBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: availableCameras(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SpinKitThreeBounce(
            color: Colors.white,
            size: 12.0,
          );
        }

        CameraGetaway cameraGetaway = CameraGetaway(snapshot.data);

        CameraService cameraService = CameraService(
          cameraGetaway,
        );

        return Cameras(
          cameraService: cameraService,
          child: Builder(
            builder: (context) => widget.child,
          ),
        );
      },
    );
  }
}
