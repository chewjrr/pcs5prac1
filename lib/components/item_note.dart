import 'package:flutter/material.dart';
import 'package:prac3/models/note.dart';
import 'package:prac3/pages/note_page.dart';

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
  final bool isFavorite;
  final VoidCallback onAddToCart; // Добавление в корзину
  final VoidCallback onToggleFavorite; // Добавление в избранное

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
    required this.isFavorite,
    required this.onAddToCart, // Параметр добавления в корзину
    required this.onToggleFavorite, // Параметр добавления в избранное
  });

  Color getBackgroundColor() {
    double opacity = activity == 1 ? 0.5 : 0.75;
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
    return GestureDetector(
      onTap: () {
        // Navigate to NotePage on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePage(
              title: title,
              type: type,
              note: Note(title, type, text, imageUrl, cost, bonus, stats,
                  activity, isInCart, isFavorite),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 400, // Устанавливаем высоту для контейнера
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: getBackgroundColor(), // Применяем цвет фона здесь
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  imageUrl,
                  height: 50, // Ограничиваем высоту
                  fit: BoxFit.contain,
                ),
                Text(
                  "Price: $cost Souls",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      onPressed: onToggleFavorite,
                    ),
                    IconButton(
                      icon: Icon(
                        isInCart
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                        color: isInCart ? Colors.white : Colors.white,
                      ),
                      onPressed: onAddToCart,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
