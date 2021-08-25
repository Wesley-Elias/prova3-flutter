import 'package:flutter/material.dart';
import 'package:prova3/controllers/SignInController.dart';
import 'package:provider/provider.dart';


import '../pages/SignInPage.dart';
import '../pages/HomePage.dart';

class PersistenceValidation extends StatefulWidget {
  @override
  Validated createState() => Validated();
}

class Validated extends State<PersistenceValidation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignInController>(builder: (_, login, __) {
      return SignInPage();
      if (login.hasAutenticated) {
        return HomePage();
      } else {}
    });
  }
}
