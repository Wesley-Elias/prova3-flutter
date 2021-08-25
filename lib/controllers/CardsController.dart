import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import '../util/env.dart';

import '../models/CardModel.dart';

import '../controllers/ImageController.dart';

class CardsController extends ChangeNotifier {
  CardsController() {
    index();
  }

  ImageController imageController = new ImageController();
  List<CardModel> cards = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> index() async {
    isLoading = true;
    cards.clear();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var currentUserId = prefs.getString('id');

      var url = Uri.https(Env.FIREBASE_URL, '/users/$currentUserId/cards.json');

      var resp = await http.get(url);

      Map<String, dynamic> data =
          new Map<String, dynamic>.from(json.decode(resp.body));

      data.forEach((key, value) {
        cards.add(CardModel(
          id: key,
          name: value['name'],
          description: value['description'],
          strength: value['strength'],
          image: value['image'],
        ));
      });

      isLoading = false;
    } catch (error) {
      throw error;
    }
  }

  Future<void> create(String userId, CardModel cardData, File image) async {
    var imageUploadedLink = await imageController.uploadImage(image);

    var url = Uri.https(Env.FIREBASE_URL, '/users/$userId/cards.json');

    print(cardData.name);
    print(cardData.description);
    print(cardData.strength);

    await http.post(url,
        body: jsonEncode({
          'name': cardData.name,
          'description': cardData.description,
          'strength': cardData.strength,
          'image': imageUploadedLink
        }));

    index();
    notifyListeners();
  }

  Future<void> delete(String userId, String cardId) async {
    var url = Uri.https(Env.FIREBASE_URL, '/users/$userId/cards/$cardId.json');

    try {
      await http.delete(url);
      index();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> edit(String userId, CardModel cardData) async {
    var url =
        Uri.https(Env.FIREBASE_URL, '/users/$userId/cards/${cardData.id}.json');

    try {
      await http.put(url,
          body: jsonEncode({
            'name': cardData.name,
            'description': cardData.description,
            'strength': cardData.strength,
          }));
      index();
      notifyListeners();
    } catch (e) {}
  }
}
