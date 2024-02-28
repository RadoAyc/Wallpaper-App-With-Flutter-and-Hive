import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:provider/provider.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:wallpaper_planet/controller/api_oper.dart';
import 'package:wallpaper_planet/controller/favorite_controller.dart';
import 'package:wallpaper_planet/model/favorite_model.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
  
  FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}
  var box = Hive.box('hive');
  var favoriteImages = box.get('favoriteImages', defaultValue: []);
class _FullScreenState extends State<FullScreen> {


  Future<void> setWallpaper(String img, int location) async {
    try {
      var file = await DefaultCacheManager().getSingleFile(img);

      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enjoy your new Wallpaper"),
      ));
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoriteController>();
      return Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.wallpaper,
          activeIcon: Icons.close,
          overlayColor: Colors.black12,
          children: [
            SpeedDialChild(
              child: Icon(Icons.share),
              label: 'Set Wallpaper for both',
              onTap: () {
                // Share.shareXFiles([XFile(widget.imgUrl)],
                //     text: 'Check out this awesome Wallpaper');
              },
            ),
            SpeedDialChild(
              child: controller.containsImage(widget.imgUrl)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            label: 'Favorite',
            onTap: () {
               
               if (controller.containsImage(widget.imgUrl)) {
                // Remove the image from the favorite list
                controller.removeImage(widget.imgUrl);
                // Show a snackbar message
                Get.snackbar('Success', 'Image removed from favorites');
              } else {
                // Add the image to the favorite list
                controller.addImage(widget.imgUrl);
                // Show a snackbar message
                Get.snackbar('Success', 'Image added to favorites');
              }
              // Toggle the favorite status of the image
              // setState(() {
              //   if (favoriteImages.contains(widget.imgUrl)) {
              //     // Remove the image from the favorite list
              //     favoriteImages.remove(widget.imgUrl);
              //   } else {
              //     // Add the image to the favorite list
              //     favoriteImages.add(widget.imgUrl);
              //   }
              //   // Save the list to the box
              //   Hive.box('hive').put('favoriteImages', favoriteImages);
              // });
            },
            ),
            SpeedDialChild(
              child: Icon(Icons.merge),
              label: 'Set Wallpaper for both',
              onTap: () async {
                setWallpaper(widget.imgUrl, WallpaperManager.BOTH_SCREEN);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.lock),
              label: 'Set Lock Screen Wallpaper',
              onTap: () async {
                setWallpaper(widget.imgUrl, WallpaperManager.LOCK_SCREEN);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.home),
              label: 'Set Home Wallpaper',
              onTap: () async {
                setWallpaper(widget.imgUrl, WallpaperManager.HOME_SCREEN);
              },
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
        ),
      );
    
  }

  _save() async {
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
  }
}
