import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class Receita {
  final String titulo;
  final String descricao;
  final String imagem;

  Receita(
      {required this.titulo, required this.descricao, required this.imagem});
}

class User {
  final String nome;
  final String imagem;

  User({required this.nome, required this.imagem});
}

bool mostrarReceitasPublicadas = true;
bool mostrarReceitasFavoritadas = false;

User user = User(nome: "Moisés Rodrigo", imagem: 'assets/user.png');

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Receita> _receitasPublicadas = [
    Receita(
        titulo: "Mousse de Maracujá",
        descricao:
            "Aprenda a fazer uma sobremesa deliciosa, refrescante e fácil de preparar.",
        imagem: 'assets/mousse-maracuja.jpg'),
    Receita(
        titulo: "Mousse de Maracujá",
        descricao:
            "Aprenda a fazer uma sobremesa deliciosa, refrescante e fácil de preparar.",
        imagem: 'assets/mousse-maracuja.jpg'),
    Receita(
        titulo: "Mousse de Maracujá",
        descricao:
            "Aprenda a fazer uma sobremesa deliciosa, refrescante e fácil de preparar.",
        imagem: 'assets/mousse-maracuja.jpg'),
    Receita(
        titulo: "Mousse de Maracujá",
        descricao:
            "Aprenda a fazer uma sobremesa deliciosa, refrescante e fácil de preparar.",
        imagem: 'assets/mousse-maracuja.jpg'),
    Receita(
        titulo: "Escondidinho de Camarão",
        descricao:
            "Aprenda a fazer um prato delicioso e fácil para uma reunião entre amigos ou família.",
        imagem: 'assets/escondidinho-camarao.jpg'),
    Receita(
        titulo: "Escondidinho de Camarão",
        descricao:
            "Aprenda a fazer um prato delicioso e fácil para uma reunião entre amigos ou família.",
        imagem: 'assets/escondidinho-camarao.jpg'),
    Receita(
        titulo: "Escondidinho de Camarão",
        descricao:
            "Aprenda a fazer um prato delicioso e fácil para uma reunião entre amigos ou família.",
        imagem: 'assets/escondidinho-camarao.jpg'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png')
  ];

  final List<Receita> _receitasFavoritadas = [
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png'),
    Receita(
        titulo: "Smoothie",
        descricao:
            "Aprenda a fazer smoothie, uma bebida cremosa, saudável e refrescante",
        imagem: 'assets/smoothie.png')
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(user.imagem),
            ),
            SizedBox(height: 16),
            Text(
              user.nome,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 150),
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image:
                                  AssetImage(_receitasPublicadas[index].imagem),
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
                                  _receitasPublicadas[index].titulo,
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                  _receitasFavoritadas[index].imagem),
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
                                  _receitasFavoritadas[index].titulo,
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
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
