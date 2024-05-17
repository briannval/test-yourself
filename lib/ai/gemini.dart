import 'package:google_generative_ai/google_generative_ai.dart';

final geminiAiModel = GenerativeModel(
  model: const String.fromEnvironment('aiModel'),
  apiKey: const String.fromEnvironment('apiKey'),
);
