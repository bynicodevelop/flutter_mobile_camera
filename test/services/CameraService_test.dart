import 'package:flutter_mobile_camera/CameraServiceException.dart';
import 'package:flutter_mobile_camera/getaway/Camera.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

main() {
  group('CameraService', () {
    test('Should called the cameraRender from CameraService', () async {
      // ARRANGE
      MockCameraGetaway cameraGetaway = MockCameraGetaway();

      CameraService cameraService = CameraService(cameraGetaway);

      // ACT
      cameraService.cameraRender();

      // ASSERT
      verify(cameraGetaway.cameraRender());
    });

    test('Should call the takePhoto from CameraService', () async {
      // ARRANGE
      MockCameraGetaway cameraGetaway = MockCameraGetaway();

      CameraService cameraService = CameraService(cameraGetaway);

      // ACT
      cameraService.takePhoto();

      // ASSERT
      verify(cameraGetaway.takePhoto());
    });

    test('Should expect an CameraServiceException', () async {
      // ARRANGE
      MockCameraGetaway cameraGetaway = MockCameraGetaway();

      when(cameraGetaway.takePhoto()).thenThrow(
        CameraServiceException(
          code: CameraServiceException.TAKE_PHOTO_ERROR,
        ),
      );

      CameraService cameraService = CameraService(cameraGetaway);

      // ACT & ASSERT
      expect(
        () async => await cameraService.takePhoto(),
        throwsA(
          allOf(
            isInstanceOf<CameraServiceException>(),
            predicate(
              (f) => f.code == CameraServiceException.TAKE_PHOTO_ERROR,
            ),
          ),
        ),
      );
    });

    test('Should call the changeCamera from CameraService', () async {
      // ARRANGE
      MockCameraGetaway cameraGetaway = MockCameraGetaway();

      CameraService cameraService = CameraService(cameraGetaway);

      // ACT
      cameraService.changeCamera();

      // ASSERT
      verify(cameraGetaway.changeCamera());
    });
  });
}

class MockCameraGetaway extends Mock implements CameraGetaway {}
