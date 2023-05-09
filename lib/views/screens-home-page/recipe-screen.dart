import 'package:easycook_main/views/screens-home-page/profile-screen.dart';
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  final Receita receita;

  RecipeScreen({required this.receita});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
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
            icon: Icon(Icons.edit, color: Colors.red),
            onPressed: () {
              setState(() {});
            },
          ),
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
                    image: AssetImage(widget.receita.imagemReceita),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.receita.tituloReceita,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                widget.receita.descricaoReceita,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Ingredientes:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.receita.ingredientesReceita,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Modo de preparo:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.receita.modoDePreparo,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Text(
                "Tempo de preparo:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                widget.receita.tempoDePreparo,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
