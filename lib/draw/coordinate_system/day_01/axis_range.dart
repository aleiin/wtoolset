class AxisRange {
  final double maxX;
  final double minX;
  final double maxY;
  final double minY;

  const AxisRange({
    this.maxX = 1.0,
    this.minX = -1.0,
    this.maxY = 1.0,
    this.minY = -1.0,
  });

  /// 宽度
  double get xSpan => maxX - minX;

  /// 高度
  double get ySpan => maxY - minY;
}
