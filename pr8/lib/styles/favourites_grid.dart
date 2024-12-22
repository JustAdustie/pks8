import 'package:flutter/material.dart';
import '../components/list_item.dart';
import '../models/product_model.dart';

class FavouritesGrid extends StatelessWidget {
  final List<Product> items;
  final Function(int) openItem;

  const FavouritesGrid({super.key, required this.items, required this.openItem});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.61,
      ),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final flavor = items[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListItem(
            key: Key(flavor.id.toString()),
            flavor: flavor,
            onAddToFavourites: (flavor) {
            },
            onAddToCart: (flavor) {
            },
            NavToItemPage: openItem,
          ),
        );
      },
    );
  }
}
