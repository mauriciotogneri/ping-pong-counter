import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:pingpongcounter/score_state.dart';

class ScoreScreen extends StatelessWidget {
  final ScoreState state = ScoreState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateProvider<ScoreState>(
          state: state, builder: (context, state) => Content(state)),
    );
  }
}

class Content extends StatelessWidget {
  final ScoreState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlayerScores(state),
        Menu(state),
      ],
    );
  }
}

class Menu extends StatelessWidget {
  final ScoreState state;

  const Menu(this.state);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuButton(
              icon: Icons.restart_alt,
              onPressed: state.onRestart,
              size: constraints.maxHeight / 6,
            ),
            ButtonDivider(constraints.maxHeight / 6),
            MenuButton(
              icon: Icons.swap_horiz,
              onPressed: state.onSwapPlayers,
              size: constraints.maxHeight / 6,
            ),
            ButtonDivider(constraints.maxHeight / 6),
            MenuButton(
              icon:
                  state.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              onPressed: state.onFullscreen,
              size: constraints.maxHeight / 6,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonDivider extends StatelessWidget {
  final double size;

  const ButtonDivider(this.size);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1,
      height: size,
      child: const VerticalDivider(
        color: Colors.white,
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const MenuButton({
    required this.icon,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            icon,
            size: size / 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PlayerScores extends StatelessWidget {
  final ScoreState state;

  const PlayerScores(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              GameScore(
                value: state.sets[playerId],
                alignment:
                    (playerId == 0) ? Alignment.topLeft : Alignment.topRight,
                size: constraints.maxWidth / 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameScore extends StatelessWidget {
  final int value;
  final Alignment alignment;
  final double size;

  const GameScore({
    required this.value,
    required this.alignment,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.all(size / 5),
        padding: EdgeInsets.fromLTRB(size / 5, size / 10, size / 5, size / 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          '$value',
          style: TextStyle(
            fontSize: size,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
