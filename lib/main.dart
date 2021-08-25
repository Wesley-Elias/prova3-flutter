import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import '../controllers/CardsController.dart';
import '../controllers/SignInController.dart';
import '../controllers/ImageController.dart';

import '../util/PersistenceValidation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CardsController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ImageController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CardsController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SignInController(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Curso | Prova 3',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: PersistenceValidation(),
      ),
    );
  }
}