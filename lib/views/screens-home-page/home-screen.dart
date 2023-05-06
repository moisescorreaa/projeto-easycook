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
      imagem: 'assets/lasanha-italiana.jpg',
      titulo: 'Lasanha Italiana',
      descricao:
          'Aprenda a fazer uma deliciosa lasanha italiana com massa fresca e molho de tomate caseiro.',
    ),
    Postagem(
      imagem: 'assets/bolo-chocolate.jpg',
      titulo: 'Bolo de Chocolate',
      descricao:
          'Aprenda a fazer um bolo de chocolate fofinho com cobertura de brigadeiro.',
    ),
    Postagem(
      imagem: 'assets/pizza-margherita.jpg',
      titulo: 'Pizza Margherita',
      descricao:
          'Aprenda a fazer uma deliciosa pizza margherita com massa fina e crocante.',
    ),
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
            icon: Icon(
              Icons.filter_list,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _postagens.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 10,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Nome do Usuário',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: ClipRRect(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage(_postagens[index].imagem,))
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _postagens[index].titulo,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              _postagens[index].descricao,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Ver receita',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}