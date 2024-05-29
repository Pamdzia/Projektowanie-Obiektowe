import 'package:flutter/material.dart';
import '../models/category.dart';
import 'product_list_screen.dart';

class CategoryListScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(id: '1', name: 'Elektronika'),
    Category(id: '2', name: 'Książki'),
    Category(id: '3', name: 'Ubrania'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategorie'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
