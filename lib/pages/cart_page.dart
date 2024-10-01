import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  final Cart cart; // Корзина

  const CartPage({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final note = cart.items[index];
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: getBackgroundColor(note.type),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ListTile(
              leading: Image.network(note.imageUrl),
              title: Text(note.title),
              subtitle: Text(note.type),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

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
}
