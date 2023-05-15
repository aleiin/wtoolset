import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/p18/01/particle.dart';

class ParticleManage with ChangeNotifier {
  /// 粒子集合
  List<Particle> particles = [];

  /// 粒子大小
  Size size;

  ParticleManage({this.size = Size.zero});

  /// 添加粒子进集合
  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    particles.forEach(doUpdate);
    notifyListeners();
  }

  void doUpdate(Particle p) {
    /// y加速度变化
    p.vy += p.ay;

    /// x加速度变化
    p.vx += p.ax;

    /// x位移
    p.x += p.vx;

    /// y位移
    p.y += p.vy;
    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }

    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }

    if (p.y > size.height) {
      p.y = size.height;
      p.vy = -p.vy;
    }

    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }
}
