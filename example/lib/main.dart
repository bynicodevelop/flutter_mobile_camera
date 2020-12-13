import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/camera.dart';
import 'package:flutter_mobile_camera/CameraBuilder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraBuilder(
        child: Camera(
          onBack: () => print('Back navigator'),
          onSend: (imagePath) => print(imagePath),
          onTakePhoto: (imagePath) => print(imagePath),
        ),
      ),
    );
  }
}
