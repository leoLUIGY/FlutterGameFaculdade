import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';

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
  static const enemy_speed = 400;
  Timer enemyCreator;
  List<GameObject> enemies = [];

  GameObject player;
  SpaceShooterGame()
  {
    player = GameObject()..position = Rect.fromLTWH(100, 100, 50, 50);
    enemyCreator = Timer(1.0, repeat:true, callback:(){
      enemies.add(
        GameObject()..position = Rect.fromLTWH(0, 0, 50, 50)
      );
    });
    enemyCreator.start();
  }

  void onPlayerMove(Offset delta)
  {
    player.position = player.position.translate(delta.dx, delta.dy);
  }
  void update(double dt)
  {
    enemyCreator.update(dt);
  enemies.forEach((enemy){
    enemy.position = enemy.position.translate(0, enemy_speed * dt);
  });
  }

  void render(Canvas canvas)
  {
  player.render(canvas);
  enemies.forEach((enemy){
    enemy.render(canvas);
  });
  }
}