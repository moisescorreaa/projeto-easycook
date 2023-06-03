import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycook_main/views/screens-home-page/home-detail-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    inicializaData();
  }

  DateTime now = DateTime.now();
  DateTime? startDate;

  inicializaData() {
    startDate = DateTime(now.year, now.month, 1);
  }

  void navigateToHomeRecipeDetail(DocumentSnapshot recipeDocument) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              HomeRecipeDetailScreen(recipeDocument: recipeDocument)),
    );
  }

  showDatePickerDialog() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: startDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.red,
              onPrimary: Colors.white,
              onSurface: Colors.red,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  void updateLikes(DocumentSnapshot document, List<String> likes) {
    FirebaseFirestore.instance
        .collection('receitas')
        .doc(document.id)
        .update({'curtidas': likes});
  }

  @override
  Widget build(BuildContext context) {
    final uid = auth
        .currentUser?.uid; // Substitua pelo UID do usuário atualmente logado

    return Scaffold(
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
            onPressed: () => showDatePickerDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('receitas')
                  .where('dateTime', isGreaterThanOrEqualTo: startDate)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<QueryDocumentSnapshot> recipes =
                      snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final document = recipes[index];
                      final photoUser = document['photoUser'];
                      final nameUser = document['nameUser'];
                      final imageUrl = document['imageUrl'];
                      final titulo = document['titulo'];
                      final descricao = document['descricao'];

                      List<String> likes = [];
                      if (document['curtidas'] != null) {
                        likes = List<String>.from(document['curtidas']);
                      }

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
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(photoUser),
                                    maxRadius: 10,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    nameUser,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: ClipRRect(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titulo,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    descricao,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 16, top: 8, bottom: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('receitas')
                                        .doc(document.id)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final likes =
                                            (snapshot.data!['curtidas']
                                                    as List<dynamic>)
                                                .map((uid) => uid.toString())
                                                .toList();
                                        final isLiked = likes.contains(uid);

                                        return IconButton(
                                          icon: Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (isLiked) {
                                                // Remove a curtida do usuário
                                                likes.remove(uid);
                                              } else {
                                                // Adicione a curtida do usuário
                                                likes.add(uid!);
                                              }
                                              // Atualize as curtidas no Firestore
                                              updateLikes(document, likes);
                                            });
                                          },
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  Text(
                                    '${likes.length.toString()} ${likes.length == 1 ? "curtida" : "curtidas"}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: TextButton(
                                      onPressed: () {
                                        // Navegue para a tela de detalhes da receita
                                        navigateToHomeRecipeDetail(document);
                                      },
                                      child: Text(
                                        'Ver receita',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
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
