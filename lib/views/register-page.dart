import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _showPassword = false;
  bool _agreeToTerms = false;

  void showAlert() {
    QuickAlert.show(
        context: context,
        title: 'Cheque seu email!',
        confirmBtnText: 'Login',
        confirmBtnColor: Color.fromRGBO(18, 192, 106, 1),
        onConfirmBtnTap: () =>
            Navigator.of(context).popAndPushNamed('/login-page'),
        text:
            '\nEstamos animados para acompanhar você nessa jornada culinária!!!\n\nEnviamos uma mensagem para a sua caixa de entrada com um link de confirmação!',
        type: QuickAlertType.success);
  }

  void popUpTerms() {
    QuickAlert.show(
        context: context,
        title: 'Termos',
        text: 'Exemplo termos',
        confirmBtnText: 'Concordar',
        type: QuickAlertType.confirm,
        onConfirmBtnTap: () {
          setState(() {
            _agreeToTerms = true;
          });
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 203, 73, 1),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 80),
                    Text(
                      'Seja Bem-Vindo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(117, 88, 7, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nome do usuário',
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
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
                        keyboardType: TextInputType
                            .emailAddress, // aparece o @ no teclado
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
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
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
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
                        obscureText: !_showPassword,
                        decoration: InputDecoration(
                          labelText: "Confirmar senha",
                          labelStyle: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromRGBO(117, 88, 7, 1),
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = !_agreeToTerms;
                            });
                          },
                          activeColor: Colors.red,
                        ),
                        Text(
                          'Concordo com os',
                          style: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => popUpTerms(),
                          child: Container(
                            child: Text(
                              ' termos',
                              style: TextStyle(
                                color: Color.fromRGBO(59, 44, 0, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlert();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Cadastrar"),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Color.fromRGBO(117, 88, 7, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed('/login-page'),
                          child: Container(
                            child: Text(
                              ' Log In',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context)
                    .popAndPushNamed('/show-login-register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
