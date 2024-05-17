import 'package:adv_basics/models/quiz_question.dart';
import 'package:adv_basics/providers/questions_provider.dart';
import 'package:adv_basics/screens/questions_screen.dart';
import 'package:adv_basics/screens/results_screen.dart';
import "package:flutter/material.dart";
import 'package:adv_basics/screens/start_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
Three very important (stateful) widget lifecycle:
1. initState() -> when state object is initialized
2. build() -> when Widget built first time and setState() is called
3. dispose() -> right before Widget will be deleted
*/

class Quiz extends ConsumerStatefulWidget {
  const Quiz({super.key});

  @override
  ConsumerState<Quiz> createState() {
    return _QuizState();
  }
}

// _ in front of a class means it's private
// fields don't have to be private because class itself is
class _QuizState extends ConsumerState<Quiz> {
  List<String> selectedAnswers = [];
  Widget? activeScreen;
  List<QuizQuestion>? questions;
  int currentIndex = 0;
  // don't use var for more general superclass
  // use ? for null case

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen);
    // do initState because
    // switchScreen is created and passed in
    // SIMULTANEOUSLY
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(
        currentQuestionIndex: currentIndex,
        onSelectAnswer: chooseAnswer,
      );
      // ALWAYS do setState when wanting a re-render
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    currentIndex++;
    if (currentIndex >= questions!.length) {
      setState(() {
        activeScreen = ResultsScreen(
          chosenAnswers: selectedAnswers,
          onRestart: restartQuiz,
        );
      });
    } else {
      switchScreen();
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      ref.watch(questionsProvider.notifier).resetQuestions();
      currentIndex = 0;
      activeScreen = StartScreen(switchScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    questions = ref.watch(questionsProvider);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.deepPurple,
              Colors.indigo,
            ]),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
