import 'package:flutter_mobile_camera/Cameras.dart';
import 'package:flutter_mobile_camera/camera.dart';
import 'package:flutter_mobile_camera/services/CameraService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

main() {
  testWidgets('Background should be black', (WidgetTester tester) async {
    // ARRANGE
    MockCameraService cameraService = MockCameraService();

    when(cameraService.isReady).thenAnswer((_) => Future.value(true));

    await tester.pumpWidget(
      MaterialApp(
          title: 'Flutter Demo',
          home: Cameras(
            cameraService: cameraService,
            child: Camera(
              onBack: () => null,
              onSend: (path) => null,
              onTakePhoto: (path) => null,
            ),
          )),
    );

    // ACT
    final Container container =
        tester.firstWidget(find.byType(Container)) as Container;
    final Icon iconBack = tester.firstWidget(find.byType(Icon)) as Icon;

    final Finder backButton = find.byIcon(Icons.arrow_back);
    final Finder flipButton = find.byIcon(Icons.loop);
    final Finder takePhotoButton = find.byType(FloatingActionButton);

    final Finder sendButton = find.text('Send');

    // ASSERT
    expect(container.color, Colors.black);
    expect(iconBack.color, Colors.white);

    expect(backButton, findsOneWidget);
    expect(takePhotoButton, findsOneWidget);
    expect(flipButton, findsOneWidget);

    expect(sendButton, findsNothing);

    // verify(cameraService.cameraRender());
  });

  testWidgets('Should call back method', (WidgetTester tester) async {
    // ARRANGE
    bool methodCalled = false;
    MockCameraService cameraService = MockCameraService();

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Cameras(
          cameraService: cameraService,
          child: Camera(
            onBack: () => methodCalled = true,
            onSend: (path) => null,
            onTakePhoto: (path) => null,
          ),
        ),
      ),
    );

    // ACT
    final Finder backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);

    // ASSERT
    expect(methodCalled, true);
  });

  testWidgets('Should call onTakePhote method and changed state of plugin',
      (WidgetTester tester) async {
    // ARRANGE
    bool methodCalled = false;
    MockCameraService cameraService = MockCameraService();

    when(cameraService.isReady).thenAnswer((_) => Future.value(true));
    when(cameraService.aspectRatio).thenReturn(1.0);

    when(cameraService.takePhoto()).thenAnswer((_) => Future.value('/path'));

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Cameras(
          cameraService: cameraService,
          child: Camera(
            onBack: () => null,
            onSend: (path) => null,
            onTakePhoto: (_) => methodCalled = true,
          ),
        ),
      ),
    );

    // ACT
    final Finder takePhotoButton = find.byType(FloatingActionButton);
    await tester.tap(takePhotoButton);

    await tester.pumpAndSettle();

    final Finder flipButton = find.byIcon(Icons.loop);
    final Finder backButton = find.byIcon(Icons.arrow_back);
    final Finder closeButton = find.byIcon(Icons.close);
    final Finder sendButton = find.text('Send');

    // ASSERT
    expect(methodCalled, true);
    expect(backButton, findsNothing);
    expect(takePhotoButton, findsNothing);
    expect(flipButton, findsNothing);

    expect(closeButton, findsOneWidget);
    expect(sendButton, findsOneWidget);
  });

  testWidgets('Should can cancel photo', (WidgetTester tester) async {
    // ARRANGE
    MockCameraService cameraService = MockCameraService();

    when(cameraService.isReady).thenAnswer((_) => Future.value(true));
    when(cameraService.aspectRatio).thenReturn(1.0);
    when(cameraService.takePhoto()).thenAnswer((_) => Future.value('/path'));

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Cameras(
          cameraService: cameraService,
          child: Camera(
            onBack: null,
            onSend: (path) => null,
            onTakePhoto: (_) => null,
          ),
        ),
      ),
    );

    // ACT
    final Finder takePhotoButton = find.byType(FloatingActionButton);
    await tester.tap(takePhotoButton);

    await tester.pumpAndSettle();

    final Finder closeButton = find.byIcon(Icons.close);
    await tester.tap(closeButton);

    await tester.pumpAndSettle();

    final Finder backButton = find.byIcon(Icons.arrow_back);
    final Finder sendButton = find.text('Send');

    // ASSERT
    expect(closeButton, findsNothing);
    expect(sendButton, findsNothing);

    expect(backButton, findsOneWidget);
    expect(takePhotoButton, findsOneWidget);
  });

  testWidgets('Should can send photo and return path',
      (WidgetTester tester) async {
    // ARRANGE
    String methodCalled;

    MockCameraService cameraService = MockCameraService();

    when(cameraService.isReady).thenAnswer((_) => Future.value(true));
    when(cameraService.aspectRatio).thenReturn(1.0);
    when(cameraService.takePhoto()).thenAnswer((_) => Future.value('/path'));

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Cameras(
          cameraService: cameraService,
          child: Camera(
            onBack: () => null,
            onSend: (path) => methodCalled = path,
            onTakePhoto: (path) => null,
          ),
        ),
      ),
    );

    final Finder takePhotoButton = find.byType(FloatingActionButton);
    await tester.tap(takePhotoButton);

    await tester.pumpAndSettle();

    // ACT
    final Finder sendButton = find.text('Send');
    await tester.tap(sendButton);

    await tester.pumpAndSettle();

    // ASSERT
    expect(methodCalled, '/path');
    expect(sendButton, findsNothing);
  });

  testWidgets('Should can change camera', (WidgetTester tester) async {
    // ARRANGE
    MockCameraService cameraService = MockCameraService();

    when(cameraService.isReady).thenAnswer((_) => Future.value(true));
    when(cameraService.aspectRatio).thenReturn(1.0);

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Demo',
        home: Cameras(
          cameraService: cameraService,
          child: Camera(
            onBack: () => null,
            onSend: (path) => null,
            onTakePhoto: (_) => null,
          ),
        ),
      ),
    );

    // ACT
    final Finder flipButton = find.byIcon(Icons.loop);
    await tester.tap(flipButton);

    await tester.pumpAndSettle();

    // ASSERT
    verify(cameraService.changeCamera());
  });
}

class MockCameraService extends Mock implements CameraService {}
