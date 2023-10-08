import 'package:flutter/material.dart';

class AppConstan {
  //field
  static String appName = 'IEL project';

  static Color bgcolor = Color.fromRGBO(189, 3, 99, 0.675);

  //method

  BoxDecoration basicbox() {
    return BoxDecoration(color: bgcolor.withOpacity(0.35));
  }

  BoxDecoration linearbox() {
    return BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.white, bgcolor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter));
  }

  BoxDecoration Radiobox() {
    return BoxDecoration(
        gradient: RadialGradient(
            colors: [Colors.white, bgcolor],
            radius: 1.0,
            center: Alignment(-0.5, -0.5),
            )
            );
  }

  TextStyle h1Style({double? size}) {
    return TextStyle(
      fontSize: size ?? 48,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }
}
