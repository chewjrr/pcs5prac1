import 'package:flutter/material.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  // Метод для получения цвета фона в зависимости от типа предмета
  Color getBackgroundColor() {
    switch (note.type) {
      case 'Weapon':
        return const Color.fromARGB(255, 231, 140, 36).withOpacity(0.75);
      case 'Vitality':
        return const Color.fromARGB(255, 61, 138, 63).withOpacity(0.75);
      case 'Spirit':
        return const Color.fromARGB(255, 146, 32, 240).withOpacity(0.75);
      default:
        return Colors.black.withOpacity(0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack для наложения фона, изображения и затемнения
              Stack(
                alignment: Alignment.center,
                children: [
                  // Контейнер с закругленным фоном в зависимости от типа предмета
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color:
                          getBackgroundColor(), // Цвет фона в зависимости от типа
                      borderRadius:
                          BorderRadius.circular(16.0), // Закругленные углы
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          16.0), // Закругление изображения
                      child: Image.network(
                        note.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit
                            .contain, // Изображение не будет растягиваться
                      ),
                    ),
                  ),
                  // Полупрозрачный контейнер для затемнения
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.5), // Затемнение всего контейнера
                      borderRadius:
                          BorderRadius.circular(16.0), // Закругленные углы
                    ),
                  ),
                  // Текст поверх затемненного изображения
                  Text(
                    note.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                note.text,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Cost: ${note.cost} Souls",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Bonus: ${note.bonus}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                "Stats: ${note.stats}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
