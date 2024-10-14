import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Контроллеры для полей ввода
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();

  // Изначальные значения
  String name = "Миронов Всеволод Владимирович";
  String group = "ЭФБО-03-22";

  @override
  void initState() {
    super.initState();
    // Устанавливаем начальные значения в контроллеры
    _nameController.text = name;
    _groupController.text = group;
  }

  // Метод для открытия диалогового окна редактирования профиля
  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Поле ввода имени
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Поле ввода группы
              TextField(
                controller: _groupController,
                decoration: const InputDecoration(
                  labelText: "Group",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог без сохранения
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  name = _nameController.text; // Обновить имя
                  group = _groupController.text; // Обновить группу
                });
                Navigator.of(context).pop(); // Закрыть диалог
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated")),
                );
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Отображение сохранённых данных профиля
            Text(
              "Name: $name",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Group: $group",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            // Кнопка для редактирования профиля
            ElevatedButton(
              onPressed:
                  _editProfile, // Открыть всплывающее меню для редактирования
              child: const Text("Edit"),
            ),
          ],
        ),
      ),
    );
  }
}
