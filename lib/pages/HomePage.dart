import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../controllers/SignInController.dart';
import '../controllers/CardsController.dart';
import '../controllers/ImageController.dart';

import './SignInPage.dart';
import './CardPage.dart';

import '../models/CardModel.dart';

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String cardName = '';
  String cardDescription = '';
  String cardStrength = '';

  @override
  Widget build(BuildContext context) {
    return Consumer3<SignInController, CardsController, ImageController>(
        builder: (_, signInController, cardsController, imageController, __) {
      return _scaffold(
          context, signInController, cardsController, imageController);
    });
  }

  _scaffold(context, signInController, cardsController, imageController) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Alunos'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                signInController.signOut();

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return SignInPage();
                }));
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white))
        ],
      ),
      body: _cardList(cardsController, imageController),
      floatingActionButton: _createCard(context),
    );
  }

  _cardList(cardsController, imageController) {
    return Container(
      padding: EdgeInsets.all(48),
      child: ListView.builder(
          itemCount: cardsController.cards.length,
          itemBuilder: (context, index) {
            return _card(cardsController, index, imageController);
          }),
    );
  }

  _card(cardsController, index, imageController) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _cardImage(cardsController.cards[index].image),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              _cardName(cardsController.cards[index].name),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              _cardStrength(cardsController.cards[index].strength),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              _cardDescription(cardsController.cards[index].description)
            ],
          )),
    );
  }

  _cardImage(imageUrl) {
    return Image.network(imageUrl, fit: BoxFit.cover, width: 250);
  }

  _cardName(cardName) {
    return Row(children: [
      Text("Nome: ",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1)),
      Text(cardName,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1)),
    ]);
  }

  _cardStrength(cardStrength) {
    return Row(children: [
      Text("Força: ",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1)),
      Text(cardStrength,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1)),
    ]);
  }

  _cardDescription(cardDescription) {
    return Text(
      cardDescription,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          letterSpacing: 1),
    );
  }

  _createCard(context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CardPage()));
      },
    );
  }
}
