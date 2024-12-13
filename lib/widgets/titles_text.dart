import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final Color? color;
  final TextDecoration textDecoration;
  final int? maxLines;
  
  const TitlesTextWidget(
      {super.key,
      required this.label,
      this.fontSize = 20,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.color,
      this.textDecoration = TextDecoration.none, 
      this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    return  Text(
      label,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: color,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
