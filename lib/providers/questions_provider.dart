import 'dart:convert';

import 'package:adv_basics/ai/gemini.dart';
import 'package:adv_basics/models/quiz_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class QuestionsNotifier extends StateNotifier<List<QuizQuestion>> {
  QuestionsNotifier() : super([]);

  List<String> parseOptions(List<dynamic> answerOptions) {
    List<String> res = [];
    for (int i = 0; i < answerOptions.length; i++) {
      res.add(answerOptions[i] as String);
    }
    return res;
  }

  void parseQuestions(List<dynamic> serializedResponseQuestions) {
    for (int i = 0; i < serializedResponseQuestions.length; i++) {
      print(serializedResponseQuestions[i]);
      state = [
        ...state,
        QuizQuestion(
          serializedResponseQuestions[i]["question"] as String,
          parseOptions(serializedResponseQuestions[i]["answers"]),
          serializedResponseQuestions[i]["correctAnswer"] as String,
        ),
      ];
    }
  }

  Future<bool> initQuestions(int numQuestions, String topic) async {
    final content = [
      Content.text(
          "Give me ${numQuestions.toString()} multiple choice questions (4 choices) regarding the $topic topic in one json object format decodable by json.decode in dart convert, each of the six elements of the array should have three keys: question, answers, and correctAnswer. In which question is a String, answers is a list of String (just the choices without A, B, C, or D), and correctAnswer is a string (one of the choices).")
    ];
    GenerateContentResponse response =
        await geminiAiModel.generateContent(content);
    Map<String, dynamic> serializedResponse = json.decode(
      response.text!.replaceAll('```', '').replaceAll('json', ''),
    ) as Map<String, dynamic>;
    List<dynamic> serializedResponseQuestions =
        serializedResponse["questions"] as List<dynamic>;
    parseQuestions(serializedResponseQuestions);
    return true;
  }

  void resetQuestions() {
    state = [];
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsNotifier, List<QuizQuestion>>(
  (ref) => QuestionsNotifier(),
);
