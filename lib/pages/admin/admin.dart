import 'package:flutter/material.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Widget/botao.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrativo"),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Bem-vindo"),
            customButton(
                text: "Cadastrar Epi",
                tap: () {
                  Navigator.pushNamed(context, '/admepi');
                },
                context: context),
            customButton(
                text: "Cadastrar Funcionário",
                tap: () {
                  Navigator.pushNamed(context, '/admfunc');
                },
                context: context),
            customButton(
                text: "Cadastrar Entrega",
                tap: () {
                  Navigator.pushNamed(context, '/admentrega');
                },
                context: context)
          ],
        ),
      ),
    );
  }
}
