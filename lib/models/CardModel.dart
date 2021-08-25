class CardModel {
  final String? id;
  final String name;
  final String description;
  final String strength;
  final String? image;

  const CardModel(
      {this.id,
      required this.name,
      required this.description,
      required this.strength,
      this.image});
}
