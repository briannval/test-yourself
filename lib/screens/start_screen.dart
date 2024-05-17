import 'package:adv_basics/providers/questions_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen(this.startQuiz, {super.key});
  // calling startQuiz INDIRECTLY calls whatever passed into constructor

  final void Function() startQuiz;

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _questionNumberController =
      TextEditingController();

  bool _isButtonEnabled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_setButtonEnabled);
    _questionNumberController.addListener(_setButtonEnabled);
  }

  void _handleButtonPressed() async {
    setState(() {
      _isLoading = true;
    });
    await ref.watch(questionsProvider.notifier).initQuestions(
          int.tryParse(_questionNumberController.text)!,
          _titleController.text,
        );
    setState(() {
      _isLoading = false;
    });
    widget.startQuiz();
  }

  void _setButtonEnabled() {
    if (_questionNumberController.text.isEmpty) {
      return;
    }
    setState(() {
      _isButtonEnabled = _titleController.text.isNotEmpty &&
          int.tryParse(_questionNumberController.text)! > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 250,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 40,
          ),
          Text("Test yourself on any topic!",
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 237, 223, 252),
                fontSize: 24,
              )),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 120,
              right: 120,
            ),
            child: TextField(
              controller: _titleController,
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Topic',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 120,
              right: 120,
            ),
            child: TextField(
              controller: _questionNumberController,
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of questions',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          _isButtonEnabled
              ? _isLoading
                  ? const CircularProgressIndicator()
                  : OutlinedButton.icon(
                      onPressed: _handleButtonPressed,
                      style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 20)),
                      icon: const Icon(Icons.arrow_right_alt),
                      label: const Text("Start Quiz"))
              : Container(),
        ],
      ),
    );
  }
}
