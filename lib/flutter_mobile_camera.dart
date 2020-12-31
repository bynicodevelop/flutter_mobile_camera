import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/CameraBuilder.dart';
import 'package:flutter_mobile_camera/CameraView.dart';

class Camera extends StatelessWidget {
  final Function onBack;
  final Function(String) onTakePhoto;
  final Function(String) onSend;

  final String sendBtnLabel;
  final String publishingBtnLabel;

  const Camera({
    Key key,
    @required this.onBack,
    @required this.onSend,
    @required this.onTakePhoto,
    this.sendBtnLabel = 'Send',
    this.publishingBtnLabel = 'Publishing...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraBuilder(
      child: CameraView(
        // Lets go back !
        onBack: onBack,
        // When you want to recover the photo to send it to the cloud
        onSend: onSend,
        // Capture the photo taking event
        onTakePhoto: onTakePhoto,
      ),
    );
  }
}
