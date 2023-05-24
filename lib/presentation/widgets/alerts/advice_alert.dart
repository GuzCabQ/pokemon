import 'package:flutter/material.dart';
import 'package:pokemon/config/theme.dart/fonts_app.dart';

adviceAlert(BuildContext context,
    {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        textScaleFactor: 1,
        style: FontsApp.h1.copyWith(color: Colors.red),
      ),
      content: Text(
        content,
        textScaleFactor: 1,
        style: FontsApp.h2,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
