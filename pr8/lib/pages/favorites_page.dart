import 'package:flutter/material.dart';
import '../components/list_item.dart';
import '../pages/itam_page.dart';
import '../models/api_service.dart';
import '../models/product_model.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  late Future<List<Product>> _favProducts;
  late List<Product> _favProductsUpd;

  @override
  void initState() {
    super.initState();
    _favProducts = ApiService().getFavorites();
    ApiService().getFavorites().then((i) => {_favProductsUpd = i});
  }

  void _addToFavorites(Product i) {
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: !i.isFavourite,
        isInCart: i.isInCart,
        quantity: i.quantity);
    ApiService().changeProductStatus(el);
    setState(() {
      _favProductsUpd
          .elementAt(_favProductsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;
    });
  }

  void addTOCart(Product i) async {
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: i.isFavourite,
        isInCart: true,
        quantity: 1);
    ApiService().changeProductStatus(el);
    setState(() {
      _favProductsUpd
          .elementAt(_favProductsUpd.indexWhere((j) => j.id == i.id))
          .isInCart = true;
      _favProductsUpd
          .elementAt(_favProductsUpd.indexWhere((j) => j.id == i.id))
          .quantity = 1;
    });
  }

  void _setUpd() {
    setState(() {
      _favProducts = ApiService().getFavorites();
      ApiService().getFavorites().then(
            (value) => {_favProductsUpd = value},
      );
    });
  }

  void _openItem(id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
        ),
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
            "Избранные автомобили",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
        ),
        body: FutureBuilder<List<Product>>(
            future: _favProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Вы не добавили ничего в избранное'));
              }

              final items = snapshot.data!;
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
                      //onDelete: (flavor) => deleteItem(flavor.id, context),
                      onAddToFavourites: (flavor) => {_addToFavorites(flavor)},
                      onAddToCart: (flavor) => {addTOCart(flavor)},
                      NavToItemPage: (int i) => {_openItem(i)},
                    ),
                  );
                },
              );
            }));
  }
}