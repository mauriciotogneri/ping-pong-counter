import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pingpongcounter/platform/platform_none.dart'
    if (dart.library.html) 'package:pingpongcounter/platform/platform_web.dart';

class ScoreState extends BaseState {
  int? server;
  int? starter;
  List<int> points = [0, 0];
  List<int> sets = [0, 0];
  bool isFullscreen = false;
  bool blueFirst = true;

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
          _showMessage('Blue wins!');
        } else if (winner == 1) {
          _showMessage('Red wins!');
        }
      } else {
        _calculateServer();
      }

      notify();
    } else {
      _showMessage('Server not defined. Press and hold to select server');
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

  Alignment getAlignment(int playerId) {
    if (blueFirst) {
      return (playerId == 0) ? Alignment.topLeft : Alignment.topRight;
    } else {
      return (playerId == 0) ? Alignment.topRight : Alignment.topLeft;
    }
  }

  void _showMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        webBgColor: 'linear-gradient(to right, #000000, #000000)',
        textColor: Colors.white,
        webPosition: 'center',
        fontSize: 1,
      );

  void onRestart() {
    // TODO(momo): restart (set, match)
  }

  void onSwapPlayers() {
    if (server == null) {
      blueFirst = !blueFirst;
      notify();
    } else {
      _showMessage('Cannot swap during a game');
    }
  }

  void onFullscreen() {
    isFullscreen = !isFullscreen;
    PlatformMethods().webFullscreen(isFullscreen);
  }

  void onSounds() {
    // TODO(momo): implement
  }
}
