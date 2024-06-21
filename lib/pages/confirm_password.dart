import 'package:flutter/material.dart';
import 'package:projetoepi/Provider/cadastro/valida_login.dart';
import 'package:projetoepi/Provider/cadastro/verifica_usuario.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:provider/provider.dart';

class ConfirmPassword extends StatelessWidget {
  final String email;
  final String cpf;

  const ConfirmPassword({super.key, required this.email, required this.cpf});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController ConfirmPasswordController = TextEditingController();

    return Consumer<ValidarSenha>(builder: (context, validarSenha, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Confirme a Senha'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('E-mail: $email'),
                Text('CPF: $cpf'),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(162, 214, 43, 0.75),
                      filled: true,
                      labelText: 'Senha'),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: ConfirmPasswordController,
                  decoration: const InputDecoration(
                      fillColor: Color.fromRGBO(162, 214, 43, 0.75),
                      filled: true,
                      labelText: 'Confirmar Senha'),
                  obscureText: true,
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 50,
                ),
                customButton(
                  tap: () async {
                    if (passwordController.text != ConfirmPasswordController.text){
                      showMessage(
                        message: "As senhas devem ser iguais",
                        context: context);
                    } else{
                      var cpfint = cpf.replaceAll(RegExp(r'[^0-9]'),'');
                      validarSenha.createUser(
                        email, passwordController.text, int.parse(cpfint));
                        showMessage(
                          message: validarSenha.msgErrorApi, context: context);
                    }
                  },
                  text: "Concluir",
                  context: context,
                  status: validarSenha.carregando),
              ],
            ),
          ),
        ),
      );
    });
  }
}
