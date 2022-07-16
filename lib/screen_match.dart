import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final ScoreState state = ScoreState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateProvider<ScoreState>(
        state: state,
        builder: (context, state) => Row(
          children: [
            Expanded(
              child: ScoreButton(
                playerId: 0,
                color: Colors.blue,
                state: state,
              ),
            ),
            Expanded(
              child: ScoreButton(
                playerId: 1,
                color: Colors.red,
                state: state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreButton extends StatelessWidget {
  final int playerId;
  final Color color;
  final ScoreState state;

  const ScoreButton({
    required this.color,
    required this.playerId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        onTap: () => state.onSingleTap(playerId),
        onLongPress: () => state.onLongTap(playerId),
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${state.points[playerId]}',
                  style: TextStyle(
                    fontSize: constraints.maxWidth / 2,
                    color: Colors.white,
                    decoration: (state.server == playerId)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
              Align(
                alignment:
                    (playerId == 0) ? Alignment.topLeft : Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    '${state.sets[playerId]}',
                    style: TextStyle(
                      fontSize: constraints.maxWidth / 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreState extends BaseState {
  int? server;
  List<int> points = [0, 0];
  List<int> sets = [0, 0];

  void onSingleTap(int playerId) {
    points[playerId]++;
    _calculateServer();
    notify();
  }

  void onLongTap(int playerId) {
    if (server == null) {
      server = playerId;
    } else {
      points[playerId]--;
    }

    _calculateServer();
    notify();
  }

  void _calculateServer() {}
}
