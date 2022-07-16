import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final ScoreState state = ScoreState();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Empty(),
    );
  }
}

class ScoreState extends BaseState {}
