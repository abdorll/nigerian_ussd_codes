// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextOf extends StatelessWidget {
  TextOf(
      {this.align = TextAlign.center,
      required this.text,
      this.decoration = TextDecoration.none,
      this.wordSpacing = 0,
      this.weight,
      required this.size,
      this.color,
      this.overflow = TextOverflow.visible,
      this.letterSpacing = 0,
      Key? key})
      : super(key: key);
  String text;
  Color? color;
  TextOverflow overflow;

  TextAlign align;
  double size;
  TextDecoration decoration;
  FontWeight? weight;
  double wordSpacing, letterSpacing;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        softWrap: true,
        overflow: overflow,
        style: GoogleFonts.mulish(
            wordSpacing: wordSpacing,
            decorationColor: Colors.green,
            letterSpacing: letterSpacing,
            decorationThickness: 1.5,
            decoration: decoration,
            color: color ?? Colors.black,
            fontSize: size,
            fontWeight: weight ?? FontWeight.w500));
  }
}
