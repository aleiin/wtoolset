import 'package:flutter/material.dart';
import 'package:wtoolset/draw/study/p20/01/particle.dart';
import 'package:wtoolset/draw/study/p20/01/res.dart';

class ClockManage with ChangeNotifier {
  /// 粒子列表
  List<Particle>? particles;

  /// 最大粒子数
  int numParticles;

  /// 尺寸
  Size size;

  /// 时间
  late DateTime dateTime;

  ClockManage({
    this.numParticles = 500,
    this.size = Size.zero,
  }) {
    // particles = <Particle>[];
    particles = List.generate(500, (_) => Particle(), growable: true);
    dateTime = DateTime.now();
  }

  collectParticles() {
    collectDigit(target: 1, index: 0);
    collectDigit(target: 9, index: 1);
    collectDigit(target: 9, index: 2);
    collectDigit(target: 4, index: 3);
  }

  void renderDigit({int target = 0, int index = 0}) {
    if (target > 10) {
      return;
    }
    double offSetX = 0;
    double space = _radius;

    // offSetX = ()
  }

  int count = 0;

  final double _radius = 6;

  void collectDigit({
    int target = 0,
    int index = 0,
  }) {
    if (target > 10) {
      return;
    }

    double offSetX = 0;
    double space = _radius;

    offSetX =
        (digits[target][0].length * 2 * (_radius + 1) + space * 2) * index;

    for (int i = 0; i < digits[target].length; i++) {
      for (int j = 0; j < digits[target][j].length; j++) {
        if (digits[target][i][j] == 1) {
          /// 第(i, j)个点圆心横坐标
          double rX = j * 2 * (_radius + 1) + (_radius + 1);

          /// 第(i, j)个圆心纵坐标
          double rY = i * 2 * (_radius + 1) + (_radius + 1);

          particles![count] = Particle(
            x: rX + offSetX,
            y: rY,
            size: _radius,
            color: Colors.blue,
          );
          count++;
        }
      }
    }
  }

  void tick(DateTime dateTime) {
    collectParticles();
    notifyListeners();
  }
}
