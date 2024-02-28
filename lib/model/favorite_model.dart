import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject  {
   @HiveField(0)
  List<String> _favoriteImages = [];

  List<String> get favoriteImages => _favoriteImages;

  void addImage(String url) {
    _favoriteImages.add(url);
    save();
  }

  void removeImage(String url) {
    _favoriteImages.remove(url);
    save();
  }

  bool containsImage(String url) {
    return _favoriteImages.contains(url);
  }
}