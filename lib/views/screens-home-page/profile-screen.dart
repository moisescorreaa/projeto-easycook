import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycook_main/views/screens-home-page/profile-recipe-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool? verificado;
  String? username;
  String? imagemURL;
  XFile? imagem;

  String? newUsername;

  @override
  void initState() {
    super.initState();
    buscarDadosUsuario();
    verificarUsuario();
  }

  void logout() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5F5),
        title: const Text(
          'Você tem certeza que deseja sair?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancelar"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
              side: BorderSide(color: Colors.transparent),
            ),
          ),
          ElevatedButton(
            onPressed: () => logoutFunc(),
            child: Text("Confirmar"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void logoutFunc() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Logout realizado com sucesso')),
      );
      Navigator.pushReplacementNamed(context, '/show-login-register');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Erro ao realizar logout')),
      );
    }
  }

  void buscarDadosUsuario() {
    setState(() {
      username = auth.currentUser?.displayName;
      imagemURL = auth.currentUser?.photoURL;
    });
  }

  verificarUsuario() {
    if (auth.currentUser?.emailVerified == true) {
      setState(() => verificado = true);
    } else {
      setState(() => verificado = false);
    }
  }

  Future<void> alterarDadosUsuario() async {
    try {
      bool dadosAlterados = false;

      if (imagem != null) {
        String imagemRef =
            'images/${auth.currentUser?.uid}/perfil/img-${DateTime.now().toString()}.jpg';
        Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
        await storageRef.putFile(File(imagem!.path));
        imagemURL = await storageRef.getDownloadURL();
        setState(() => imagemURL);

        auth.currentUser?.updatePhotoURL(imagemURL);
        dadosAlterados = true;
      }

      if (newUsername != null && newUsername!.isNotEmpty) {
        auth.currentUser?.updateDisplayName(newUsername);
        setState(() => username = newUsername);
        dadosAlterados = true;
      }

      if (dadosAlterados) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Dados alterados com sucesso'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Nenhuma alteração realizada'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Ocorreu um erro ao alterar os dados'),
          duration: Duration(seconds: 3),
        ),
      );
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

  void _editDataProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Color(0xFFF5F5F5),
          title: const Text(
            "Editar Perfil",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => pickImage().then((_) {
                    setState(
                        () {}); // Atualiza a interface do pop-up após selecionar a imagem
                  }),
                  child: Container(
                    width: double.maxFinite,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: imagem != null
                        ? Image.file(File(imagem!.path))
                        : Container(
                            width: double.maxFinite,
                            height: 180,
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
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
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      newUsername = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Novo nome de perfil",
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cancelar"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        side: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => alterarDadosUsuario(),
                      child: Text("Enviar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void navigateToProfileRecipeDetail(DocumentSnapshot recipeDocument) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProfileRecipeDetailScreen(recipeDocument: recipeDocument)),
    );
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined, color: Colors.red),
            onPressed: () => logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              backgroundImage: NetworkImage(imagemURL!),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      username!,
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                verificado == true
                    ? Icon(
                        Icons.verified_outlined,
                        color: Colors.red,
                      )
                    : SizedBox.shrink()
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _editDataProfile(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD32F2F),
              ),
              child: Text(
                'Editar perfil',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu, color: Colors.red),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('receitas')
                    .where('uidUser', isEqualTo: auth.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<QueryDocumentSnapshot> recipes =
                        snapshot.data!.docs;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        final document = recipes[index];
                        final photoUser = document['photoUser'];
                        final nameUser = document['nameUser'];
                        final imageUrl = document['imageUrl'];
                        final titulo = document['titulo'];
                        final descricao = document['descricao'];
                        final curtidas = document['curtidas'];
            
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                            onTap: () => navigateToProfileRecipeDetail(document),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      titulo,
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
