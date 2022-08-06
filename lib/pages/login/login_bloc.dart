import 'dart:async';
import 'package:new_car_app/pages/login/usuario.dart';
import 'api_response.dart';
import 'login_api.dart';

class LoginBloc {
  final _streamControllerShProgress = StreamController<bool>();
  get stramControllerProgress => _streamControllerShProgress.stream;

  Future<ApisResponse> login(String login, String senha) async {
    _streamControllerShProgress.add(true);
    ApisResponse response = await LoginApi.login(login, senha);
    _streamControllerShProgress.add(false);
    return response;
  }

  void dispose() {
    _streamControllerShProgress.close();
  }
}
