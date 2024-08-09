import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<LessonTile> lessonTiles = [
    const LessonTile(
      title: "Introduction",
      description: "Variables allow user to hold ...",
      progress: 1.0,
    ),
    const LessonTile(
      title: "Introduction",
      description: "Variables allow user to hold ...",
      progress: 0.5,
    ),
    const LessonTile(
      title: "Introduction",
      description: "Variables allow user to hold ...",
      progress: 0.2,
    ),
    const LessonTile(
      title: "Introduction",
      description: "Variables allow user to hold ...",
      progress: 0.0,
    ),
  ];

  void addLessonTile() {
    setState(() {
      lessonTiles.insert(
          0,
          const LessonTile(
            title: "New Lesson",
            description: "New lesson description ...",
            progress: 0.0,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B1FA2), Color(0xFFD81B60)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0)
                      .copyWith(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      PopupMenuButton<int>(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onSelected: (item) => onSelected(context, item),
                        itemBuilder: (context) => [
                          const PopupMenuItem<int>(
                            height: 25,
                            value: 0,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Delete'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        "UX Designer from Scratch.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Basic guideline & tips & tricks for how to become a UX designer easily.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(0.6),
                            radius: 30,
                            child: const Icon(
                              FontAwesomeIcons.userAlt,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border_outlined,
                                color: Colors.yellow, size: 40),
                            onPressed: () {
                              // Bookmark functionality here
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFFB41672),
                          indicatorWeight:
                              3.0, // Thickness of the indicator line
                          tabs: [
                            Tab(text: "Playlist"),
                            Tab(text: "Author"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Playlist",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: addLessonTile,
                                          icon: const Icon(Icons.add,
                                              color: Colors.white),
                                          label: const Text("Add",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFB41672),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...lessonTiles,
                                  ],
                                ),
                              ),
                              const Center(child: Text('Author')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Add delete functionality here
        break;
    }
  }
}

class LessonTile extends StatelessWidget {
  final String title;
  final String description;
  final double progress;

  const LessonTile({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                progress == 1.0 ? Icons.check_circle : Icons.play_circle_fill,
                color: progress == 1.0 ? Colors.green : const Color(0xFFB41672),
                size: 32,
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(description),
            ),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: const Color(0xFFB41672),
            ),
          ],
        ),
      ),
    );
  }
}
