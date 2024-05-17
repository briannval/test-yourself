import 'package:adv_basics/widgets/answer_button.dart';
import 'package:adv_basics/models/quiz_question.dart';
import 'package:adv_basics/providers/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// _ in front of a class means it's private
class QuestionsScreen extends ConsumerStatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.onSelectAnswer,
    required this.currentQuestionIndex,
  });

  final void Function(String answer) onSelectAnswer;
  final int currentQuestionIndex;

  @override
  ConsumerState<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    // widget is built in into the State class
    // gives access to the widget class and its properties
  }

  @override
  Widget build(BuildContext context) {
    QuizQuestion currentQuestion =
        ref.read(questionsProvider)[widget.currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion!.question,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentQuestion!.answers.map((answer) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 30,
                  right: 30,
                ),
                child: AnswerButton(
                    answerText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
