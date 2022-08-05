import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:list_car/pages/login/api_response.dart';
import 'package:list_car/pages/login/usuario.dart';


class LoginApi {
  static Future<ApisResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {"username": login, "password": senha};

      String s = json.encode(params);

      var response = await http.post(Uri.parse(url), body: s, headers: headers);
      print('response body: ' + response.body);
      print('response status code: ' + response.statusCode.toString());

      Map mapResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        Usuario.get();

        return ApisResponse.ok(user);
      }
      return ApisResponse.error(mapResponse["error"]);
    } on Exception catch (error, exception) {
      print('Erro no login> $error');
      return ApisResponse.error("Não foi possivel fazer o login ;( ");
    }
  }
}
//     Map params = {"username": login, "passaword": senha};
//     String s= json.encode(params);
//     var response = await http.get(url,  headers: headers);//body: s,
//     print('response body: ' + response.body);
//     print('response status code: ' + response.statusCode.toString());
//     Map mapResponse = json.decode(response.body);
//     var name = mapResponse["name"];
//     var email= mapResponse["email"];
//     print("Nome: $name");
//     print("E=mail: $email");
// final user = Usuario(name, email);