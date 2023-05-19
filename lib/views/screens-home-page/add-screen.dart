import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  XFile? imagem;
  String? titulo;
  String? descricao;
  List<String> ingredientes = [];
  int? tempo;
  String? modo;

  final TextEditingController _ingredientsController = TextEditingController();

  void _criarReceita() {
    if (imagem == null ||
        titulo == null ||
        descricao == null ||
        ingredientes.isEmpty ||
        tempo == null ||
        modo == null) {
      // Se algum campo obrigatório não foi preenchido, exibe um aviso e retorna.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos não preenchidos'),
            content: Text('Preencha todos os campos para criar a receita.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      return;
    }

    Receita novaReceita = Receita(
      tituloReceita: titulo,
      descricaoReceita: descricao,
      ingredientesReceita: List.from(ingredientes),
      tempoDePreparo: tempo,
      modoDePreparo: modo,
      imagemReceita: imagem,
    );
  }

  selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) setState(() => imagem = file);
    } catch (e) {
      print(e);
    }
  }

  void _addIngredient() {
    setState(() {
      ingredientes.add(_ingredientsController.text);
      _ingredientsController.clear();
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: InkWell(
                  onTap: selecionarImagem,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child: Row(
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
              // TextField para o título da receita
              TextField(
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
                onChanged: (value) {
                  titulo = value;
                },
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 10),
              // TextField para a descrição da receita
              TextField(
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
              // TextField para a lista de ingredientes da receita
              Row(
                children: [
                  Expanded(
                    child: TextField(
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
              // TextField para o tempo de preparo
              TextField(
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
              TextField(
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
                    onPressed: () => _criarReceita(),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Postar'),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class Receita {
  final XFile? imagemReceita;
  final String? tituloReceita;
  final String? descricaoReceita;
  final List<String> ingredientesReceita;
  final int? tempoDePreparo;
  final String? modoDePreparo;

  Receita({
    required this.imagemReceita,
    required this.tituloReceita,
    required this.descricaoReceita,
    required this.ingredientesReceita,
    required this.tempoDePreparo,
    required this.modoDePreparo,
  });
}
