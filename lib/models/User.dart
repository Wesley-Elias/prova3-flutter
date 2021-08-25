import './CardModel.dart';

class User {
  final String? id;
  final String email;
  final String token;
  final List<CardModel>? cards;
  final DateTime expirationDate;

  const User({
    this.id,
    required this.email,
    required this.token,
    required this.expirationDate,
    this.cards,
  });
}
