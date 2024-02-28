import 'package:flutter/material.dart';
import 'package:wallpaper_planet/views/screens/search.dart';

class CustomSearchBar extends StatelessWidget {
  CustomSearchBar({
    super.key,
  });
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: const Color(0xffF0F0F0),
              border: Border.all(color: const Color(0xff5C469C)),
              borderRadius: BorderRadius.circular(25)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Search Wallpapers",
                    
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(query: _searchController.text)));
                },
                child: const Icon(Icons.search),
              )
            ],
          ),
        ));
  }
}
