import 'dart:html';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projetoepi/Provider/admin/colaborador.dart';
import 'package:projetoepi/Style/colors.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';


class AdmFunc extends StatefulWidget {
  const AdmFunc({super.key});

  @override
  State<AdmFunc> createState() => _AdmFuncState();
}

class _AdmFuncState extends State<AdmFunc> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _ctps = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _dataAdmissao = TextEditingController();

  @override
  void dispose() {
    _nome.clear();
    _ctps.clear();
    _telefone.clear();
    _cpf.clear();
    _email.clear();
    _dataAdmissao.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColaboradorProvider>(builder: (context, colabprovider, _) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Administrativo'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    customTextField(
                        title: 'Nome',
                        controller: _nome,
                        hint: 'Digite o nome do Funcionário',
                        tipo: TextInputType.text),
                    customTextField(
                      title: 'Número CTPS',
                      controller: _ctps,
                      hint: 'Digite o número da CTPS',
                      tipo: TextInputType.text,
                    ),
                    customTextField(
                        title: 'Telefone',
                        controller: _telefone,
                        hint: 'Digite o telefone do Funcionário',
                        tipo: TextInputType.phone,
                        formatacao: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ]),
                    customTextField(
                        title: 'Cpf do Funcionário',
                        controller: _cpf,
                        hint: 'Digite o CPF do Funcionário',
                        tipo: TextInputType.number,
                        formatacao: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ]),
                    customTextField(
                        title: 'E-mail',
                        controller: _email,
                        hint: 'Digite o e-mail do Funcionário',
                        tipo: TextInputType.emailAddress),
                    customTextField(
                        title: 'Data de Adimissão',
                        controller: _dataAdmissao,
                        hint: 'Digite a data de contratação',
                        tipo: TextInputType.datetime,
                        formatacao: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ]),
                    customButton(
                        tap: () {
                          // if (_formKey.currentState!.validate()) {
                            colabprovider.cadastrar(
                              context,
                              _nome.text,
                              _ctps.text,
                              _telefone.text,
                              _cpf.text,
                              _email.text,
                              _dataAdmissao.text,
                            );
                          // } else {
                          //   showMessage(
                          //       message:
                          //           "Todos os campos devem ser preenchidos",
                          //       context: context);
                          // }
                        },
                        text: "Concluir",
                        context: context,
                        status: colabprovider.carregando)
                  ],
                ),
              ),
            ),
          ));
    });
  }
}