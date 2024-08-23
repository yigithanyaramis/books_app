final class ImageAssetsConstants {
  const ImageAssetsConstants._();

  static String get logo => _toPng('logo');
  static String get book => _toPng('book');
  static String get user => _toPng('user');

  static String _toPng(String name) => 'assets/images/img_$name.png';
}
