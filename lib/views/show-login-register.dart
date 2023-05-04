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
        decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Image.asset(
                  'assets/default_transparent_765x625_cropped.png',
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: const Text(
                  "Olá, seja bem-vindo",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD32F2F),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: const Text(
                  'Entre com sua conta para continuar',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
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
                          primary: Color(0xFFD32F2F),
                        ),
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      height: 30,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/register-page');
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Color(0xFF757575),
                          ),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Color(0xFF757575),
                          ),
                        ),
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
