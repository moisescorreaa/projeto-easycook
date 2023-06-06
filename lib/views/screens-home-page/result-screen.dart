import 'package:easycook_main/views/screens-home-page/home-detail-screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultadoPesquisaScreen extends StatefulWidget {
  final List<String> ingredientes;

  ResultadoPesquisaScreen({required this.ingredientes});

  @override
  _ResultadoPesquisaScreenState createState() =>
      _ResultadoPesquisaScreenState();
}

class _ResultadoPesquisaScreenState extends State<ResultadoPesquisaScreen> {
  late List<QueryDocumentSnapshot> recipes;
  late List<QueryDocumentSnapshot> filteredRecipes;

  @override
  void initState() {
    super.initState();
    filteredRecipes = [];
    searchRecipes();
  }

  // void searchRecipes() {
  //   FirebaseFirestore.instance
  //       .collection('receitas')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     setState(() {
  //       recipes = querySnapshot.docs;
  //       filteredRecipes = recipes.where((recipe) {
  //         final List<String> ingredientsLowerCase = recipe['ingredientes']
  //             .map<String>((ingredient) => ingredient.toString().toLowerCase())
  //             .toList();

  //         return widget.ingredientes.every((searchIngredient) =>
  //             ingredientsLowerCase.contains(searchIngredient));
  //       }).toList();
  //     });
  //   }).catchError((error) {
  //     print('Erro ao buscar receitas: $error');
  //   });
  // }
  void searchRecipes() {
  FirebaseFirestore.instance
      .collection('receitas')
      .get()
      .then((QuerySnapshot querySnapshot) {
    setState(() {
      recipes = querySnapshot.docs;
      filteredRecipes = recipes.where((recipe) {
        final List<String> ingredientsLowerCase = recipe['ingredientes']
            .map<String>((ingredient) => ingredient.toString().toLowerCase())
            .toList();

        return widget.ingredientes.every((searchIngredient) =>
            ingredientsLowerCase.any((ingredient) =>
                ingredient.contains(searchIngredient.trim().toLowerCase())));
      }).toList();
    });
  }).catchError((error) {
    print('Erro ao buscar receitas: $error');
  });
}


  void navigateToHomeRecipeDetail(DocumentSnapshot recipeDocument) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomeRecipeDetailScreen(recipeDocument: recipeDocument)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: Container(
        child: filteredRecipes.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              'Receitas encontradas',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredRecipes.length,
                      itemBuilder: (context, index) {
                        final document = recipes[index];
                        final imageUrl = document['imageUrl'];
                        final titulo = document['titulo'];
                        final curtidas = document['curtidas'];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () => navigateToHomeRecipeDetail(document),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            titulo,
                                            style:
                                                TextStyle(color: Colors.white),
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
                  ],
                ),
              )
            : Center(
                child: Text('Nenhuma receita encontrada.'),
              ),
      ),
    );
  }
}
