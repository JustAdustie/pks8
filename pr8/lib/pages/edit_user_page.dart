import 'package:flutter/material.dart';
import '../models/api_service.dart';
import '../models/profile.dart';
import '../styles/profile_edit_form.dart';

class MyEditUserInfoPage extends StatefulWidget {
  const MyEditUserInfoPage({super.key});

  @override
  State<MyEditUserInfoPage> createState() => _MyEditUserInfoPageState();
}

class _MyEditUserInfoPageState extends State<MyEditUserInfoPage> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = ApiService().getUserById(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 253, 255, 1),
      appBar: AppBar(
        title: const Text(
          "Изменение данных профиля",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Пользователь не найден'));
          }

          final userData = snapshot.data!;
          return ProfileEditForm(user: userData);
        },
      ),
    );
  }
}
