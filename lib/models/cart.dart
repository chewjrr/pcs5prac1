import 'package:prac3/models/note.dart';

class Cart {
  final List<Note> items;

  Cart() : items = [];

  bool get isEmpty => items.isEmpty;

  String getEmptyCartMessage() {
    return isEmpty ? "You can't win a game without items 😁" : "";
  }
}
