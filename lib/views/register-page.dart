import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

final _formKey = GlobalKey<FormState>();
final _usernameController = TextEditingController();
final _emailController = TextEditingController();
final _senhaController = TextEditingController();
final _confirmarSenhaController = TextEditingController();

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

  void popUpTerms(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: Dialog(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Text(
                      'Bem-vindo ao nosso aplicativo!\nAntes de começar a usar nosso serviço, leia atentamente estes termos de uso que regem o uso do nosso aplicativo e quaisquer outros serviços que possamos oferecer (o "Serviço"). \nAo usar o nosso Serviço, você concorda com estes Termos. Se você não concordar com estes Termos, não use nosso Serviço.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                      '\nColeta de dados\n\nNós coletamos informações pessoais do usuário para fornecer o Serviço e melhorar sua experiência no aplicativo. As informações que coletamos podem incluir seu nome, endereço de e-mail, informações de perfil e outras informações que você fornecer.\n\nO uso das informações coletadas é regido pela nossa Política de Privacidade, que você deve ler cuidadosamente antes de utilizar nosso serviço. Nós nos comprometemos a manter suas informações pessoais seguras e protegidas, em conformidade com as normas da Lei Geral de Proteção de Dados (LGPD).\n\nUso do Serviço\n\nO nosso serviço é fornecido "como está" e não fazemos garantias expressas ou implícitas quanto à sua disponibilidade, adequação a um determinado propósito, segurança ou confiabilidade. Você é responsável por garantir que o uso do Serviço esteja em conformidade com as leis e regulamentos aplicáveis.\n\nO nosso Serviço pode permitir que você envie conteúdo, como mensagens, fotos e outros materiais. Ao enviar conteúdo, você garante que tem o direito de fazê-lo e concede a nós uma licença não exclusiva, mundial, livre de royalties, sublicenciável e transferível para usar, reproduzir, distribuir, preparar obras derivadas e exibir publicamente o conteúdo em conexão com o nosso Serviço.\n\nRestrições de Uso\n\nVocê concorda em não utilizar o nosso Serviço para qualquer finalidade ilegal ou não autorizada, incluindo, mas não se limitando a, a violação de direitos autorais e de propriedade intelectual.\n\nLinks para outros sites\n\nO nosso Serviço pode conter links para sites de terceiros. Não somos responsáveis pelo conteúdo ou práticas de privacidade desses sites. Sugerimos que você leia os termos de uso e a política de privacidade desses sites antes de utilizá-los.\n\nAlterações aos Termos de Uso\n\nPodemos atualizar estes Termos de tempos em tempos. É sua responsabilidade revisar estes Termos periodicamente para verificar se houve alterações. Seu uso continuado do Serviço após a publicação de quaisquer alterações a estes Termos significa que você aceita e concorda com as alterações.\n\nRescisão\n\nPodemos rescindir ou suspender o seu acesso ao Serviço imediatamente, sem aviso prévio ou responsabilidade, por qualquer motivo, incluindo, mas não se limitando a, a violação destes Termos.',
                      style: TextStyle(fontSize: 14)),
                  Container(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _agreeToTerms = true;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text("Concordar"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 203, 73, 1),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset('favicon_transparent_32x32.png'),
                  margin: EdgeInsets.only(top: 50),
                ),
              ],
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Text(
                        'Cadastro',
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
                            controller: _usernameController,
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
                            validator: (username) {
                              if (username == null || username.isEmpty) {
                                return 'Por favor, insira um nome de usuário!';
                              }
                              return null;
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                            controller: _emailController,
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
                            validator: (email) {
                              if (!RegExp(r'^.+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$')
                                      .hasMatch(email!) &&
                                  email.isNotEmpty) {
                                return ('Por favor, insira um email válido.');
                              } else if (email == null || email.isEmpty) {
                                return 'Por favor, insira um email!';
                              }
                            }),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: _senhaController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            labelText: "Senha",
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
                          validator: (senha) {
                            if (senha == null || senha.isEmpty) {
                              return 'Por favor, insira uma senha';
                            } else if (senha.length < 6) {
                              return 'Por favor, insira uma senha mais forte!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                            controller: _confirmarSenhaController,
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
                            validator: (confirmarSenha) {
                              if (confirmarSenha == null ||
                                  confirmarSenha.isEmpty) {
                                return 'Confirme sua senha, por favor!';
                              } else if (confirmarSenha != _senhaController.text) {
                                return 'Senhas não conferem!';
                              }
                              return null;
                            }),
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
                            onTap: () {
                              popUpTerms(context);
                            },
                            child: Container(
                              child: Text(
                                ' termos',
                                style: TextStyle(
                                  color: Colors.red,
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
                            if (_formKey.currentState!.validate()) {
                              showAlert();
                            }
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
                            'Já tem uma conta?',
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
                                ' Faça login aqui',
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
            ),
          ],
        ),
      ),
    );
  }
}
