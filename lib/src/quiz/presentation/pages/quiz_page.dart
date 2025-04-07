import 'package:flutter/material.dart';
import 'package:quiz/src/quiz/_quiz.dart';
import 'package:reactive_forms_json_scheme/reactive_forms_json_scheme.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late JsonForms jsonForm;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  Future<void> _getData() async {
    final schema = await LocalQuizSource().getJsonSchema();
    final uiSchema = await LocalQuizSource().getUiSchema();

    jsonForm = JsonFormsReactive(schema, uiSchema, {}, [], (data) {});
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
      body: jsonForm.getFormWidget(context),
    );
  }
}
