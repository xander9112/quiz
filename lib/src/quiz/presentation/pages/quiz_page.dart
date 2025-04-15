import 'package:flutter/material.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizDTO> questions;
  late PageController _pageController;

  bool loading = true;
  bool isFinish = false;

  Map<String, bool> answers = {};

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _getData();
  }

  Future<void> _getData() async {
    questions = await LocalQuizSource().getQuestions();

    await Future<void>.delayed(const Duration(seconds: 2));

    loading = false;

    setState(() {});
  }

  bool _onSubmit(QuizDTO question, String answer) {
    final bool isCorrect = question.answer == answer;

    if (!answers.containsKey(question.code)) {
      answers.putIfAbsent(question.code, () => isCorrect);
    } else {
      answers[question.code] = isCorrect;
    }

    // if (isCorrect) {
    _nextQuestion();
    // }

    return isCorrect;
  }

  Future<void> _nextQuestion() async {
    await Future<void>.delayed(const Duration(milliseconds: 2500));

    if ((_pageController.page?.toInt() ?? 1) < (questions.length - 1)) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      setState(() {
        isFinish = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (isFinish) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Результат:',
                style: TextStyle(fontSize: 28),
              ),
              Text('${answers.entries.where(
                    (element) => element.value,
                  ).length} / ${answers.entries.length}'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions.elementAt(index);

          return Column(
            children: [
              Expanded(
                child: NeonchikQuiz(
                  title: question.title,
                  answers: question.answers,
                  key: ValueKey(index),
                  onPressed: (value) async {
                    return _onSubmit(question, value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
