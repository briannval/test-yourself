import 'package:flutter/material.dart';
import 'package:adv_basics/screens/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: Quiz(),
    ),
  );
}
