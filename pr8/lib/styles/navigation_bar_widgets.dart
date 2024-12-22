import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Избранное"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Корзина"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: const Color.fromRGBO(73, 200, 130, 1),
      unselectedItemColor: const Color.fromRGBO(73, 146, 156, 1),
      onTap: onItemTapped,
    );
  }
}
