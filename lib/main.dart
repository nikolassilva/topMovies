import 'package:flutter/material.dart';
import 'package:movies_app/core/constant.dart';
import 'package:movies_app/core/theme_app.dart';
import 'package:movies_app/pages/movie_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: consAppName,
      theme: themeApp,
      home: MoviePage(),
    );
  }
}
