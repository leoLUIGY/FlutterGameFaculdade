import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main()
{
  runApp(GameWidget());
}
Paint _white = Paint()..color= Color(0xFFFFFFFF);
class GameObject{
  Rect position;
  void render (Canvas canvas)
  {
    canvas.drawRect(position, _white);
  }
}

class GameWidget extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    final game = SpaceShooterGame();
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details)
          {
            game.onPlayerMove(details.delta);
          },
        child: Container(
          color: Color(0xFF0000000),
          child:game.widget
        ),
    );
  }
}

class SpaceShooterGame extends Game{
  GameObject player;
  SpaceShooterGame()
  {
    player = GameObject()..position = Rect.fromLTWH(100, 100, 50, 50);
  }

  void onPlayerMove(Offset delta)
  {
    player.position = player.position.translate(delta.dx, delta.dy);
  }
  void update(double dt)
  {

  }

  void render(Canvas canvas)
  {
  player.render(canvas);
  }
}