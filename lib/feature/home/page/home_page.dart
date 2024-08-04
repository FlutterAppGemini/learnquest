import 'package:flutter/material.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';
import 'package:learnquest/feature/home/components/bottom_nav_item.dart';
import 'package:learnquest/feature/learning/page/learning_page.dart';
import 'package:learnquest/feature/profile/page/profile_page.dart';
import 'package:learnquest/feature/loading_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  int _selectedIndex = 1;
  List<Lesson> lessons = [];
  final PageController _pageController = PageController(initialPage: 1);

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
              LearningPage(
                lessons: lessons,
              ),
              ChatPage(
                setLoading: _setLoading,
                lessons: lessons,
              ),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: AnimatedBottomNav(
            currentIndex: _selectedIndex,
            onChange: _onItemTapped,
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              _onItemTapped(1);
            },
            child: Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF8E44AD),
                    Color(0xFFBB8FCE),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomLeft,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
        LoadingOverlay(isLoading: _isLoading),
      ],
    );
  }
}

class AnimatedBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChange;

  const AnimatedBottomNav(
      {super.key, required this.currentIndex, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkResponse(
              onTap: () => onChange(0),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: BottomNavItem(
                icon: Icons.book,
                title: "Learning",
                isActive: currentIndex == 0,
              ),
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: InkResponse(
              onTap: () => onChange(2),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: BottomNavItem(
                icon: Icons.person,
                title: "Profile",
                isActive: currentIndex == 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
