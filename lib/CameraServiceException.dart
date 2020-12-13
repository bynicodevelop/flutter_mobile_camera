class CameraServiceException implements Exception {
  final String code;
  final String message;

  static const String TAKE_PHOTO_ERROR = 'take-photo-error';

  const CameraServiceException({this.code, this.message});
}
