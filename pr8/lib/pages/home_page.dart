import 'package:flutter/material.dart';
import '../pages/add_item_page.dart';
import '../pages/itam_page.dart';
import '../models/api_service.dart';
import '../models/product_model.dart';
import '../styles/product_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;
  late List<Product> _productsUpd;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
    ApiService().getProducts().then(
          (data) => {_productsUpd = data},
    );
  }

  void _setUpd() {
    setState(() {
      _products = ApiService().getCart();
      ApiService().getCart().then(
            (data) => {_productsUpd = data},
      );
    });
  }

  void _navigateToAddFlavorScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFlavorScreen()),
    );
    _setUpd();
  }

  void _addToFavorites(Product product) {
    Product updatedProduct = Product(
      id: product.id,
      name: product.name,
      imageUrl: product.imageUrl,
      price: product.price,
      description: product.description,
      feature: product.feature,
      isFavourite: !product.isFavourite,
      isInCart: product.isInCart,
      quantity: product.quantity,
    );
    ApiService().changeProductStatus(updatedProduct);
    setState(() {
      _productsUpd
          .firstWhere((item) => item.id == product.id)
          .isFavourite = !product.isFavourite;
    });
  }

  void addToCart(Product product) {
    Product updatedProduct = Product(
      id: product.id,
      name: product.name,
      imageUrl: product.imageUrl,
      price: product.price,
      description: product.description,
      feature: product.feature,
      isFavourite: product.isFavourite,
      isInCart: true,
      quantity: 1,
    );
    ApiService().changeProductStatus(updatedProduct);
    setState(() {
      _productsUpd
          .firstWhere((item) => item.id == product.id)
          .isInCart = true;
      _productsUpd.firstWhere((item) => item.id == product.id).quantity = 1;
    });
  }

  void _openItem(int id) async {
    final product = await ApiService().getProductById(id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(flavor: product),
      ),
    );
    _setUpd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
      appBar: AppBar(
        title: const Text(
          "Ассортимент автомобилей",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Ошибка'));
          }

          final items = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final product = items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProductCard(
                  flavor: product,
                  onOpenItem: () => _openItem(product.id),
                  onAddToFavorites: () => _addToFavorites(product),
                  onAddToCart: () => addToCart(product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
