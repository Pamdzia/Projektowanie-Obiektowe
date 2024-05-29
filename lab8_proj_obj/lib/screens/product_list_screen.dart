import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  final Category category;

  ProductListScreen({required this.category});

  final List<Product> products = [
    Product(id: '1', categoryId: '1', name: 'Laptop'),
    Product(id: '2', categoryId: '1', name: 'Smartfon'),
    Product(id: '3', categoryId: '2', name: 'Powieść'),
    Product(id: '4', categoryId: '2', name: 'Biografia'),
    Product(id: '5', categoryId: '3', name: 'Bluzka'),
    Product(id: '6', categoryId: '3', name: 'Spodnie'),
  ];

  @override
  Widget build(BuildContext context) {
    final categoryProducts = products.where((product) => product.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categoryProducts[index].name),
          );
        },
      ),
    );
  }
}
