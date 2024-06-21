import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projetoepi/Constrain/url.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadEpiProvider with ChangeNotifier {
  
  bool _carregando = false;
  bool get carregando => _carregando;

  Future cadastrar(
    BuildContext context,
    String nome,
    String instrucao,
  ) async {
    var dados = await SharedPreferences.getInstance();
    String? token = dados.getString("token");

    String url = '${AppUrl.baseUrl}api/Epi';

    _carregando = false;
    notifyListeners();

  
    Map<String, dynamic> requestBody = {
      "insUso": instrucao,
      "nomeEpi": nome,
      "qtd": 1
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestBody),
    );

    _carregando = false;
    notifyListeners();

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint("certo");
      showMessage(
          message: 'Epi cadastrado com sucesso!',
          // ignore: use_build_context_synchronously
          context: context);
    } else {
      debugPrint(response.body);
      showMessage(
          message: 'Erro ao cadastrar Epi!',
          // ignore: use_build_context_synchronously
          context: context);
    }
  }
}