import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KJTheme {
  static const Color backGroundColor = Colors.white;
  static const Color nearlyBlue = Color(0xff7C3AED);
  static const Color nearlyGrey = Color(0xff3D4451);
  static const Color darkishGrey = Color(0xff1F2937);
  static const Color contentColorPink = Color(0xfff106b6);
  static const Color contentColorGreen = Color(0xff1e4603);

  static double getMobileWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getMobileHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static TextStyle subtitleText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = darkishGrey,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontSize: size,
        fontWeight: weight,
        wordSpacing: 1.4,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static TextStyle titleText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = darkishGrey,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        fontWeight: weight,
        wordSpacing: 1.4,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static InputDecoration waInputDecoration(
      {IconData? prefixIcon,
      String? hint,
      Widget? suffixIcon,
      Color? bgColor,
      double fontSize = 20,
      Color? borderColor,
      EdgeInsets? padding}) {
    return InputDecoration(
      contentPadding:
          padding ?? const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      counter: const Offstage(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: nearlyBlue)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: BorderSide(color: borderColor ?? nearlyBlue)),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(1)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      fillColor: bgColor ?? Colors.grey.withOpacity(0.04),
      hintText: hint,
      suffixIcon: suffixIcon,
      prefixIcon:
          prefixIcon != null ? Icon(prefixIcon, color: nearlyBlue) : null,
      hintStyle: titleText(
          size: fontSize, weight: FontWeight.normal, color: Colors.grey),
      filled: true,
    );
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 10,
      FontWeight weight = FontWeight.bold,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle:
            subtitleText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(color: borderColor)));
  }
}
