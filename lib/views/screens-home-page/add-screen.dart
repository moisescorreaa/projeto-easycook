import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class Receita {
  final String imagemReceita;
  final String tituloReceita;
  final String descricao;
  final List<String> ingredientes;
  final int tempoDePreparo;
  final String modoDePreparo;

  Receita({
    required this.imagemReceita,
    required this.tituloReceita,
    required this.descricao,
    required this.ingredientes,
    required this.tempoDePreparo,
    required this.modoDePreparo,
  });
}

class _AddScreenState extends State<AddScreen> {
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
    );
  }
}
