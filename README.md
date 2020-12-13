# Flutter Mobile Camera

Add camera in your project.

## Getting Started

iOS
Add two rows to the ios/Runner/Info.plist:

one with the key Privacy - Camera Usage Description and a usage description.
and one with the key Privacy - Microphone Usage Description and a usage description.
Or in text format add the key:

```
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSMicrophoneUsageDescription</key>
<string>Can I use the mic please?</string>
```

Android
Change the minimum Android sdk version to 21 (or higher) in your android/app/build.gradle file.

```
minSdkVersion 21
```

## Example

```
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

```
