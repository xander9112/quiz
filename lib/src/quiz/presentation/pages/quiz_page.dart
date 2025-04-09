import 'package:flutter/material.dart';
import 'package:quiz/src/quiz/_quiz.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<QuizDTO> questions;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future<void> _getData() async {
    questions = await LocalQuizSource().getQuestions();

    loading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(),
        body: const CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: PageView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions.elementAt(index);

          return Column(
            children: [
              Text(question.title),
              ...question.answers.map(
                (e) => Text(e.title),
              ),
            ],
          );
        },
      ),
    );
  }
}
