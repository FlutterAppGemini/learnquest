import 'package:flutter/material.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/models/game.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/models/question.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';
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
  List<Course> courses = [
    Course(
        title: 'title',
        icon: 'add',
        color: Colors.red,
        description: 'description',
        lessons: [
          Lesson(
              title: 'title',
              content: 'content',
              progress: 0.9,
              game: Game(type: Type.write, data: [
                Question(
                    question: 'question',
                    response: ['dsad', 'dsada'],
                    solution: 'solution')
              ]))
        ]),
    Course(
        title: 'title',
        icon: 'add',
        color: Colors.red,
        description: 'description',
        lessons: [
          Lesson(
              title: 'title',
              content: 'content',
              progress: 0.9,
              game: Game(type: Type.write, data: [
                Question(
                    question: 'question',
                    response: ['dsad', 'dsada'],
                    solution: 'solution')
              ]))
        ]),
    Course(
        title: 'title',
        icon: 'add',
        color: Colors.red,
        description: 'description',
        lessons: [
          Lesson(
              title: 'title',
              content: 'content',
              progress: 0.9,
              game: Game(type: Type.write, data: [
                Question(
                    question: 'question',
                    response: ['dsad', 'dsada'],
                    solution: 'solution')
              ]))
        ]),
    Course(
        title: 'title',
        icon: 'add',
        color: Colors.red,
        description: 'description',
        lessons: [
          Lesson(
              title: 'title',
              content: 'content',
              progress: 0.9,
              game: Game(type: Type.write, data: [
                Question(
                    question: 'question',
                    response: ['dsad', 'dsada'],
                    solution: 'solution')
              ]))
        ])
  ];
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
                courses: courses,
              ),
              ChatPage(
                setLoading: _setLoading,
                courses: courses,
              ),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: Container(
            height: kToolbarHeight,
            margin:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Spacer(),
                IconButton(
                  onPressed: () => _onItemTapped(0),
                  icon: Icon(
                    Icons.book,
                    color: _selectedIndex == 0 ? Colors.purple : Colors.grey,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      _onItemTapped(1);
                    },
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => _onItemTapped(2),
                  icon: Icon(
                    Icons.person,
                    color: _selectedIndex == 2 ? Colors.purple : Colors.grey,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        LoadingOverlay(isLoading: _isLoading),
      ],
    );
  }
}
