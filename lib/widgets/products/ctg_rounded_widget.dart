import 'package:flutter/material.dart';
import 'package:online_shopping_app/screens/search_screen.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  final String image, name;
  const CategoryRoundedWidget(
      {super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context, 
          SearchScreen.routeName, 
          arguments: name
        );
      },
      child: Column(
        children: [
          Image.network(
            image,
            width: 50,
            height: 50,
          ),
          SubtitleTextWidget(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
