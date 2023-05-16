import 'package:easycook_main/views/screens-home-page/add-screen.dart';
import 'package:easycook_main/views/screens-home-page/home-screen.dart';
import 'package:easycook_main/views/screens-home-page/profile-screen.dart';
import 'package:easycook_main/views/screens-home-page/search-screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _selectedIndex identifica qual lugar da navbar estamos.
  int _selectedIndex = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: _selectedIndex);
  }

  setPaginaAtual(pagina) {
    setState(() {
      _selectedIndex = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          HomeScreen(),
          SearchScreen(),
          AddScreen(),
          ProfileScreen(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Color(0xFF757575),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}
