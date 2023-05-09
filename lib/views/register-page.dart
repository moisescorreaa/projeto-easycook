import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final confirmaSenhaController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  late String username;
  late String email;
  late String password;

  bool _showPassword = false;
  bool _agreeToTerms = false;
  bool _showConfirmPassword = false;

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira uma senha';
    } else if (value.length < 6) {
      return 'Por favor, insira uma senha mais forte';
    } else if (value != confirmaSenhaController.text) {
      return 'Senhas não conferem';
    }
    return null;
  }

  String? _validarUsuario(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira um nome de usuário';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value!.isEmpty) {
      return 'Por favor, insira um email';
    } else if (!regExp.hasMatch(value)) {
      return 'Por favor, insira um email válido.';
    } else {
      return null;
    }
  }

  void showAlert(value, String? respostaErro) {
    if (value == true) {
      QuickAlert.show(
          context: context,
          title: 'Cheque seu email!',
          confirmBtnText: 'OK',
          confirmBtnColor: Color.fromRGBO(18, 192, 106, 1),
          onConfirmBtnTap: () =>
              Navigator.of(context).popAndPushNamed('/login-page'),
          text:
              '\nEstamos animados para acompanhar você nessa jornada culinária!!!\n\nEnviamos uma mensagem para a sua caixa de entrada com um link de confirmação!',
          type: QuickAlertType.success);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(respostaErro!),
        ),
      );
    }
  }

  registrar(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // salvar os dados no banco de dados...
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        showAlert(true, '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showAlert(false, 'A senha é muito fraca.');
        } else if (e.code == 'email-already-in-use') {
          showAlert(false, 'O endereço de e-mail já está em uso.');
        } else {
          showAlert(false, 'Ocorreu um erro ao cadastrar o usuário');
        }
      } catch (e) {
        showAlert(false, 'Ocorreu um erro desconhecido');
      }
    }
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
                          color: Colors.red,
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
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: _validarUsuario,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                          onSaved: (value) => email = value!,
                          keyboardType: TextInputType
                              .emailAddress, // aparece o @ no teclado
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
                          validator: _validarEmail,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                          onSaved: (value) => password = value!,
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
                          validator: _validarSenha,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 300,
                        child: TextFormField(
                          controller: confirmaSenhaController,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            labelText: "Confirmar senha",
                            labelStyle: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _showConfirmPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF757575),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showConfirmPassword = !_showConfirmPassword;
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
                              color: Color(0xFF757575),
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
                          onPressed: () => registrar(context),
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
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/login-page'),
                            child: Text(
                              ' Faça login aqui',
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

class Usuario {
  final String? usernameUsuario;
  final String? uuid;

  Usuario({
    required this.usernameUsuario,
    required this.uuid,
  });
}
