
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetoepi/Constrain/url.dart';

class UsuarioCadastrado extends ChangeNotifier{
  bool _valido = false;
  String? _msgError;
  bool _carregando = false;

  bool get valido => _valido;
  String get msgError => _msgError!;
  bool get carregando => _carregando;

  final String baseUrl = '${AppUrl.baseUrl}/api/Usuario/Check';

  Future checarUsuario(String cpf, String email) async
  {
    try {
      final response =
      await http.get(Uri.parse('$baseUrl?Cpf=$cpf&Email=$email'));
      _msgError = '';

      _carregando = false;
      String resposta = '';
      resposta = response.body;

      if(response.statusCode == 200) {
        _valido = true;
        _msgError = resposta;
        _carregando = true;
        notifyListeners();
        return _valido;
      }

      if(response.statusCode == 400) {
        _msgError = resposta;
        return _valido;
      }
    } catch (e) {
      _msgError = 'Erro: $e';
      return _valido;
    }
    notifyListeners();
  }
}