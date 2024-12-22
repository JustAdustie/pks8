import 'package:flutter/material.dart';
import '../models/api_service.dart';
import '../pages/edit_user_page.dart';
import '../models/profile.dart';
import '../styles/user_profile_widgets.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key});

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = ApiService().getUserById(1);
  }

  void _refreshData() {
    setState(() {
      user = ApiService().getUserById(1);
    });
  }

  void _navigateToEditUserInfoScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEditUserInfoPage()),
    );
    if (result != null) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Данные пользователя не найдены'));
          }

          final userData = snapshot.data!;
          return UserProfileInfo(userData: userData);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEditUserInfoScreen(context),
        tooltip: 'Редактировать профиль',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
