import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquest/common/routes/routes.dart';

class ChatPage extends StatefulWidget {
  final Function(bool) setLoading;
  const ChatPage({super.key, required this.setLoading});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<void> _simulateTask() async {
    widget.setLoading(true);

    await Future.delayed(const Duration(seconds: 5));

    widget.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    createTile(Learn learn) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.detail,
                arguments: learn,
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child:
                      _buildWikiCategory(learn.icon, learn.name, learn.color),
                ),
              ],
            ),
          ),
        );

    final liste = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: learn.map((l) => createTile(l)).toList(),
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 350,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 91, 31, 165),
                  Color.fromARGB(255, 153, 60, 211),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        border: OutlineInputBorder(),
                        hintText: "¿Que quieres aprender?",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: const Color.fromARGB(255, 1, 82, 173),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
              child: liste,
            ),
          ],
        ),
      ],
    );
  }

  Stack _buildWikiCategory(IconData icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Opacity(
              opacity: 0.3,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Learn {
  String name;
  IconData icon;
  Color color;
  Learn(
    this.name,
    this.icon,
    this.color,
  );
}

final List<Learn> learn = [
  Learn(
    'Math',
    Icons.design_services,
    Colors.blue[400]!,
  ),
  Learn(
    'Geography',
    Icons.public_sharp,
    Colors.orange[400]!,
  ),
  Learn(
    'Programming',
    Icons.computer,
    Colors.indigo[400]!,
  ),
  Learn(
    'Web',
    Icons.web,
    Colors.green[400]!,
  ),
  Learn(
    'Cook',
    Icons.food_bank,
    Colors.orange[400]!,
  ),
  Learn(
    'Cloud',
    Icons.filter_drama_outlined,
    Colors.lightBlue[600]!,
  ),
  Learn(
    'SQL',
    FontAwesomeIcons.database,
    Colors.lightGreen[600]!,
  ),
];
