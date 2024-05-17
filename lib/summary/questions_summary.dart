import 'package:adv_basics/summary/questions_comparison.dart';
import 'package:adv_basics/summary/questions_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QuestionsIdentifier(
                  questionIndex: ((data['question_index'] as int) + 1),
                  isCorrectAnswer:
                      data['user_answer'] == data['correct_answer'],
                ),
                const SizedBox(
                  width: 15,
                ),
                QuestionsComparison(
                    correctAnswer: data['correct_answer'] as String,
                    userAnswer: data['user_answer'] as String,
                    question: data['question'] as String)
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
