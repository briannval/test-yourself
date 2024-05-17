import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsComparison extends StatelessWidget {
  const QuestionsComparison({
    super.key,
    required this.correctAnswer,
    required this.userAnswer,
    required this.question,
  });

  final String correctAnswer;
  final String userAnswer;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            userAnswer,
            style: const TextStyle(color: Color.fromARGB(255, 202, 171, 252)),
          ),
          Text(
            correctAnswer,
            style: const TextStyle(color: Color.fromARGB(255, 181, 254, 246)),
          ),
        ],
      ),
    );
  }
}
