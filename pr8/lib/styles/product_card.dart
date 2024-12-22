import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product flavor;
  final VoidCallback onOpenItem;
  final VoidCallback onAddToFavorites;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.flavor,
    required this.onOpenItem,
    required this.onAddToFavorites,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpenItem,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          children: [
            Image.network(
              flavor.imageUrl,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flavor.name,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    flavor.description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Стоимость: ${flavor.price.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 65, 65, 65),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onAddToFavorites,
                  icon: flavor.isFavourite
                      ? const Icon(Icons.favorite,
                      color: Color.fromRGBO(23, 118, 130, 1))
                      : const Icon(Icons.favorite_border,
                      color: Color.fromRGBO(23, 118, 130, 1)),
                ),
                const SizedBox(width: 20.0),
                IconButton(
                  onPressed: onAddToCart,
                  icon: flavor.isInCart
                      ? const Icon(Icons.shopping_cart,
                      color: Color.fromRGBO(23, 118, 130, 1))
                      : const Icon(Icons.add_shopping_cart,
                      color: Color.fromRGBO(23, 118, 130, 1)),
                ),
              ],
            ),
            const SizedBox(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}
