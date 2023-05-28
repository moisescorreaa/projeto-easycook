import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();

  XFile? imagem;
  String? titulo;
  String? descricao;
  List<String> ingredientes = [];
  int? tempo;
  String? modo;

  TextEditingController _ingredientsController = TextEditingController();

  String? _validarCampos(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? _validarCamposIn(String? value) {
    if (ingredientes.isEmpty) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
    }
    return null;
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

  Future<void> salvarReceita() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Upload da imagem para o Firebase Storage
        String imagemRef =
            'images/${auth.currentUser?.uid}/receitas/img-${DateTime.now().toString()}.jpg';
        Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
        await storageRef.putFile(File(imagem!.path));

        // Obtenção do URL da imagem
        String imageUrl = await storageRef.getDownloadURL();

        // Criação do documento da receita no Firestore
        CollectionReference receitasRef =
            FirebaseFirestore.instance.collection('receitas');
        await receitasRef.add({
          'usernameRef': auth.currentUser?.displayName,
          'fotoPerfilRef': auth.currentUser?.photoURL,
          'imagemRef': imagemRef,
          'imageUrl': imageUrl,
          'titulo': titulo,
          'descricao': descricao,
          'ingredientes': ingredientes,
          'tempo': tempo,
          'modo': modo,
          'curtidas': 0,
        });

        setState(() {
          imagem = null;
          titulo = '';
          descricao = '';
          ingredientes = [];
          tempo = null;
          modo = '';
          _ingredientsController?.text = '';
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Receita postada com sucesso!'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        // Lida com erros, se houver
        print('Erro ao salvar a receita: $e');
      }
    }
  }

  void _addIngredient() {
    if (_ingredientsController.text.isNotEmpty)
      try {
        setState(() {
          ingredientes.add(_ingredientsController.text);
          _ingredientsController.clear();
        });
      } catch (e) {
        print(e);
      }
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: InkWell(
                    onTap: () => pickImage(),
                    child: Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(12.0),
                      child: imagem != null
                          ? Image.file(File(imagem!.path))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.insert_photo_outlined,
                                    color: Color.fromARGB(255, 100, 100, 100)),
                                SizedBox(width: 8.0),
                                Text(
                                  'Inserir Imagem',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Título da receita',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    prefixIcon: Icon(Icons.title),
                  ),
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  validator: _validarCampos,
                  onChanged: (value) {
                    titulo = value;
                  },
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: _validarCampos,
                  decoration: InputDecoration(
                    hintText: 'Descrição',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  onChanged: (value) {
                    descricao = value;
                  },
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: _validarCamposIn,
                        controller: _ingredientsController,
                        decoration: InputDecoration(
                          hintText: 'Digite o ingrediente',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12.0),
                          prefixIcon: Icon(Icons.add_shopping_cart),
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
                SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: ingredientes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ingredientes[index],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                ingredientes.removeAt(index);
                              });
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: _validarCampos,
                  decoration: InputDecoration(
                    hintText: 'Tempo de preparo (em minutos)',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    prefixIcon: Icon(Icons.timer),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    tempo = int.tryParse(value);
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: _validarCampos,
                  decoration: InputDecoration(
                    hintText: 'Modo de preparo',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    prefixIcon: Icon(Icons.receipt_long),
                  ),
                  maxLines: null,
                  onChanged: (value) {
                    modo = value;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => salvarReceita(),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Postar'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
