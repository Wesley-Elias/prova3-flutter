import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../util/env.dart';

class SignUpController {
  Future<void> signUp(
      {required String? email, required String? password}) async {
    try {
      var url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:signUp',
        {'key': Env.API_KEY},
      );

      var response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      var userId = json.decode(response.body)["localId"];

      var insertUserUrl = Uri.https(Env.FIREBASE_URL, '/users/$userId.json');

      await http.patch(insertUserUrl,
          body: jsonEncode({
            'email': email,
          }));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
