import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/auth_services.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:provider/provider.dart';

import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {


    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading) return const LoadingScreen();


    return  Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),  
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),             
        
      ),
    body: ListView.builder(
      itemCount: productsService.products.length,
      itemBuilder:( BuildContext context, int index) => GestureDetector(
        onTap: () {

          productsService.selectedProduct = productsService.products[index].copy();
          Navigator.pushNamed(context, 'product');

        },

        child: ProductCard(product: productsService.products[index]),
        ),

    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        productsService.selectedProduct =  Product(
        available: false,
        name: 'product temp',
        price: 0.0,
        );
        Navigator.pushNamed(context, 'product');
      },
    ),
    );
  }
}