import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/p18/01/particle_manage.dart';
import 'package:wtoolset/draw/study/p18/01/particle.dart';
import 'package:wtoolset/draw/study/p18/01/world_render.dart';

import 'dart:math';

class World extends StatefulWidget {
  const World({Key? key}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ParticleManage pm = ParticleManage();
  Random random = Random();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // initParticleManage();

    pm.size = Size(300, 200);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (pm.particles.length > 20) {
        timer.cancel();
      }
      pm.addParticle(
        Particle(
          color: randomRGB(),
          size: 5 + 4 * random.nextDouble(),
          vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
          vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
          ay: 0.1,
          x: 150,
          y: 100,
        ),
      );
    });

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(pm.tick);
  }

  // /// 初始化粒子管理器
  // void initParticleManage() {
  //   pm.size = Size(300, 200);
  //   Particle particle = Particle(
  //     x: 0,
  //     y: 0,
  //     vx: 3,
  //     vy: 0,
  //     ay: 0.05,
  //     color: Colors.blue,
  //     size: 8,
  //   );
  //   pm.particles = [particle];
  // }

  void initParticleManage() {
    pm.size = Size(300, 200);
    for (var i = 0; i < 30; i++) {
      pm.particles.add(Particle(
        color: randomRGB(),
        size: 5 + 4 * random.nextDouble(),
        vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
        ay: 0.1,
        // ax: 0.05,
        x: 150,
        y: 150,
      ));
    }
  }

  Color randomRGB({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    /// 红值
    var r = limitR + random.nextInt(256 - limitR);

    /// 绿值
    var g = limitG + random.nextInt(256 - limitG);

    /// 蓝值
    var b = limitB + random.nextInt(256 - limitB);

    return Color.fromARGB(255, r, g, b);
  }

  void theWorld() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    } else {
      _animationController.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
