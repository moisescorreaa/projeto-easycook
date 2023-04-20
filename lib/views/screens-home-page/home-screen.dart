import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Postagem {
  final String imagem;
  final String titulo;
  final String descricao;
  final int numeroCurtidas;
  bool curtida;

  Postagem({
    required this.imagem,
    required this.titulo,
    required this.descricao,
    this.curtida = false,
    this.numeroCurtidas = 0,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de postagens para exibir no feed de receitas
  final List<Postagem> _postagens = [
    Postagem(
      imagem: 'lasanha-italiana.jpg',
      titulo: 'Lasanha Italiana',
      descricao:
          'Aprenda a fazer uma deliciosa lasanha italiana com massa fresca e molho de tomate caseiro.',
    ),
    Postagem(
      imagem: 'bolo-chocolate.jpg',
      titulo: 'Bolo de Chocolate',
      descricao:
          'Aprenda a fazer um bolo de chocolate fofinho com cobertura de brigadeiro.',
    ),
    Postagem(
      imagem: 'pizza-margherita.jpg',
      titulo: 'Pizza Margherita',
      descricao:
          'Aprenda a fazer uma deliciosa pizza margherita com massa fina e crocante.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cor de fundo principal do seu aplicativo
      backgroundColor: Color(0xFFFFCB49),
      body: ListView.builder(
        itemCount: _postagens.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 2),
                        child: Text(
                          'Nome do Usuário',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Imagem da postagem
                Image.asset(
                  _postagens[index].imagem,
                  fit: BoxFit.cover,
                  width: 1080,
                  height: 608,
                ),
                // Título da postagem
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    _postagens[index].titulo,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF755807),
                    ),
                  ),
                ),
                // Descrição da postagem
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    _postagens[index].descricao,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF755807),
                    ),
                  ),
                ),
                // Botão de curtir
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _postagens[index].curtida
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _postagens[index].curtida =
                              !_postagens[index].curtida;
                        });
                      },
                    ),
                    Text(
                      '${_postagens[index].numeroCurtidas} ${_postagens[index].numeroCurtidas == 1 ? "curtida" : "curtidas"}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Text(
                        'Ver receita',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF755807),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
