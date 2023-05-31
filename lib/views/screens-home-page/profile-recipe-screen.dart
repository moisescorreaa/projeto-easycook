import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileRecipeDetailScreen extends StatefulWidget {
  final DocumentSnapshot recipeDocument;

  ProfileRecipeDetailScreen({required this.recipeDocument});

  @override
  _ProfileRecipeDetailScreenState createState() => _ProfileRecipeDetailScreenState();
}

class _ProfileRecipeDetailScreenState extends State<ProfileRecipeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final titulo = widget.recipeDocument['titulo'];
    final imageUrl = widget.recipeDocument['imageUrl'];
    final descricao = widget.recipeDocument['descricao'];
    final ingredientes = widget.recipeDocument['ingredientes'];
    final modo = widget.recipeDocument['modo'];
    final tempo = widget.recipeDocument['tempo'];

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
            ],
          ),
        ),
      ),
    );
  }
}
