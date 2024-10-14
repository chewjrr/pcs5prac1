import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart';

class FavoritePage extends StatelessWidget {
  final List<Note> favoriteItems;

  const FavoritePage({super.key, required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final note = favoriteItems[index];
          return ItemNote(
            title: note.title,
            type: note.type,
            text: '', // Убираем текст
            imageUrl: note.imageUrl,
            cost: note.cost,
            bonus: note.bonus, // Отображаем бонус
            stats: note.stats, // Отображаем статы
            activity: note.activity,
            isInCart: note.isInCart,
            isFavorite: note.isFavorite,
            onAddToCart: () {
              // Вызов добавления в корзину
            },
            onToggleFavorite: () {
              // Вызов добавления в избранное
            },
          );
        },
      ),
    );
  }
}
