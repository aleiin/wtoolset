import 'package:flutter/material.dart';
import 'package:wtoolset/draw/p18/03/particle.dart';

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
    // particles.forEach(doUpdate);
    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
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
      particles.remove(p);
    }

    if (p.x < 0) {
      particles.remove(p);
    }

    if (p.y > size.height) {
      particles.remove(p);
    }

    if (p.y < 0) {
      particles.remove(p);
    }

    // if (p.x > size.width) {
    //   p.x = size.width;
    //   var newSize = p.size / 2;
    //   if (newSize > 1) {
    //     Particle p0 = p.copyWith(size: newSize, vx: -p.vx, vy: -p.vy);
    //     particles.add(p0);
    //     p.size = newSize;
    //     p.vx = -p.vx;
    //   }
    // }
    //
    // if (p.x < 0) {
    //   p.x = 0;
    //   p.vx = -p.vx;
    // }
    //
    // if (p.y > size.height) {
    //   p.y = size.height;
    //   var newSize = p.size / 2;
    //   if (newSize > 1) {
    //     Particle p0 = p.copyWith(
    //       size: newSize,
    //       vx: -p.vx,
    //       vy: -p.vy,
    //     );
    //     particles.add(p0);
    //     p.size = newSize;
    //     p.vy = -p.vy;
    //   }
    // }
    //
    // if (p.y < 0) {
    //   p.y = 0;
    //   p.vy = -p.vy;
    // }

    // if (p.x > size.width) {
    //   p.x = size.width;
    //   p.vx = -p.vx;
    // }
    //
    // if (p.x < 0) {
    //   p.x = 0;
    //   p.vx = -p.vx;
    // }
    //
    // if (p.y > size.height) {
    //   p.y = size.height;
    //   p.vy = -p.vy;
    // }
    //
    // if (p.y < 0) {
    //   p.y = 0;
    //   p.vy = -p.vy;
    // }
  }
}
