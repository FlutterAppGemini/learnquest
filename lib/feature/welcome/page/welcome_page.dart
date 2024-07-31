import 'package:flutter/material.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/feature/welcome/components/animated_page_dragger.dart';
import 'package:learnquest/feature/welcome/components/page_dragger.dart';
import 'package:learnquest/feature/welcome/components/page_indicator.dart';
import 'package:learnquest/feature/welcome/components/page_reveal.dart';
import 'package:learnquest/feature/welcome/enum/slide_direction.dart';
import 'package:learnquest/feature/welcome/enum/transition_goal.dart';
import 'package:learnquest/feature/welcome/enum/update_type.dart';
import 'package:learnquest/feature/welcome/models/page_indicator_view_model.dart';
import 'dart:async';

import 'package:learnquest/feature/welcome/models/page_view_model.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late StreamController<SlideUpdate> slideUpdateStream;
  late AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  int nextPageIndex = 0;
  double slidePercent = 0.0;

  @override
  void initState() {
    super.initState();
    slideUpdateStream = StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          if (slidePercent > 0.5) {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          if (animatedPageDragger.transitionGoal == TransitionGoal.open) {
            activeIndex = nextPageIndex;
          }
          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PagerIndicator(
            viewModel: PagerIndicatorViewModel(
              pages,
              activeIndex,
              slideDirection,
              slidePercent,
            ),
          ),
          PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: slideUpdateStream,
          )
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  const Page({
    super.key,
    required this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: viewModel.color,
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(viewModel.heroAssetPath,
                    width: 200.0, height: 200.0),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  viewModel.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            if (viewModel == pages.last) // Si es la última página
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.auth);
                },
                child: const Text('Comenzar'),
              ),
          ],
        ),
      ),
    );
  }
}

final pages = [
  PageViewModel(
    const Color(0xFF5DADE2),
    'assets/images/welcome1.png',
    'Bienvenido a LearnQuest',
    'Descubre un mundo de aprendizaje personalizado. Genera rutas de estudio adaptadas a tus objetivos y preferencias.',
    const Icon(
      Icons.phone_android,
      color: Colors.white,
    ),
  ),
  PageViewModel(
    const Color(0xFF8E44AD),
    'assets/images/welcome2.png',
    'Explora y Aprende',
    'Navega a través de un mapa interactivo, completa niveles y desbloquea mundos de conocimiento. Aprende jugando y diviértete.',
    const Icon(
      Icons.travel_explore,
      color: Colors.white,
    ),
  ),
  PageViewModel(
    const Color(0xFFBB8FCE),
    'assets/images/welcome3.png',
    'Personaliza y Conecta',
    'Ajusta tu ruta de aprendizaje según tus necesidades. Únete a una comunidad de aprendices y comparte tus progresos.',
    const Icon(
      Icons.school,
      color: Colors.white,
    ),
  ),
];
