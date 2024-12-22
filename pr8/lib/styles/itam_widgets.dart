import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.product,
    required this.isFavourite,
    required this.isInCart,
    required this.onToggleFavorite,
    required this.onToggleCart,
  });

  final Product product;
  final bool isFavourite;
  final bool isInCart;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: const Color.fromRGBO(240, 253, 255, 1),
                ),
              ),
              const SizedBox(width: 30.0),
              IconButton(
                onPressed: onToggleCart,
                icon: Icon(
                  isInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                  color: const Color.fromRGBO(240, 253, 255, 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Image.network(
            product.imageUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Описание",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Особенности",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                product.feature,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Цена",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text(
                "${product.price}₽",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          TextButton(
            onPressed: () {
              // Удаление продукта
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 60.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Удалить',
              style: TextStyle(
                fontSize: 14.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
