import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CameraView extends StatefulWidget {
  final Function onBack;
  final Function(String) onTakePhoto;
  final Function(String) onSend;

  final String sendBtnLabel;
  final String publishingBtnLabel;

  const CameraView({
    Key key,
    @required this.onBack,
    @required this.onSend,
    @required this.onTakePhoto,
    this.sendBtnLabel = 'Send',
    this.publishingBtnLabel = 'Publishing...',
  }) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<CameraView> {
  CameraService cameraService;

  String _imagePath = '';
  bool _loading = false;

  @override
  void initState() {
    cameraService = Provider.of<CameraService>(context, listen: false);

    cameraService.refresh = () => setState(() => print('refreshing view...'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: _imagePath.isEmpty
            ? FlatButton(
                onPressed: widget.onBack,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )
            : FlatButton(
                onPressed: () => setState(() => _imagePath = ''),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: FutureBuilder(
                future: cameraService.isReady,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return SpinKitThreeBounce(
                      color: Colors.white,
                      size: 12.0,
                    );
                  }

                  return Transform.scale(
                    scale: cameraService.aspectRatio /
                        MediaQuery.of(context).size.aspectRatio,
                    child: AspectRatio(
                      aspectRatio: cameraService.aspectRatio,
                      child: _imagePath.isEmpty
                          ? cameraService.cameraRender()
                          : Image(
                              image: FileImage(
                                File(_imagePath),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: _imagePath.isEmpty,
              child: Positioned(
                bottom: 55.0,
                right: 55.0,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 3.0,
                      color: Colors.white,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: CircleBorder(),
                      onTap: cameraService.changeCamera,
                      child: Icon(
                        Icons.loop,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _imagePath.isNotEmpty,
              child: Positioned(
                bottom: 55.0,
                right: 20.0,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  onPressed: !_loading
                      ? () async {
                          setState(() => _loading = !_loading);

                          await widget.onSend(_imagePath);

                          setState(() => _imagePath = '');
                          setState(() => _loading = !_loading);
                        }
                      : null,
                  child: Row(
                    children: [
                      Text(
                        widget.sendBtnLabel,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _loading,
              child: Positioned(
                bottom: 65.0,
                left: 20.0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                    Text(
                      widget.publishingBtnLabel,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _imagePath.isEmpty,
        child: Container(
          margin: EdgeInsets.only(
            bottom: 30.0,
          ),
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3.0,
              color: Colors.white,
            ),
          ),
          child: FittedBox(
            child: FloatingActionButton(
              splashColor: Colors.white,
              onPressed: () async {
                String imagePath = await cameraService.takePhoto();

                setState(() => _imagePath = imagePath);

                widget.onTakePhoto(_imagePath);
              },
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
