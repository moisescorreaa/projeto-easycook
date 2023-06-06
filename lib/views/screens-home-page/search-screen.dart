import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycook_main/views/screens-home-page/home-detail-screen.dart';
import 'package:easycook_main/views/screens-home-page/result-screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> busca = [];

  void navigateToHomeRecipeDetail(DocumentSnapshot recipeDocument) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeRecipeDetailScreen(recipeDocument: recipeDocument),
      ),
    );
  }

  void searchRecipes() {
    setState(() {
      busca = _searchController.text
          .split(',')
          .map((ingredient) => ingredient.trim().toLowerCase())
          .toList();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultadoPesquisaScreen(ingredientes: busca),
      ),
    );
  }

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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 50,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText:
                        "Digite os ingredientes disponíveis separados por vírgula",
                    hintStyle: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: searchRecipes,
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('receitas').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> recipes =
                      snapshot.data!.docs;

                  // Ordenar as receitas localmente com base no número de curtidas e compara 
                  recipes.sort((a, b) {
                    final List<String> curtidasA =
                        List<String>.from(a['curtidas'] ?? []);
                    final List<String> curtidasB =
                        List<String>.from(b['curtidas'] ?? []);
                    return curtidasB.length.compareTo(curtidasA.length);
                  });
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Receitas populares',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              final document = recipes[index];
                              final imageUrl = document['imageUrl'];
                              final titulo = document['titulo'];
                              final curtidas =
                                  List<String>.from(document['curtidas'] ?? []);
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () =>
                                      navigateToHomeRecipeDetail(document),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(imageUrl),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  titulo,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            '${curtidas.length.toString()} ${curtidas.length == 1 ? "curtida" : "curtidas"}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
