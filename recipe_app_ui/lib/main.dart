import 'package:flutter/material.dart';
import 'package:recipe_app_ui/pages/pages.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    ),
  );
}
