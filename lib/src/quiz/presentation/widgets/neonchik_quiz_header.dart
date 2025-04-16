import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class NeonchikQuizHeader extends StatefulWidget {
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
  State<NeonchikQuizHeader> createState() => _NeonchikQuizHeaderState();
}

class _NeonchikQuizHeaderState extends State<NeonchikQuizHeader> {
  final key = GlobalKey();

  double textHeight = 0;

  @override
  void initState() {
    //calling the getHeight Function after the Layout is Rendered
    WidgetsBinding.instance.addPostFrameCallback((_) => getHeight());

    super.initState();
  }

  void getHeight() {
    //returns null:
    final State? state = key.currentState;
    //returns null:
    final BuildContext? context = key.currentContext;

    //Error: The getter 'context' was called on null.
    // final RenderBox? box = state?.context.findRenderObject() as RenderBox?;

    textHeight = context?.size?.height ?? 0;

    setState(() {});
  }

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
              key: key,
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            )
                .animate(delay: 300.ms)
                .fadeIn(
                  duration: 600.ms,
                  delay: 300.ms,
                )
                .moveY(
                  begin: (size.height / 2) - textHeight / 2,
                  end: 0,
                  duration: 300.ms,
                  delay: widget.timeToShowAnswer,
                ),
            SizedBox(
              width: double.infinity,
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 3,
                children: widget.answers.mapIndexed(
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
                          delay: widget.timeToShowAnswer.inMilliseconds.ms +
                              (i * 300).ms,
                        )
                        .fadeIn(duration: 600.ms)
                        .moveY(begin: 30, end: 0, duration: 600.ms);
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
