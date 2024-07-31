import 'package:flutter/material.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';
import 'package:learnquest/feature/learning/page/learning_page.dart';
import 'package:learnquest/feature/loading_overlay.dart';
import 'package:learnquest/feature/profile/page/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  Future<void> _simulateLoading() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      _isLoading = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              ChatPage(setLoading: _setLoading),
              const LearningPage(
                lessons: [
                  // Lesson(
                  //     title: 'Aprender Flutter',
                  //     color: 'FF5733', // Color en formato hexadecimal
                  //     img: 'https://i.ibb.co/MpF3frb/flutter-207x256.png'),
                  // Lesson(
                  //     title: 'Programación en Dart',
                  //     color: '33FF57', // Color en formato hexadecimal
                  //     img: 'https://i.ibb.co/0y7VDnV/dart-255x256.png'),
                  // Lesson(
                  //   title: 'Interfaz de Usuario',
                  //   color: '3399FF', // Color en formato hexadecimal
                  //   img:
                  //       'https://iconduck.com/icons/7533/search.png', // GIF relacionado con diseño de interfaz
                  // ),
                  // Lesson(
                  //   title: 'Desarrollo Web',
                  //   color: 'FF33A2', // Color en formato hexadecimal
                  //   img:
                  //       'https://iconduck.com/illustrations/107688/web-development.png', // GIF relacionado con desarrollo web
                  // ),
                  // Lesson(
                  //   title: 'Bases de Datos',
                  //   color: 'FFD733', // Color en formato hexadecimal
                  //   img:
                  //       'https://iconduck.com/icons/92756/database-sql.png', // GIF relacionado con bases de datos
                  // ),
                  // Lesson(
                  //   title: 'Programación Orientada a Objetos',
                  //   color: '9B59B6', // Color en formato hexadecimal
                  //   img:
                  //       'https://iconduck.com/illustrations/105639/coding.png', // GIF relacionado con POO
                  // ),
                  // Lesson(
                  //   title: 'Algoritmos y Estructuras de Datos',
                  //   color: 'FF6F61', // Color en formato hexadecimal
                  //   img:
                  //       'https://iconduck.com/icons/138675/ai-mi-algorithm.png', // GIF relacionado con algoritmos
                  // )
                ],
              ),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Learning',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        LoadingOverlay(isLoading: _isLoading),
      ],
    );
  }
}
