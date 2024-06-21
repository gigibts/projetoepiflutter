import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:projetoepi/Provider/cadastro/verifica_usuario.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:projetoepi/pages/confirm_password.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastre-se"),
      ),
      body: const SignupForm(),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  @override
  void dispose() {
    _cpfController.clear();
    _emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioCadastrado>(builder: (context, usuario, _) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customTextField(
              title: 'E-mail',
              controller: _emailController,
              hint: 'Digite seu e-mail',
            ),
            // TextFormField(
            //   controller: _emailController,
            //   decoration: const InputDecoration(
            //    fillColor: Color.fromRGBO(162, 214, 43, 0.75),
            //    filled: true,
            //   labelText: 'E-mail'),
            // ),
            const SizedBox(
              height: 25,
            ),
            customTextField(
                title: 'CPF',
                controller: _cpfController,
                hint: "Digite seu CPF",
                formatacao: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ]),
            // TextFormField(
            //   controller: _cpfController,
            //   decoration: const InputDecoration(
            //   fillColor: Color.fromRGBO(162, 214, 43, 0.75),
            //    filled: true,
            //   labelText: 'CPF'),
            // ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(height: 20),
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: customButton(
                tap: () async {
                  await usuario.checarUsuario(
                      _cpfController.text, _emailController.text);
                  if (usuario.valido) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ConfirmPassword(
                                email: _emailController.text,
                                cpf: _cpfController.text,
                              )),
                    );
                  } else {
                    showMessage(message: usuario.msgError,
                    context: context);
                  }
                },
                text: "Avançar",
                context: context,
                status: usuario.carregando
              ),
            ),
          ],
        ),
      );
    });
  }
}
