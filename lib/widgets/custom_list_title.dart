import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:online_shopping_app/widgets/subtitle_text.dart';

class CustomListTitle extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback function;

  const CustomListTitle({
    super.key,
    required this.icon,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).iconTheme.color,
      ),
      title: SubtitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
