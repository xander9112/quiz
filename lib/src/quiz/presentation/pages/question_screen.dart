import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  final String question = 'Какой язык программирования ты любишь больше всего?';
  final List<String> answers = [
    'Dart',
    'JavaScript',
    'Python',
    'Kotlin',
  ];

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    super.initState();
    // Стартуем анимацию при загрузке экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward(from: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Animate(
            controller: _controller,
            effects: const [],
            child: Column(
              children: [
                Text(
                  question,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(
                      duration: 600.ms,
                      delay: const Duration(milliseconds: 300),
                    )
                    .moveY(
                      begin: size.height / 2,
                      end: 0,
                      duration: 300.ms,
                      delay: const Duration(milliseconds: 900),
                    ),

                const SizedBox(height: 40),

                // ОТВЕТЫ
                ...answers.asMap().entries.map(
                  (entry) {
                    final i = entry.key;
                    final answer = entry.value;
                    return TextButton(
                      onPressed: () {}, // пока без логики
                      child: Text(
                        answer,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                        .animate()
                        .then(delay: 1500.ms + (i * 300).ms)
                        .fadeIn(duration: 500.ms)
                        .moveY(begin: 30, end: 0, duration: 500.ms)
                        .then(delay: 1500.ms + (i * 300).ms);
                    // .delay(
                    //   1500.ms + (i * 300).ms,
                    // ); // задержка для последовательности
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
