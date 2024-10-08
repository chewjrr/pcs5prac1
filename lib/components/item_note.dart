import 'package:flutter/material.dart';

class ItemNote extends StatelessWidget {
  final String title;
  final String type;
  final String text;
  final String imageUrl;
  final int cost;
  final String bonus;
  final String stats;
  final int activity;
  final bool isInCart;

  const ItemNote({
    super.key,
    required this.title,
    required this.type,
    required this.text,
    required this.imageUrl,
    required this.cost,
    required this.bonus,
    required this.stats,
    required this.activity,
    required this.isInCart,
  });

  Color getBackgroundColor() {
    double opacity = activity == 1
        ? 0.5
        : 0.75; // Меняем прозрачность, если предмет неактивен
    switch (type) {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: getBackgroundColor(),
          border: Border.all(color: Colors.white, width: 2),
        ),
        width: double.infinity,
        height: 300, // Ограничиваем высоту
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center, // Center the text
              ),
              const SizedBox(height: 8),
              Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              // Wrap the image with Flexible or give it fixed height
              Flexible(
                child: Image.network(
                  imageUrl,
                  height: 64, // Set fixed height for the image
                  fit: BoxFit.contain, // Ensure it fits within the container
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Cost: $cost Souls",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
