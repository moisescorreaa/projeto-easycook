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
                child: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/easy-cook-2117a.appspot.com/o/imagesPadrao%2Fdefault_transparent_765x625_cropped.png?alt=media&token=5a5b7526-2d2d-4eae-9c0d-acee205374cd&_gl=1*1v3ky20*_ga*MTg4NDE3NTI2OC4xNjg1NDg4NzUw*_ga_CW55HF8NVT*MTY4NTgyNjUxMC4xNi4xLjE2ODU4MzAxNjMuMC4wLjA.',
                  fit: BoxFit.scaleDown,
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
