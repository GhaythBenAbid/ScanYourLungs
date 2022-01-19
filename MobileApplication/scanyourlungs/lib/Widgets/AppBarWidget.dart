import 'package:flutter/material.dart';

AppBar AppBarWidget() {
  return AppBar(
    toolbarHeight: 100,
    elevation: 0,
    centerTitle: true,
    title: GestureDetector(
      child: Image.asset(
        'images/LogoBlue.png',
        height: 80,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.blue),
  );
}
