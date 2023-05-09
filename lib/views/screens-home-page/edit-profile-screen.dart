import 'package:easycook_main/views/screens-home-page/profile-screen.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Implementar ação de alterar foto
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(_user.imagem),
              ),
            ),
            SizedBox(height: 16),
            Text(
              _user.nome,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                initialValue: _user.nome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _user.nome = value;
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implementar ação de salvar alterações
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFD32F2F),
              ),
              child: Text(
                'Salvar alterações',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
