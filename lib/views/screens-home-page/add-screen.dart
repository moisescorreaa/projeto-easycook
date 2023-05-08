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
            title: Text('Campos obrigatórios não preenchidos'),
            content: Text(
                'Preencha todos os campos obrigatórios para criar a receita.'),
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

    // Aqui você pode fazer o que quiser com o objeto novaReceita.
    // Por exemplo, adicionar à lista de receitas ou salvá-lo em um banco de dados.
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
              ListTile(
                leading: Icon(Icons.insert_photo_outlined),
                title: Text("Inserir imagem"),
                onTap: selecionarImagem,
                trailing:
                    imagem != null ? Image.file(File(imagem!.path)) : null,
              ),
              SizedBox(height: 20),
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
                  fillColor: Color(0xFFF5F5F5),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                onChanged: (value) {
                  titulo = value;
                },
              ),
              SizedBox(height: 20),
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
                  fillColor: Color(0xFFF5F5F5),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (value) {
                  descricao = value;
                },
              ),
              SizedBox(height: 20),
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
                        fillColor: Color(0xFFF5F5F5),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addIngredient,
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
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              // TextField para o tempo de preparo da receita
              TextField(
                decoration: InputDecoration(
                  hintText: 'Tempo de preparo (em minutos)',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  tempo = int.tryParse(value);
                },
              ),
              // TextField para o modo de preparo da receita
              TextField(
                decoration: InputDecoration(
                  hintText: 'Modo de preparo',
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF5F5F5),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                maxLines: null,
                onChanged: (value) {
                  modo = value;
                },
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => _criarReceita(), child: Text('Postar')),
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
