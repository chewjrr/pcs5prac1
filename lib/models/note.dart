class Note {
  final String title;
  final String type;
  final String text;
  final String imageUrl;
  final int cost;
  final String bonus;
  final String stats;
  final int activity;
  bool isInCart;

  Note(this.title, this.type, this.text, this.imageUrl, this.cost, this.bonus,
      this.stats, this.activity, this.isInCart);
}
