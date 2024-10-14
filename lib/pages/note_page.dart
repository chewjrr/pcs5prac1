import 'package:flutter/material.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage(
      {super.key,
      required this.note,
      required String title,
      required String type});

  Color getBackgroundColor() {
    double opacity = note.activity == 1
        ? 0.5
        : 0.75; // Меняем прозрачность, если предмет неактивен
    switch (note.type) {
      case 'Weapon':
        return const Color.fromARGB(255, 231, 140, 36).withOpacity(opacity);
      case 'Vitality':
        return const Color.fromARGB(255, 61, 138, 63).withOpacity(opacity);
      case 'Spirit':
        return const Color.fromARGB(255, 146, 32, 240).withOpacity(opacity);
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: getBackgroundColor(),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        note.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
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
