import 'package:image_picker/image_picker.dart';

class Usuarios {
  final String usernameUsuario;
  final String? id;
  String fotoPerfil;

  Usuarios({
    required this.usernameUsuario,
    required this.id,
    this.fotoPerfil = 'assets/user.png',
  });
}
