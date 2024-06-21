// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("SafeGuard"),
//         centerTitle: true,
//         backgroundColor: const Color(0xffA2D62B),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomLeft,
//               colors: [Colors.white, Colors.white]),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const TextField(
//                 decoration: InputDecoration(
//                     label: Text("Nome"),
//                     labelStyle: TextStyle(color: Colors.black),
//                     filled: true,
//               fillColor: Color.fromRGBO(162, 214, 43, 0.75)),
//               ),
//               const SizedBox(
//               height: 25,),
//               const TextField(
//                 decoration: InputDecoration(
//                     label: Text("E-mail"),
//                     labelStyle: TextStyle(color: Colors.black),
//                     filled: true,
//                     fillColor: Color.fromRGBO(162, 214, 43, 0.75)),
//               ),
//                 Padding(
//                   padding: const EdgeInsets.all(50),
//                   child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed('/cadastro');
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       backgroundColor: const Color.fromRGBO(65,191,34, 0.85),
//                       shape: const BeveledRectangleBorder()
//                     ),
//                     child: const Text("CADASTRAR"),
//                   ),
//                  ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetoepi/Provider/login/logar.dart';
import 'package:projetoepi/Utils/mensage.dart';
import 'package:projetoepi/Widget/botao.dart';
import 'package:projetoepi/Widget/field.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  
  @override
  void dispose(){
    _email.clear();
    _password.clear();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Logar>(builder: (context, Logar, _) {
      return Material(
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: const Color(0xffA2D62B),
            child: const Column(
              children: [
                Image(image: AssetImage("assets/image/logosafeguard.png"))
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Colors.white, Colors.white]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // decoration: InputDecoration(
                  //         label: Text("Nome"),
                  //         labelStyle: TextStyle(color: Colors.black),
                  //         filled: true,
                  //        fillColor: Color.fromRGBO(162, 214, 43, 0.75)),
                  customTextField(
                      title: 'E-mail',
                      controller: _email,
                      hint: 'Digite seu E-mail',
                      tipo: TextInputType.emailAddress),
                  const SizedBox(
                    height: 25,
                  ),
                  customTextField(
                      title: 'Senha',
                      controller: _password,
                      hint: 'Digite sua senha',
                      obscure: true,
                      tipo: TextInputType.visiblePassword,
                      funcao: (value) {
                        Logar.validatePassword(value);
                      }
                      // decoration: InputDecoration(
                      //     label: Text("E-mail"),
                      //     labelStyle: TextStyle(color: Colors.black),
                      //     filled: true,
                      //     fillColor: Color.fromRGBO(162, 214, 43, 0.75)),
                      ),
                  if (Logar.msgError.isNotEmpty)
                    Text(
                      Logar.msgError,
                      style: const TextStyle(color: Colors.red),
                    ),
                  customButton(
                    text: 'Login',
                    tap: () async {
                      if (_email.text.isEmpty || _password.text.isEmpty) {
                        showMessage(
                            message: "Todos os campos são requiridos",
                            context: context);
                        print("oi");
                      } else {
                        await Logar.logarUsuario(_email.text, _password.text, 0);
                        if (Logar.logado) {
                          Navigator.of(context).pushNamed(Logar.rota);
                        } else {
                          showMessage(
                              message: "Usuário ou senha inválidos",
                              context: context);
                        }
                      }
                    },
                    context: context,
                    status: Logar.carregando),

                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cadastro');
                    },
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      );
    });
  }
}
