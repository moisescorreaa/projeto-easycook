import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        title: const Text(
          "Esqueceu a senha?",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Insira o seu email para redefinir a senha.",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancelar"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
              side: BorderSide(color: Colors.transparent),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Enviar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF5F5F5),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('assets/favicon_transparent_32x32.png'),
                  margin: EdgeInsets.only(top: 50),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFFD32F2F),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: _emailController,
                          validator: (email) {
                            if (!RegExp(r'^.+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(email!) &&
                                email.isNotEmpty) {
                              return ('Por favor, insira um email válido.');
                            } else if (email == null || email.isEmpty) {
                              return 'Por favor, insira um email';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Por favor, insira a senha';
                            }
                            return null;
                          },
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF757575),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () => showForgotPasswordDialog(),
                            child: Text(
                              'Clique aqui',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pushNamed('/home-page');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: Text("Entrar"),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ainda não tem uma conta?',
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamed('/register-page'),
                            child: Text(
                              'Cadastre-se aqui',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
