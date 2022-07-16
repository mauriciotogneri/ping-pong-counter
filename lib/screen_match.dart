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
        onTap: () => state.onSingleTap(context, playerId),
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
                  padding: const EdgeInsets.all(10),
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
  int? starter;
  List<int> points = [0, 0];
  List<int> sets = [0, 0];

  void onSingleTap(BuildContext context, int playerId) {
    if (server != null) {
      points[playerId]++;

      final int? winner = getWinner();

      if (winner != null) {
        server = null;
        starter = null;
        points[0] = 0;
        points[1] = 0;
        sets[playerId]++;

        if (winner == 0) {
          _showMessage(context, 'Blue wins!');
        } else if (winner == 1) {
          _showMessage(context, 'Red wins!');
        }
      } else {
        _calculateServer();
      }

      notify();
    } else {
      _showMessage(context, 'Server not defined');
    }
  }

  void onLongTap(int playerId) {
    if (starter == null) {
      starter = playerId;
    } else {
      points[playerId]--;
    }

    _calculateServer();
    notify();
  }

  void _calculateServer() {
    final int totalPoints = points[0] + points[1];

    if (totalPoints < 20) {
      server = (totalPoints ~/ 2) % 2;
    } else {
      server = totalPoints % 2;
    }

    server = (server! + starter!) % 2;
  }

  void _showMessage(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

  int? getWinner() {
    if ((points[0] == 11) && (points[1] < 10)) {
      return 0;
    } else if ((points[1] == 11) && (points[0] < 10)) {
      return 1;
    } else if ((points[0] >= 10) && (points[1] >= 10)) {
      if ((points[0] - points[1]) > 1) {
        return 0;
      } else if ((points[1] - points[0]) > 1) {
        return 1;
      }
    }

    return null;
  }
}
