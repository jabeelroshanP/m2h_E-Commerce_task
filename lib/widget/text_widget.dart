import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextSize { small, medium, large, big, title }

class AppText extends StatelessWidget {
  final String text;

  final TextSize size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.size = TextSize.medium,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  double getFontSize(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    switch (size) {
      case TextSize.small:
        return h * 0.018;
      case TextSize.medium:
        return h * 0.022;
      case TextSize.large:
        return h * 0.027;
      case TextSize.big:
        return h * 0.032;
      case TextSize.title:
        return h * 0.040;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: getFontSize(context),
        color: color ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
