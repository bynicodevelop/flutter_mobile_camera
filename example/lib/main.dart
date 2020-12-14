import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/flutter_mobile_camera.dart';
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
      // To initialize camera mobile
      home: CameraBuilder(
        // Display the camera in the app
        child: Camera(
          // Lets go back !
          onBack: () => print('Back navigator'),
          // When you want to recover the photo to send it to the cloud
          onSend: (imagePath) => print(imagePath),
          // Capture the photo taking event
          onTakePhoto: (imagePath) => print(imagePath),
        ),
      ),
    );
  }
}
