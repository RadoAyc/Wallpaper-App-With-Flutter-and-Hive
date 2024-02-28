import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_planet/controller/favorite_controller.dart';
import 'package:wallpaper_planet/model/favorite_model.dart';
import 'package:wallpaper_planet/views/screens/favorites.dart';
import 'package:wallpaper_planet/views/screens/home.dart';

void main() async {
  await Hive.initFlutter();
Get.put(FavoriteController());
  
  
  // Get.putAsync(() => Hive.openBox('hive'));
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox('hive'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print('errroor');
              return Text(snapshot.error.toString());
            } else {
             print('dooonee');
              return GetMaterialApp(
                title: 'Wallpaper Planet',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                debugShowCheckedModeBanner: false,
                home: const HomeScreen(),
                initialBinding: BindingsBuilder(() {
        Get.put(FavoriteController());
      }),
              );
            }
          } else {
            print('3333');
            return Center(
            child: CircularProgressIndicator(),
          );
          }
        });
  }
}
