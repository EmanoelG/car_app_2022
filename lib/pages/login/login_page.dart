import 'package:flutter/material.dart';
import 'package:new_car_app/pages/login/usuario.dart';

import '../../util/alert.dart';
import '../../util/nav.dart';
import '../carro/home_page.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textInput.dart';
import 'api_response.dart';
import 'package:auth_buttons/auth_buttons.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tlogin = TextEditingController();

  final _tsenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _loginBloc = LoginBloc();
  var entrar = 'Entrar';
  @override
  void initState() {
    super.initState();

    /**
     Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if (user != null) {
        push(context, HomePage(), replace: true);
      }
    });
    */
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Carro',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            AppTextInput(
              'Login',
              'Digite o nome do usuário ',
              controller: _tlogin,
              validator: ((value) => _validatelogin(value!)),
              type: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            AppTextInput(
              'Senha',
              'Digite sua senha',
              obscure: true,
              controller: _tsenha,
              validator:((value) => _validateSenha(value!)),
              type: TextInputType.number,
              focus: _focusSenha,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 20),
            StreamBuilder<bool>(
              stream: _loginBloc.stramControllerProgress,
              builder: (context, snapshot) {
                return AppButton(entrar, _onClickLogin, snapshot.data ?? false);
              },
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child:const GoogleAuthButton(
                text: 'Seguir com google',
                style: AuthButtonStyle(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                 // borderWidth: 1,
                //  borderRadius: 20.0,
                  borderColor: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    var logins = _tlogin.text;
    String senha = _tsenha.text;

    try {
      ApisResponse apisResponse = await _loginBloc.login(
          logins.toString().trim(), senha.toString().trim());

      if (apisResponse.ok) {
        Usuario user = apisResponse.result;

        push(context, HomePage(), replace: true);
      } else {
        alert(context, apisResponse.msg);
      }
    } on Exception catch (e) {}
  }

  String _validatelogin(String value) {
    if (value.isEmpty) {
      return 'Digite o login ! ';
    }
    return '';
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return 'Digite a senha ! ';
    }
    if (value.length < 3) {
      return 'A senha precisa ter pelo menos 3 caracter !';
    }
    return '';
  }
}
