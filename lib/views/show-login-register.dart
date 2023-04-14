import 'package:flutter/material.dart';

class RegisterLoginPage extends StatefulWidget {
  @override
  _RegisterLoginPageState createState() => _RegisterLoginPageState();
}

class _RegisterLoginPageState extends State<RegisterLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(255, 203, 73, 1.0)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/default_transparent_765x625.png',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: const Text(
                  "Olá, seja bem vindo",
                  style: TextStyle(
                    fontSize: 24,
                    // fontFamily: Roboto,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: const Text('Entre com sua conta para continuar'),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/login-page');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, //cor do botão de "Logar"
                        ),
                        child: Text('Entrar'),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color.fromRGBO(117, 88, 7, 1.0),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        child: Text('Cadastrar'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
