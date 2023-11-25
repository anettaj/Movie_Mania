import 'package:flutter/material.dart';
// pages
import 'Pages/Movie_List.dart';
import 'Pages/Spash_page.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Mania',
      home: SpashPage(
        onInitializationComplete: () {
          // You can add any initialization logic here if needed
        },
      ),
    );
  }
}