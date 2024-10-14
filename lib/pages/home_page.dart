import 'package:flutter/material.dart';
import 'package:prac3/pages/cart_page.dart';
import 'package:prac3/pages/favorite_page.dart';
import '../components/item_note.dart';
import '../models/note.dart';
import '../models/cart.dart';
//import '../pages/note_page.dart';
import '../pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

Color getBackgroundColor(Note note) {
  double opacity = note.activity == 1 ? 0.5 : 0.75; // Прозрачность
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

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String searchQuery = "";
  String selectedType = "";
  Cart cart = Cart(); // Создаем одну корзину
  int _selectedIndex = 0; // Переменная для отслеживания выбранного индекса
  List<Note> favoriteItems = []; // Переменная для избранных товаров

  final List<Note> notes = [
    Note(
      "Basic Magazine",
      "Weapon",
      "Basic Magazine is a Tier 1 Weapon Item that provides more ammo and more weapon damage. It can be purchased from the Shop for Souls 500 Souls. Basic Magazine is a component of Titanic Magazine.",
      "https://deadlocked.wiki/images/thumb/5/54/Basic_Magazine.png/64px-Basic_Magazine.png",
      500,
      "+24% Ammo, +15% Weapon Damage",
      "+6% Weapon Damage",
      0,
      false,
      false,
    ),
    Note(
      "Enduring Spirit",
      "Vitality",
      "Enduring Spirit is a Tier 1 Vitality Item that provides Bonus Health, Spirit Lifesteal and Spirit Power to the purchasing hero. It may be purchased for Souls 500 Souls from the Shop.",
      "https://deadlocked.wiki/images/thumb/8/80/Enduring_Spirit.png/64px-Enduring_Spirit.png",
      500,
      "+75 Bonus Health, +10% Spirit Lifesteal, 4 Spirit Power",
      "+11% Base Health",
      0,
      false,
      false,
    ),
    Note(
      "Extra Charge",
      "Spirit",
      "Extra Charge is a Tier 1 Spirit Item that provides a second charge to any Charged Ability such as Wraith's Card Trick, Ivy's Kudzu Bomb, or Seven's Lightning Ball, as well as slightly reducing the cooldown of Charged Abilities",
      "https://deadlocked.wiki/images/thumb/4/4a/Extra_Charge.png/64px-Extra_Charge.png",
      500,
      "+1 Bonus Ability Charges, +10% Cooldown Reduction for Charged Abilities, +6% Weapon Damage",
      "+4 Spirit Power",
      0,
      false,
      false,
    )
  ];

  List<Note> filteredNotes() {
    return notes
        .where((note) =>
            note.title.toLowerCase().contains(searchQuery.toLowerCase()) &&
            note.type.toLowerCase().contains(selectedType.toLowerCase()))
        .toList();
  }

  void addToCart(Note note) {
    setState(() {
      cart.items.add(note);
      note.isInCart = true; // Обновляем состояние
    });
  }

  void removeFromCart(Note note) {
    setState(() {
      cart.items.remove(note); // Удаляем товар из корзины
      note.isInCart = false; // Обновляем состояние
    });
  }

  void toggleFavorite(Note note) {
    setState(() {
      note.isFavorite = !note.isFavorite;
      if (note.isFavorite) {
        favoriteItems.add(note); // Добавляем в избранное
      } else {
        favoriteItems.remove(note); // Удаляем из избранного
      }
    });
  }

  // Метод для обновления выбранного индекса и перехода на соответствующую страницу
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Определяем текущую страницу на основе выбранного индекса
    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = _buildShopPage(); // Магазин
        break;
      case 1:
        currentPage = CartPage(
          cart: cart,
          onRemoveFromCart: (note) {
            setState(() {
              note.isInCart = false; // Меняем иконку обратно на плюсик
            });
          },
        ); // Корзина
        break;
      case 2:
        currentPage = const ProfilePage(); // Профиль
        break;
      default:
        currentPage = _buildShopPage(); // По умолчанию
    }

    return Scaffold(
      body: currentPage, // Текущая страница
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Вызываем метод при нажатии
      ),
    );
  }

  // Метод для построения страницы магазина
  Widget _buildShopPage() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        title: Image.network(
          "https://deadlocked.wiki/images/thumb/8/8d/Shop_Logo.png/459px-Shop_Logo.png",
          height: 40,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  // Переход на страницу избранного при нажатии на иконку
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(
                        favoriteItems: favoriteItems,
                      ),
                    ),
                  );
                },
              ),
              if (favoriteItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${favoriteItems.length}', // Количество избранных товаров
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => setState(() => searchQuery = query),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FilterChip(
                label: const Text("Weapon"),
                selected: selectedType == "Weapon",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Weapon" : ""),
              ),
              FilterChip(
                label: const Text("Vitality"),
                selected: selectedType == "Vitality",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Vitality" : ""),
              ),
              FilterChip(
                label: const Text("Spirit"),
                selected: selectedType == "Spirit",
                onSelected: (selected) =>
                    setState(() => selectedType = selected ? "Spirit" : ""),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0, // Spacing between columns
                mainAxisSpacing: 10.0, // Spacing between rows
              ),
              itemCount: filteredNotes().length,
              itemBuilder: (context, index) {
                final note = filteredNotes()[index];
                return ItemNote(
                  title: note.title,
                  type: note.type,
                  text: note.text,
                  imageUrl: note.imageUrl,
                  cost: note.cost,
                  bonus: note.bonus,
                  stats: note.stats,
                  activity: note.activity,
                  isInCart: note.isInCart,
                  isFavorite: note.isFavorite,
                  onAddToCart: () {
                    setState(() {
                      if (note.isInCart) {
                        removeFromCart(note);
                      } else {
                        addToCart(note);
                      }
                    });
                  },
                  onToggleFavorite: () {
                    toggleFavorite(note);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
