import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // Импорт Slidable
import '../models/note.dart';
import '../models/cart.dart';
import '../pages/note_page.dart'; // Импорт страницы NotePage

class CartPage extends StatelessWidget {
  final Cart cart;
  final Function(Note) onRemoveFromCart;

  const CartPage(
      {super.key, required this.cart, required this.onRemoveFromCart});

  int getTotalCost() {
    return cart.items.fold(0, (sum, note) => sum + note.cost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final note = cart.items[index];

                return Slidable(
                  // Используем Slidable для удаления с подтверждением
                  key: ValueKey(note.title),
                  endActionPane: ActionPane(
                    motion: const StretchMotion(), // Анимация для удаления
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          _showDeleteConfirmation(context, note);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Переход на NotePage при нажатии на элемент
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotePage(
                            title: note.title,
                            type: note.type,
                            note: note,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      color:
                          getBackgroundColor(note.type), // Применяем цвет фона
                      child: ListTile(
                        leading: Container(
                          color: getBackgroundColor(
                              note.type), // Фон для изображения
                          padding: const EdgeInsets.all(4.0),
                          child: Image.network(
                            note.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(note.title),
                        subtitle: Text("Price: ${note.cost} Souls"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total: ${getTotalCost()} Souls", // Общая стоимость
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Функция для показа подтверждения удаления
  void _showDeleteConfirmation(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to remove this item from the cart?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onRemoveFromCart(note); // Удаление товара
                Navigator.of(context).pop(); // Закрыть диалог
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

// Функция для получения цвета фона по типу предмета
Color getBackgroundColor(String type) {
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
