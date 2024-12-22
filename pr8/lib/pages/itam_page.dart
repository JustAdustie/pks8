import 'package:flutter/material.dart';
import '../models/api_service.dart';
import '../models/product_model.dart';
import '../styles/itam_widgets.dart';

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
  });

  final Product flavor;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  late Future<Product> flavors;

  bool isFavourite = false;
  bool isInCart = false;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    flavors = ApiService().getProductById(widget.flavor.id);
    ApiService().getProductById(widget.flavor.id).then(
          (i) {
        setState(() {
          quantity = i.quantity;
          isFavourite = i.isFavourite;
          isInCart = i.isInCart;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: flavors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Ошибка'));
        }

        final product = snapshot.data!;
        return Scaffold(
          backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
          appBar: AppBar(
            title: Text(
              widget.flavor.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: ItemWidget(
            product: product,
            isFavourite: isFavourite,
            isInCart: isInCart,
            onToggleFavorite: () => setState(() {
              isFavourite = !isFavourite;
              ApiService().changeProductStatus(
                Product(
                  id: product.id,
                  name: product.name,
                  imageUrl: product.imageUrl,
                  price: product.price,
                  description: product.description,
                  feature: product.feature,
                  isFavourite: isFavourite,
                  isInCart: product.isInCart,
                  quantity: product.quantity,
                ),
              );
            }),
            onToggleCart: () => setState(() {
              isInCart = !isInCart;
              quantity = isInCart ? 1 : 0;
              ApiService().changeProductStatus(
                Product(
                  id: product.id,
                  name: product.name,
                  imageUrl: product.imageUrl,
                  price: product.price,
                  description: product.description,
                  feature: product.feature,
                  isFavourite: product.isFavourite,
                  isInCart: isInCart,
                  quantity: quantity,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
