import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String word1;
  String word2;
  CustomAppBar({super.key, required this.word1, required this.word2});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: word1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: " $word2",
                  style: const TextStyle(
                      color: Color(0xffD4ADFC),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ])),
    );
  }
}
