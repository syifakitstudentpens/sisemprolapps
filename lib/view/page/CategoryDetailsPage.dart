import 'package:flutter/material.dart';
import 'package:sisemprol/data/category/Category.dart';
import 'package:sisemprol/view/widget/JadwalListWidget.dart';

class CategoryDetailsPage extends StatelessWidget {
  final Category category;

  CategoryDetailsPage(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: JadwalListWidget('', category.id.toString()),
    );
  }
}
