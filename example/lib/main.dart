import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/CameraBuilder.dart';
import 'package:flutter_mobile_camera/flutter_mobile_camera.dart';

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
      home: Builder(
        builder: (context) => Scaffold(
          body: Container(
            child: Center(
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraView(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraView extends StatelessWidget {
  const CameraView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('view');
    // To initialize camera mobile
    return CameraBuilder(
      // Display the camera in the app
      child: Camera(
        // Lets go back !
        onBack: () => print('Back navigator'),
        // When you want to recover the photo to send it to the cloud
        onSend: (imagePath) => print(imagePath),
        // Capture the photo taking event
        onTakePhoto: (imagePath) => print(imagePath),
      ),
    );
  }
}
