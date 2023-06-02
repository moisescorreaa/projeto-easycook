import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditRecipeScreen extends StatefulWidget {
  final DocumentSnapshot recipeDocument;

  EditRecipeScreen({required this.recipeDocument});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final tituloController = TextEditingController();
  final descricaoController = TextEditingController();
  final ingredientsController = TextEditingController();
  final modoController = TextEditingController();
  final tempoController = TextEditingController();

  List<dynamic> ingredientes = [];
  List<String> ingredientesString = [];
  XFile? imagem;

  var _formKey = GlobalKey<FormState>();

  String? imagemAntiga;

  @override
  void initState() {
    super.initState();
    _transformIngredients();

    // Preenche os controladores com os dados atuais da receita
    imagemAntiga = widget.recipeDocument['imageUrl'];
    tituloController.text = widget.recipeDocument['titulo'];
    descricaoController.text = widget.recipeDocument['descricao'];
    modoController.text = widget.recipeDocument['modo'];
    tempoController.text = widget.recipeDocument['tempo'].toString();
  }

  @override
  void dispose() {
    // Limpa os controladores ao sair da tela para evitar vazamentos de memória
    tituloController.dispose();
    descricaoController.dispose();
    modoController.dispose();
    tempoController.dispose();
    super.dispose();
  }

  _transformIngredients() {
    ingredientes = widget.recipeDocument['ingredientes'];

    ingredientesString = ingredientes.map((item) => item.toString()).toList();
  }

  Future<void> updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        final recipeRef = widget.recipeDocument.reference;
        if (imagem != null) {
          // Upload da imagem para o Firebase Storage
          String imagemRef =
              'images/${auth.currentUser?.uid}/receitas/img-${DateTime.now().toString()}.jpg';
          Reference storageRef =
              FirebaseStorage.instance.ref().child(imagemRef);
          await storageRef.putFile(File(imagem!.path));

          // Obtenção do URL da imagem
          String imageUrl = await storageRef.getDownloadURL();

          recipeRef.update({
            'imageUrl': imageUrl,
          });
        }

        // Atualiza os dados no banco de dados usando o método "update"
        recipeRef.update({
          'titulo': tituloController.text,
          'descricao': descricaoController.text,
          'ingredientes': ingredientesString,
          'modo': modoController.text,
          'tempo': int.parse(tempoController.text),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receita alterada com sucesso!'),
            backgroundColor: Colors.red,
          ),
        );
        // Volta para a tela anterior
        Navigator.pop(context);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocorreu um erro ao alterar a receita'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      imagem = await picker.pickImage(source: ImageSource.gallery);
      if (imagem != null) {
        setState(() => imagem);
      }
    } catch (e) {
      print(e);
    }
  }

  String? _validarCampos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validarCamposIn(String? value) {
    if (ingredientesString.isEmpty) {
      if (value != null || ingredientesString.isEmpty) {
        return 'Campo Obrigatório';
      }
    }
    return null;
  }

  void _addIngredient() {
    if (ingredientsController.text.isNotEmpty)
      try {
        setState(() {
          ingredientesString.add(ingredientsController.text);
          ingredientsController.clear();
        });
      } catch (e) {
        print(e);
      }
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 200,
                  child: InkWell(
                    onTap: () => pickImage(),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(12.0),
                        child: imagem != null
                            ? Image.file(File(imagem!.path))
                            : Image.network(imagemAntiga!)),
                  ),
                ),
                Container(child: Text("Titulo")),
                TextFormField(
                  validator: _validarCampos,
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
                TextFormField(
                  validator: _validarCampos,
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: _validarCamposIn,
                        controller: ingredientsController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addIngredient,
                      color: Color.fromARGB(255, 100, 100, 100),
                    ),
                  ],
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: ingredientesString.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ingredientesString[index],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                ingredientesString.removeAt(index);
                              });
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Container(child: Text("Modo de Preparo")),
                TextFormField(
                  validator: _validarCampos,
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
                TextFormField(
                  validator: _validarCampos,
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
      ),
    );
  }
}
