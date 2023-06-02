import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditRecipeScreen extends StatefulWidget {
  final DocumentSnapshot recipeDocument;

  EditRecipeScreen({required this.recipeDocument});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final ingredientesController = TextEditingController();
  final modoController = TextEditingController();
  final tempoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Preenche os controladores com os dados atuais da receita
    tituloController.text = widget.recipeDocument['titulo'];
    descricaoController.text = widget.recipeDocument['descricao'];
    ingredientesController.text =
        widget.recipeDocument['ingredientes'].join('\n');
    modoController.text = widget.recipeDocument['modo'];
    tempoController.text = widget.recipeDocument['tempo'].toString();
  }

  @override
  void dispose() {
    // Limpa os controladores ao sair da tela para evitar vazamentos de memória
    tituloController.dispose();
    descricaoController.dispose();
    ingredientesController.dispose();
    modoController.dispose();
    tempoController.dispose();
    super.dispose();
  }

  void updateRecipe() {
    final recipeRef = widget.recipeDocument.reference;

    // Atualiza os dados no banco de dados usando o método "update"
    recipeRef.update({
      'titulo': tituloController.text,
      'descricao': descricaoController.text,
      'ingredientes': ingredientesController.text.split('\n'),
      'modo': modoController.text,
      'tempo': int.parse(tempoController.text),
    });

    // Volta para a tela anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(child: Text("Titulo")),
              TextField(
                controller: tituloController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              Container(child: Text("Descrição")),
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
              Container(child: Text("Ingredientes")),
              TextField(
                controller: ingredientesController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                maxLines: null,
              ),
              Container(child: Text("Modo de Preparo")),
              TextField(
                controller: modoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                maxLines: null,
              ),
              Container(child: Text("Tempo de Preparo")),
              TextField(
                controller: tempoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: updateRecipe,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
