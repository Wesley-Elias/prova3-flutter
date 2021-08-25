import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:path/path.dart';

import '../controllers/SignInController.dart';
import '../controllers/CardsController.dart';
import '../controllers/ImageController.dart';

import './SignInPage.dart';

import '../models/CardModel.dart';

class CardPage extends StatelessWidget {
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
        title: Text('Cadastrar Aluno'),
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
      body: _createCardForm(
          signInController.user.id, cardsController, context, imageController),
    );
  }

  _createCardForm(userId, cardsController, context, imageController) {
    return Container(
      padding: EdgeInsets.all(48),
      child: Form(
        key: _formKey,
        child: ListView(children: [
          if (imageController.image.path.isNotEmpty)
            Center(child: Image.file(imageController.image, height:100)),
          Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await imageController.selectImage();
                  },
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.attach_file, size: 28),
                    Text("Selecionar imagem")
                  ]),
                ),
              )),
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) {
                  cardName = value!;
                },
              )),
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'CPF'),
                onSaved: (value) {
                  cardDescription = value!;
                },
              )),
          Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Escolaridade'),
                onSaved: (value) {
                  cardStrength = value!;
                },
              )),
          Spacer(),
          Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState!.save();

                    CardModel cardData = new CardModel(
                        name: cardName,
                        description: cardDescription,
                        strength: cardStrength);

                    await cardsController.create(
                        userId, cardData, imageController.image);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Salvo com sucesso!'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Cadastrar aluno'),
                ),
              ))
        ]),
      ),
    );
  }
}
