import 'package:flutter/material.dart';

class ItemNote extends StatelessWidget {
  final String title;
  final String type;
  final String text;
  final String imageUrl;
  final int cost;
  final String bonus;
  final String stats;

  const ItemNote({
    super.key,
    required this.title,
    required this.type,
    required this.text,
    required this.imageUrl,
    required this.cost,
    required this.bonus,
    required this.stats,
  });

  Color getBackgroundColor() {
    switch (type) {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: getBackgroundColor(),
          border: Border.all(color: Colors.white, width: 2),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                type,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Image.network(imageUrl, height: 100),
              const SizedBox(height: 10),
              Text(
                "Cost: $cost Souls",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Bonus: $bonus",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Stats: $stats",
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
