import 'package:flutter/material.dart';
import 'package:wallpaper_planet/views/screens/category.dart';

class CategorieBlock extends StatelessWidget {
  String categoryName;
  String catimgSrc;
  CategorieBlock(
      {super.key, required this.catimgSrc, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    catImgUrl: catimgSrc, catName: categoryName)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                    height: 50, width: 100, fit: BoxFit.cover, catimgSrc)),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15)),
            ),
            Positioned(
              child: Text(
                categoryName,
                style:
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ),
    );
  }
}
