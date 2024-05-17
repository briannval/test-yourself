import 'package:adv_basics/models/quiz_question.dart';
import 'package:adv_basics/providers/questions_provider.dart';
import 'package:adv_basics/summary/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final List<String> chosenAnswers;
  final void Function() onRestart;

  // use like a field but really a method (getter)
  List<Map<String, Object>> getSummaryData(List<QuizQuestion> questions) {
    final List<Map<String, Object>> summaryData = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summaryData.add({
        'question_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].correctAnswer,
        'user_answer': chosenAnswers[i],
      });
    }

    return summaryData;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionsProvider);
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData(questions)
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You answered $numCorrectQuestions out of $numTotalQuestions questions correctly.",
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(
              getSummaryData(questions),
            ),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton(
              onPressed: () {
                onRestart();
              },
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              child: const Text("Restart Quiz!"),
            ),
          ],
        ),
      ),
    );
  }
}
