import 'package:flutter/material.dart';
import '../models/api_service.dart';
import '../models/profile.dart';

class ProfileEditForm extends StatefulWidget {
  final User user;

  const ProfileEditForm({super.key, required this.user});

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  late TextEditingController _userNameController;
  late TextEditingController _profilePicController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.user.name);
    _profilePicController = TextEditingController(text: widget.user.image);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
  }

  void dispose() {
    _userNameController.dispose();
    _profilePicController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Имя пользователя', _userNameController),
            buildTextField('Фото профиля', _profilePicController),
            buildTextField('Почта', _emailController),
            buildTextField('Телефон', _phoneController),
            const SizedBox(height: 60),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
                ),
                onPressed: () async {
                  if (_userNameController.text.isNotEmpty &&
                      _profilePicController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty) {
                    await ApiService().updateUser(User(
                      id: widget.user.id,
                      image: _profilePicController.text,
                      name: _userNameController.text,
                      email: _emailController.text,
                      phoneNumber: _phoneController.text,
                    ));
                    Navigator.pop(context);
                    print("Информация профиля обновлена");
                  } else {
                    print("Информация профиля НЕ обновлена");
                  }
                },
                child: const Text(
                  "Сохранить",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 77, 70, 0),
            ),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            hintText: label,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(160, 149, 108, 1),
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: Color.fromRGBO(108, 98, 63, 1), width: 1),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
