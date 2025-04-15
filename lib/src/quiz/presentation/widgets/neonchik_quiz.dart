import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class NeonchikQuiz extends StatefulWidget {
  const NeonchikQuiz({
    required this.onPressed,
    required this.title,
    required this.answers,
    super.key,
  });

  final String title;

  final List<QuizDTOAnswer> answers;

  final Future<bool> Function(String value) onPressed;

  @override
  State<NeonchikQuiz> createState() => _NeonchikQuizState();
}

class _NeonchikQuizState extends State<NeonchikQuiz>
    with TickerProviderStateMixin {
  late final AnimationController _controller1;

  late final AnimationController _controller2;

  late final AnimationController _controller3;

  late final AnimationController _controller4;

  List<String> answers = const ['A', 'B', 'C', 'D'];

  late String answer1;

  late String answer2;

  late String answer3;

  late String answer4;

  Random random = Random();

  bool onPause = false;

  bool fail = false;

  bool congratulation = false;

  final player = AudioPlayer();

  @override
  void initState() {
    answer1 = _getRandomAnswer();

    answer2 = _getRandomAnswer();

    answer3 = _getRandomAnswer();

    answer4 = _getRandomAnswer();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() async {
        if (!_controller1.isAnimating &&
            _controller1.value == _controller1.upperBound) {
          await Future<void>.delayed(Durations.long4);

          answer1 = _getRandomAnswer();

          if (!onPause) unawaited(_controller1.reverse());
        }

        if (!_controller1.isAnimating &&
            _controller1.value == _controller1.lowerBound) {
          await Future<void>.delayed(Durations.long4);

          if (!onPause) unawaited(_controller1.forward());
        }
      });

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() async {
        if (!_controller2.isAnimating &&
            _controller2.value == _controller2.upperBound) {
          await Future<void>.delayed(const Duration(seconds: 2));

          if (!onPause) unawaited(_controller2.reverse());
        }

        if (!_controller2.isAnimating &&
            _controller2.value == _controller2.lowerBound) {
          await Future<void>.delayed(const Duration(seconds: 2));

          answer2 = _getRandomAnswer();

          if (!onPause) unawaited(_controller2.forward());
        }
      });

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() async {
        if (!_controller3.isAnimating &&
            _controller3.value == _controller3.upperBound) {
          answer3 = _getRandomAnswer();

          await Future<void>.delayed(const Duration(seconds: 2));

          if (!onPause) unawaited(_controller3.reverse());
        }

        if (!_controller3.isAnimating &&
            _controller3.value == _controller3.lowerBound) {
          await Future<void>.delayed(const Duration(seconds: 2));

          if (!onPause) unawaited(_controller3.forward());
        }
      });

    _controller4 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addListener(() async {
        if (!_controller4.isAnimating &&
            _controller4.value == _controller4.upperBound) {
          answer4 = _getRandomAnswer();

          await Future<void>.delayed(const Duration(seconds: 1));

          if (!onPause) unawaited(_controller4.reverse());
        }

        if (!_controller4.isAnimating &&
            _controller4.value == _controller4.lowerBound) {
          await Future<void>.delayed(const Duration(seconds: 1));

          if (!onPause) unawaited(_controller4.forward());
        }
      });

    _controller1.reverse(from: 1);

    Future<void>.delayed(const Duration(seconds: 1)).then((_) {
      _controller2.forward();
    });

    Future<void>.delayed(Durations.medium1).then((_) {
      _controller3.reverse(from: 1);
    });

    Future<void>.delayed(Durations.long4).then((_) {
      _controller4.reverse(from: 1);
    });

    super.initState();
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
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();

    player.dispose();

    super.dispose();
  }

  void pause() {
    onPause = true;
    _controller1.stop(canceled: false);
    _controller2.stop(canceled: false);
    _controller3.stop(canceled: false);
    _controller4.stop(canceled: false);
  }

  void resume() {
    onPause = false;

    _controller1.status.isForwardOrCompleted
        ? _controller1.reverse()
        : _controller1.forward();

    _controller2.status.isForwardOrCompleted
        ? _controller2.reverse()
        : _controller2.forward();

    _controller3.status.isForwardOrCompleted
        ? _controller3.reverse()
        : _controller3.forward();

    _controller4.status.isForwardOrCompleted
        ? _controller4.reverse()
        : _controller4.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: bgDecoration,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _controller1,
                              builder: (context, _) {
                                return Align(
                                  alignment: Alignment.center.add(
                                    Alignment(
                                      0,
                                      Curves.bounceIn.transform(
                                            _controller1.value,
                                          ) *
                                          5,
                                    ),
                                  ),
                                  child: NeonchikAnswer(
                                    onPressed: () {
                                      onPressedAnswer(answer1);
                                    },
                                    answer: answer1,
                                    width: constraints.maxWidth * 0.3,
                                  ),
                                );
                              },
                            ),
                            IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: LottieAnimation(
                                  width: constraints.maxWidth * 0.6,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: bgDecoration,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _controller2,
                              builder: (context, _) {
                                return Align(
                                  alignment: Alignment.center
                                      .add(const Alignment(0, -0.1)),
                                  child: Opacity(
                                    opacity: Curves.easeInOutCirc
                                        .transform(_controller2.value),
                                    child: NeonchikAnswer(
                                      answer: answer2,
                                      onPressed: () {
                                        onPressedAnswer(answer2);
                                      },
                                      width: constraints.maxWidth * 0.3,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomCenter
                                    .add(const Alignment(0, -0.8)),
                                child: LottieAnimation(
                                  width: constraints.maxWidth * 0.6,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: bgDecoration,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _controller3,
                              builder: (context, _) {
                                return Align(
                                  alignment: Alignment.center.add(
                                    Alignment(
                                      0,
                                      Curves.easeIn.transform(
                                            _controller3.value,
                                          ) -
                                          0.1 * 5,
                                    ),
                                  ),
                                  child: Transform.scale(
                                    scale: 1 - _controller3.value,
                                    child: NeonchikAnswer(
                                      answer: answer3,
                                      onPressed: () {
                                        onPressedAnswer(answer3);
                                      },
                                      width: constraints.maxWidth * 0.5,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomCenter
                                    .add(const Alignment(0, -0.8)),
                                child: const LottieAnimation(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: bgDecoration,
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _controller4,
                              builder: (context, _) {
                                return Align(
                                  alignment: Alignment.center.add(
                                    Alignment(
                                      0,
                                      Curves.easeIn.transform(
                                            _controller4.value,
                                          ) *
                                          5,
                                    ),
                                  ),
                                  child: Transform.rotate(
                                    angle: _controller4.value * 2 * pi,
                                    child: NeonchikAnswer(
                                      onPressed: () {
                                        onPressedAnswer(answer4);
                                      },
                                      answer: answer4,
                                      width: constraints.maxWidth * 0.5,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: LottieAnimation(),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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

class NeonchikAnswer extends StatelessWidget {
  const NeonchikAnswer({
    required this.answer,
    required this.width,
    required this.onPressed,
    super.key,
  });

  final String answer;

  final double width;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            answer,
            style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
          SvgPicture.asset(
            'assets/svg/neonchik.svg',
            width: width,
          ),
        ],
      ),
    );
  }
}
