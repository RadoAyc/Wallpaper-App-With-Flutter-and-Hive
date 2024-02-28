import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wallpaper_planet/controller/api_oper.dart';
import 'package:wallpaper_planet/model/category_model.dart';
import 'package:wallpaper_planet/model/photos_model.dart';
import 'package:wallpaper_planet/views/screens/favorites.dart';
import 'package:wallpaper_planet/views/screens/full_screen.dart';
import 'package:wallpaper_planet/views/widgets/categorie_block.dart';
import 'package:wallpaper_planet/views/widgets/custom_appbar.dart';
// import 'package:wallpaper_planet/views/widgets/drawer_menu.dart';
import 'package:wallpaper_planet/views/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var box = Hive.box('hive');
var favoriteImages = box.get('favoriteImages', defaultValue: []);

class _HomeScreenState extends State<HomeScreen> {
  List<PhotosModel> trendingWallList = [];
  List<CategoryModel> CatModList = [];
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();

    setState(() {
      CatModList = CatModList;
    });
  }

  GetTrendingWallpapers() async {
    trendingWallList = await ApiOperations.getTrendingWallpapers();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    GetTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1D267D),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xff0C134F),
        elevation: 0.5,
        title: CustomAppBar(word1: 'Wallpaper', word2: 'Planet'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
              },
            )
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              CustomSearchBar(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: CatModList.length,
                    itemBuilder: ((context, index) => CategorieBlock(
                          catimgSrc: CatModList[index].catImgUrl,
                          categoryName: CatModList[index].catName,
                        )),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  // height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 400,
                              crossAxisCount: 2,
                              crossAxisSpacing: 13,
                              mainAxisSpacing: 10),
                      itemCount: trendingWallList.length,
                      itemBuilder: ((context, index) => GridTile(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imgUrl: trendingWallList[index]
                                                .imgSrc)));
                              },
                              child: Hero(
                                tag: trendingWallList[index].imgSrc,
                                child: SizedBox(
                                  height: 800,
                                  width: 50,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                          height: 800,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          trendingWallList[index].imgSrc)),
                                ),
                              ),
                            ),
                          ))),
                ),
              ),
            ]),
    );
  }
}
