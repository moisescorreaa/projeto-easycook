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

User user = User(nome: "Moisés Rodrigo", imagem: 'assets/user.jpeg');

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Receita> receitas = [
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
      backgroundColor: Color(0xFFFFCB49),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
        children: [
          SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.imagem),
          ),
          SizedBox(height: 16),
          Text(
            user.nome,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 100),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Receitas publicadas",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            // Ocupa todo o espaço restante
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: receitas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(receitas[index].imagem),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            receitas[index].titulo,
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
          ),
        ],
      ),
    );
  }
}
