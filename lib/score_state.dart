import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:pingpongcounter/platform/platform_none.dart'
    if (dart.library.html) 'package:pingpongcounter/platform/platform_web.dart';

class ScoreState extends BaseState {
  int? server;
  int? starter;
  List<int> points = [0, 0];
  List<int> sets = [0, 0];
  bool isFullscreen = false;

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

  void onRestart() {
    // TODO(momo): restart (set, match)
  }

  void onSwapPlayers() {
    // TODO(momo): implement
  }

  void onFullscreen() {
    isFullscreen = !isFullscreen;
    PlatformMethods().webFullscreen(isFullscreen);
  }
}
