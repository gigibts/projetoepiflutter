import 'package:flutter/material.dart';

class ValidarSenha extends ChangeNotifier{
  bool _valido = false;
  String _msgError = '';

  bool get ehvalido => _valido;
  String get msgError => _msgError;

  void validatePassword(String password){
     
     _msgError = '';

     if(password.length < 8){
        _msgError = "Mínimo 8 dígitos";
     
     }

     else if (!password.contains(RegExp(r'[a-z]'))){
       _msgError = 'Pelo menos uma letra minúscula';
     }
     else if (!password.contains(RegExp(r'[a-z]'))){
       _msgError = 'Pelo menos uma letra maiúscula';
     }
     else if (!password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:\|,.<>\/?]'))) {
       _msgError = 'Pelo menos um carácter especial';
     }

     else if (!password.contains(RegExp(r'[0-9]'))){
       _msgError = 'Pelo menos um número';
     }
     _valido = msgError.isEmpty;
     notifyListeners();
  }
}