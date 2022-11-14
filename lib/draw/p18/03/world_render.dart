import 'package:flutter/material.dart';
import 'package:wtoolset/draw/p18/03/particle_manage.dart';
import 'package:wtoolset/draw/p18/03/particle.dart';

class WorldRender extends CustomPainter {
  WorldRender({required this.manage}) : super(repaint: manage);

  final ParticleManage manage;

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, stokePaint);
    manage.particles.forEach((element) {
      drawParticle(canvas, element);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(
      Offset(particle.x, particle.y),
      particle.size,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
}
