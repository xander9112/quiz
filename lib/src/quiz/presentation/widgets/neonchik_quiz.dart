import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class NeonchikQuiz extends StatefulWidget {
  const NeonchikQuiz({
    required this.onPressed,
    required this.title,
    required this.answers,
    this.timeToShowAnswer = const Duration(seconds: 3),
    super.key,
  });

  final String title;

  final List<QuizDTOAnswer> answers;

  final Future<bool> Function(String value) onPressed;

  final Duration timeToShowAnswer;

  @override
  State<NeonchikQuiz> createState() => _NeonchikQuizState();
}

class _NeonchikQuizState extends State<NeonchikQuiz>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  List<String> answers = const ['A', 'B', 'C', 'D'];

  Random random = Random();

  bool onPause = false;

  late Duration showAnswers;

  bool fail = false;

  bool congratulation = false;

  final player = AudioPlayer();

  @override
  void initState() {
    showAnswers = widget.timeToShowAnswer + (answers.length * 300).ms;

    _controller = AnimationController(vsync: this);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward(from: 0);
    });
  }

  String _getRandomAnswer() {
    return answers[random.nextInt(4)];
  }

  @override
  void reassemble() {
    super.reassemble();
    pause();
    resume();
  }

  @override
  void dispose() {
    player.dispose();

    super.dispose();
  }

  void pause() {
    onPause = true;
  }

  void resume() {
    onPause = false;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      controller: _controller,
      effects: const [],
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 3,
                child: NeonchikQuizHeader(
                  title: widget.title,
                  answers: widget.answers,
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    NeonAnim1(
                      getRandomAnswer: _getRandomAnswer,
                      timeToShowAnswer: showAnswers,
                      onPressedAnswer: onPressedAnswer,
                      onPause: onPause,
                    ),
                    NeonAnim2(
                      getRandomAnswer: _getRandomAnswer,
                      timeToShowAnswer: showAnswers + 600.ms,
                      onPressedAnswer: onPressedAnswer,
                      onPause: onPause,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    NeonAnim3(
                      getRandomAnswer: _getRandomAnswer,
                      timeToShowAnswer: showAnswers + 1200.ms,
                      onPressedAnswer: onPressedAnswer,
                      onPause: onPause,
                    ),
                    NeonAnim4(
                      getRandomAnswer: _getRandomAnswer,
                      timeToShowAnswer: showAnswers + 1800.ms,
                      onPressedAnswer: onPressedAnswer,
                      onPause: onPause,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (fail)
            const Positioned.fill(
              child: LottieAnimation(
                type: LottieType.fail,
              ),
            ),
          if (congratulation)
            const Positioned.fill(
              child: LottieAnimation(
                type: LottieType.fireworks,
              ),
            ),
        ],
      ),
    );
  }

  Future<void> onPressedAnswer(String answer) async {
    if (onPause) return;

    pause();

    final isCorrect = await widget.onPressed.call(answer);

    if (isCorrect) {
      await player.stop();
      await player.play(AssetSource('audio/win.wav'));

      setState(() {
        congratulation = true;
      });
    } else {
      await player.stop();
      await player.play(AssetSource('audio/wrong-answer.wav'));

      setState(() {
        fail = true;
      });
      await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
        if (mounted) {
          setState(() {
            fail = false;
          });
          resume();
        }
      });
    }
  }
}
