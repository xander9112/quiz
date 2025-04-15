import 'package:flutter/material.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class NeonchikQuizHeader extends StatelessWidget {
  const NeonchikQuizHeader({
    required this.title,
    required this.answers,
    super.key,
  });

  final String title;

  final List<QuizDTOAnswer> answers;

  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 3,
                children: answers.map(
                  (e) {
                    return Text(
                      '${e.code}. ${e.title}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    );
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
