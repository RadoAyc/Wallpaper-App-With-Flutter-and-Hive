import 'package:get/get.dart';

class FavoriteController extends GetxController {
  List<String> _favoriteImages = [];

  List<String> get favoriteImages => _favoriteImages;

  void addImage(String url) {
    _favoriteImages.add(url);
    update(); // Update the UI
  }

  void removeImage(String url) {
    _favoriteImages.remove(url);
    update(); // Update the UI
  }

  bool containsImage(String url) {
    return _favoriteImages.contains(url);
  }
}