import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycook_main/views/screens-home-page/edit-recipe-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileRecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot recipeDocument;

  ProfileRecipeDetailScreen({required this.recipeDocument});

  @override
  _ProfileRecipeDetailScreenState createState() =>
      _ProfileRecipeDetailScreenState();
}

class _ProfileRecipeDetailScreenState extends State<ProfileRecipeDetailScreen> {
  late String titulo;
  late String imageUrl;
  late String descricao;
  late List<dynamic> ingredientes;
  late String modo;
  late int tempo;

  Future<void> deleteRecipe() async {
    try {
      // volta para tela anterior
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      // Pega a referencia do documento
      final recipeRef = widget.recipeDocument.reference;

      // deleta o documento do banco
      await recipeRef.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receita excluída com sucesso!'),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocorreu um erro ao excluir a receita'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  deleteRecipeDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Você tem certeza que deseja excluir sua receita?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () => deleteRecipe(),
                    child: Text("Continuar"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  _navigateToEditDetailRecipe() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditRecipeScreen(recipeDocument: widget.recipeDocument),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: widget.recipeDocument.reference.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
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
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Atualiza os atributos com os dados do snapshot
        final data = snapshot.data!.data() as Map<String, dynamic>;
        titulo = data['titulo'];
        imageUrl = data['imageUrl'];
        descricao = data['descricao'];
        ingredientes = data['ingredientes'];
        modo = data['modo'];
        tempo = data['tempo'];

        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.red),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                  onPressed: () => _navigateToEditDetailRecipe(),
                  icon: Icon(Icons.edit_rounded, color: Colors.red))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    descricao,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Ingredientes:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredientes.map<Widget>((ingrediente) {
                      return Text(
                        ingrediente.toString(),
                        style: TextStyle(fontSize: 18),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Modo de preparo:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    modo,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Tempo de preparo:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${tempo.toString()} minutos",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: deleteRecipeDialog,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Excluir Receita'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
