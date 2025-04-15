import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class NeonchikQuizHeader extends StatelessWidget {
  const NeonchikQuizHeader({
    required this.title,
    required this.answers,
    this.timeToShowAnswer = const Duration(seconds: 3),
    super.key,
  });

  final String title;

  final List<QuizDTOAnswer> answers;

  final Duration timeToShowAnswer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DecoratedBox(
      decoration: bgDecoration,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.viewPaddingOf(context).top,
          16,
          16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )
                .animate()
                .fadeIn(
                  duration: 600.ms,
                  delay: 300.ms,
                )
                .moveY(
                  begin: size.height / 2,
                  end: 0,
                  duration: 300.ms,
                  delay: timeToShowAnswer,
                ),
            SizedBox(
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 3,
                children: answers.mapIndexed(
                  (i, e) {
                    return Text(
                      '${e.code}. ${e.title}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                        .animate()
                        .then(
                          delay:
                              timeToShowAnswer.inMilliseconds.ms + (i * 300).ms,
                        )
                        .fadeIn(duration: 500.ms)
                        .moveY(begin: 30, end: 0, duration: 500.ms);
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
