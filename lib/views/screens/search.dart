import 'package:flutter/material.dart';
import 'package:wallpaper_planet/controller/api_oper.dart';
import 'package:wallpaper_planet/model/photos_model.dart';
import 'package:wallpaper_planet/views/screens/full_screen.dart';
import 'package:wallpaper_planet/views/widgets/custom_appbar.dart';
import 'package:wallpaper_planet/views/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchResults = [];

  GetSearchResults() async {
    searchResults = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      // isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1D267D),
      appBar: AppBar(
        backgroundColor: const Color(0xff0C134F),
        elevation: 0.5,
        title: CustomAppBar(word1: 'Wallpaper', word2: 'Planet'),
      ),
      body: Column(children: [
        CustomSearchBar(),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 400,
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 10),
                itemCount: searchResults.length,
                itemBuilder: ((context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    imgUrl: searchResults[index].imgSrc)));
                      },
                      child: Hero(
                        tag: searchResults[index].imgSrc,
                        child: SizedBox(
                          height: 800,
                          width: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  height: 800,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  searchResults[index].imgSrc)),
                        ),
                      ),
                    ))),
          ),
        )
      ]),
    );
  }
}
