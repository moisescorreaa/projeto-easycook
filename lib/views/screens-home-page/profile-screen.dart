import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycook_main/views/screens-home-page/recipe-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class Receita {
  final String tituloReceita;
  final String descricaoReceita;
  final String ingredientesReceita;
  final String tempoDePreparo;
  final String modoDePreparo;
  final String imagemReceita;

  Receita(
      {required this.tituloReceita,
      required this.descricaoReceita,
      required this.ingredientesReceita,
      required this.tempoDePreparo,
      required this.imagemReceita,
      required this.modoDePreparo});
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool mostrarReceitasPublicadas = true;
  bool mostrarReceitasFavoritadas = false;

  bool verificado = false;
  String? username = "";
  String? imagemURL;
  XFile? imagem;

  TextEditingController newUsername = TextEditingController();

  final nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buscarDadosUsuario();
    verificarUsuario();
  }

  void logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        title: const Text(
          'Você tem certeza que deseja sair?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
            onPressed: () => logoutFunc(),
            child: Text("Confirmar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void logoutFunc() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Logout realizado com sucesso')),
      );
      Navigator.pushReplacementNamed(context, '/show-login-register');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erro ao realizar logout')),
      );
    }
  }

  void buscarDadosUsuario() {
    setState(() {
      username = auth.currentUser?.displayName;
      imagemURL = auth.currentUser?.photoURL;
    });
  }

  bool? verificarUsuario() {
    if (auth.currentUser?.emailVerified == true) {
      verificado = true;
    } else {
      verificado = false;
    }
    return verificado;
  }

  void alterarDadosUsuario() {
    if (newUsername != null) {
      try {
        setState(() {
          auth.currentUser?.updateDisplayName(newUsername.text);
          // auth.currentUser?.updatePhotoURL(imagemURL);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Dados alterados com sucesso'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Ocorreu um erro ao alterar os dados'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    imagem = await picker.pickImage(source: ImageSource.gallery);
  }

  void _editDataProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        title: const Text(
          "Editar Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => pickImage(),
              child: Container(
                width: double.maxFinite,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(12.0),
                child: imagem != null
                    ? Image.file(File(imagem!.path))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.insert_photo_outlined,
                              color: Color.fromARGB(255, 100, 100, 100)),
                          SizedBox(width: 8.0),
                          Text(
                            'Inserir Imagem',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            TextFormField(
              controller: newUsername,
              decoration: InputDecoration(
                labelText: "Novo nome de perfil",
                labelStyle: const TextStyle(
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
            onPressed: () => alterarDadosUsuario(),
            child: Text("Enviar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  // void alterarDadosUsuario() {
  //   db
  //       .collection("usuarios").doc(auth.currentUser!.displayName)
  //       ..update({'username' :  });

  // }

  final List<Receita> _receitasPublicadas = [
    Receita(
        tituloReceita: "Mousse de Maracujá",
        descricaoReceita:
            "Aprenda a fazer uma sobremesa deliciosa, refrescante e fácil de preparar.",
        ingredientesReceita:
            '1 lata de leite condensado\n1 lata de creme de leite\n1/2 xícara de suco de maracujá concentrado\n1 envelope de gelatina em pó sem sabor\n1/2 xícara de água quente\nPolpa de maracujá e folhas de hortelã para decorar',
        tempoDePreparo: '20 a 30 minutos',
        imagemReceita: 'assets/mousse-maracuja.jpg',
        modoDePreparo:
            '1. Em um recipiente, misture o leite condensado, o creme de leite e o suco de maracujá até obter uma mistura homogênea.\n2. Em outro recipiente, dissolva a gelatina em pó na água quente e misture bem.\n3. Adicione a gelatina dissolvida à mistura de leite condensado, creme de leite e suco de maracujá, e misture bem.\n4. Despeje a mistura em taças ou refratários individuais e leve à geladeira por, no mínimo, 2 horas.\n5. Retire da geladeira e decore com polpa de maracujá e folhas de hortelã antes de servir.'),
    Receita(
        tituloReceita: "Escondidinho de Camarão",
        descricaoReceita:
            "Aprenda a fazer um prato delicioso e fácil para uma reunião entre amigos ou família.",
        ingredientesReceita:
            '500g de camarão limpo e descascado\n1kg de mandioca\n1 cebola média picada\n3 dentes de alho picados\n2 colheres de sopa de manteiga\n1 xícara de leite\n1/2 xícara de creme de leite\n1/2 xícara de queijo parmesão ralado\n1/2 xícara de requeijão cremoso\nSal e pimenta a gosto\nCheiro verde picado para finalizar',
        tempoDePreparo: '40 a 60 minutos',
        imagemReceita: 'assets/escondidinho-camarao.jpg',
        modoDePreparo:
            '1. Descasque e corte a mandioca em pedaços médios. Coloque em uma panela com água e cozinhe até que fique macia.\n2. Enquanto a mandioca cozinha, em uma frigideira grande, refogue a cebola e o alho em uma colher de sopa de manteiga até que fiquem macios.\n3. Adicione o camarão e refogue até que fiquem rosados. Tempere com sal e pimenta a gosto. Reserve.\n4. Quando a mandioca estiver cozida, escorra a água e amasse até obter um purê. Adicione a manteiga restante, o leite, o creme de leite, o queijo parmesão e misture bem.\n5. Em um refratário, coloque metade do purê de mandioca, o camarão refogado e o requeijão cremoso. Cubra com o restante do purê.\n6. Leve ao forno pré-aquecido a 200°C por cerca de 20 minutos, ou até que fique dourado.\n7. Retire do forno e finalize com cheiro verde picado por cima.'),
    Receita(
        tituloReceita: "Paçoca",
        descricaoReceita:
            "As festas juninas já estão chegando! Está na hora de tirar as bandeirinhas do armário e preparar as receitas típicas, que todo mundo gosta. Que tal começar pela paçoca? Esse docinho tradicional costuma agradar desde as crianças até os adultos e é super fácil de fazer. Confira:",
        tempoDePreparo: '30 a 40 minutos',
        imagemReceita: 'assets/pacoca.jpg',
        ingredientesReceita:
            '1/2 kg de amendoim torrado (sem casca e sem pele)\n1 xícara (chá) de farinha de milho\n2 xícaras (chá) de açúcar\n1 colher (café) de sal',
        modoDePreparo:
            '1. Torre o amendoim por aproximadamente 20 minutos.\n2. Bata no liquidificador até que fique todo triturado.\n3. Coloque em uma vasilha grande para que possa misturar todos os ingredientes bem.\n4. Bata a bolacha também no liquidificador, misture ao amendoim.\n5. Coloque o leite condensado aos poucos, mexendo bem, até que fique uma massa bem dura.\n6. Espalhe em uma forma média untada com margarina, apertando bem com as mãos.\n7. Deixe descansar por 20 minutos e corte os quadradinhos.'),
  ];

  final List<Receita> _receitasFavoritadas = [
    Receita(
        tituloReceita: "Smoothie",
        descricaoReceita:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        tempoDePreparo: '5 a 10 minutos',
        imagemReceita: 'assets/smoothie.png',
        ingredientesReceita:
            '1 xícara de morangos frescos (lavados e sem o cabinho)\n1 banana média madura\n1/2 xícara de leite\n1/2 xícara de iogurte natural\n1 colher de sopa de mel (opcional)\nGelo a gosto',
        modoDePreparo:
            '1. Lave bem os morangos e retire os cabinhos. Corte-os em pedaços pequenos e coloque em um liquidificador.\n2. Adicione a banana cortada em rodelas, o leite, o iogurte e o mel (se desejar um smoothie mais doce).\n3. Adicione algumas pedras de gelo e bata todos os ingredientes no liquidificador até obter uma mistura homogênea e cremosa.\n4. Se preferir, adicione mais gelo e bata novamente até atingir a consistência desejada.\n5. Sirva em um copo e adicione uma fatia de morango ou algumas folhas de hortelã para decorar.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'EasyCook',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.red),
            onPressed: () => logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    username!,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                verificado == true
                    ? Icon(
                        Icons.verified_outlined,
                        color: Colors.red,
                      )
                    : SizedBox.shrink()
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _editDataProfile(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD32F2F),
              ),
              child: Text(
                'Editar perfil',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      mostrarReceitasPublicadas = true;
                      mostrarReceitasFavoritadas = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: mostrarReceitasPublicadas
                          ? Colors.red
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.menu,
                      color: mostrarReceitasPublicadas
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 150),
                InkWell(
                  onTap: () {
                    setState(() {
                      mostrarReceitasPublicadas = false;
                      mostrarReceitasFavoritadas = true;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: mostrarReceitasFavoritadas
                          ? Colors.red
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.favorite,
                      color: mostrarReceitasFavoritadas
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (mostrarReceitasPublicadas)
                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _receitasPublicadas.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RecipeScreen(
                                        receita: _receitasPublicadas[index])),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                      _receitasPublicadas[index].imagemReceita),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      _receitasPublicadas[index].tituloReceita,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                if (mostrarReceitasFavoritadas)
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _receitasFavoritadas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeScreen(
                                      receita: _receitasFavoritadas[index])),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    _receitasFavoritadas[index].imagemReceita),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    _receitasFavoritadas[index].tituloReceita,
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
