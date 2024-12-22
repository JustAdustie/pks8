import 'package:flutter/material.dart';
import '../models/profile.dart';

class UserProfileInfo extends StatelessWidget {
  final User userData;

  const UserProfileInfo({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50.0),
          Align(
            alignment: Alignment.center,
            child: ClipOval(
              child: Image.network(
                userData.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Ошибка загрузки изображения');
                },
              ),
            ),
          ),
          const SizedBox(height: 50),
          _buildInfoCard(userData.name, 20.0, FontWeight.w700),
          const SizedBox(height: 50),
          _buildLabel('Почта'),
          _buildInfoCard(userData.email, 18.0, FontWeight.w400),
          const SizedBox(height: 30),
          _buildLabel('Телефон'),
          _buildInfoCard(userData.phoneNumber, 18.0, FontWeight.w400),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String text, double fontSize, FontWeight fontWeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _buildLabel(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 10, bottom: 5),
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(23, 118, 130, 1),
        ),
      ),
    );
  }
}
