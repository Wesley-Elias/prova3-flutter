import 'package:flutter/material.dart';

import '../util/env.dart';

import '../controllers/SignUpController.dart';

class SignUpPage extends StatelessWidget {
  SignUpController signupController = SignUpController();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Future<void> submit(
      BuildContext context, SignUpController signupController) async {
    await signupController.signUp(email: email, password: password);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text("Cadastrar"),
          elevation: 0,
          centerTitle: true,
        ),
        body: _body(context));
  }

  _body(context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(48),
          child: Form(
              key: _formKey,
              child: Column(
                  children: [_formInputs(), _signUpButton(context)]))),
    );
  }

  _formInputs() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira um e-mail válido';
              }
            },
            onSaved: (value) {
              email = value!;
            },
          ),
          Divider(),
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira uma senha';
              }
            },
            onSaved: (value) {
              password = value!;
            },
          ),
        ]));
  }

  _signUpButton(context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    await submit(context, signupController);
                  }
                },
                child: Text("Cadsatrar"))));
  }
}