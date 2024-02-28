import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_planet/controller/api_oper.dart';
import 'package:wallpaper_planet/controller/favorite_controller.dart';
import 'package:wallpaper_planet/model/favorite_model.dart';
import 'package:wallpaper_planet/views/screens/full_screen.dart';

var box = Hive.box('hive');
var favoriteImages = box.get('favoriteImages', defaultValue: []);

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Images'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: favoriteImages.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreen(
                      imgUrl: favoriteImages[index],
                    ),
                  ),
                );
              },
              child: Hero(
                tag: favoriteImages[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GetX<FavoriteController>(builder: (controller) {
                    return Image.network(
                      favoriteImages[index],
                      fit: BoxFit.cover,
                    );
                  }),
                ),
              ));
        },
      ),
    );
  }
}
