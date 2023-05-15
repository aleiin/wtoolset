import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wtoolset/draw/study/p20/01/clock_manage.dart';
import 'package:wtoolset/draw/study/p20/01/clock_painter.dart';

class ClockPanel extends StatefulWidget {
  const ClockPanel({Key? key}) : super(key: key);

  @override
  _ClockPanelState createState() => _ClockPanelState();
}

class _ClockPanelState extends State<ClockPanel>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late ClockManage pm;

  @override
  void initState() {
    super.initState();
    pm = ClockManage(size: Size(200, 100));
    pm.collectParticles();
    _ticker = createTicker(_tick)..start();
  }

  void _tick(Duration duration) {
    if (DateTime.now().second % 1 == 0) {
      pm.tick(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClockPainter(manage: pm),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
