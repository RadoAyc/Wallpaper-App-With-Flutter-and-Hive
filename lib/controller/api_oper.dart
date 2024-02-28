import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:wallpaper_planet/model/category_model.dart';
import 'package:wallpaper_planet/model/photos_model.dart';

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> categoryModelList = [];
  static String _apiKey = "Your API";
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated'), headers: {
      "Authorization":
          "$_apiKey"
    }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      for (var element in photos) {
        trendingWallpapers.add(PhotosModel.fromAPI2App(element));
      }
    });
    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {
          "Authorization":
              "UjKm4y46GkceOATVXnszuTOXoYcisOvkBFhGU6fPDiIe8pM7gT7BdrVV"
        }).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();

      for (var element in photos) {
        searchWallpapersList.add(PhotosModel.fromAPI2App(element));
      }
    });
    return searchWallpapersList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List categoryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryModelList.clear();
    for (var catName in categoryName) {
      final random = Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + random.nextInt(11 - 0)];

      categoryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    }

    return categoryModelList;
  }
}
