import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SoundVisualizer extends CustomPainter {
  SoundVisualizer({
    @required this.waveData,
    @required this.normalColor,
    @required this.tooLoudVolume,
    @required this.tooSoftVolume,
    @required this.maxValue,
    this.tooLoudColor = Colors.red,
    this.tooSoftColor = Colors.grey,
    this.displayBars = 40,
    this.gap = 2,
  })  : soundPaint = Paint()
          ..color = normalColor.withOpacity(1.0)
          ..style = PaintingStyle.fill,
        assert(waveData != null),
        assert(normalColor != null);

  final List<int> waveData;
  final Color normalColor;
  final Color tooLoudColor;
  final Color tooSoftColor;
  final Paint soundPaint;
  final double tooLoudVolume;
  final double tooSoftVolume;
  final double maxValue;
  final int gap;
  final int displayBars;
  final Paint linePaint = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    assert(size != const Size(0, 0));
    if (waveData != null) {
      final drawArea = Offset(size.width / 1.5, size.height * 0.6);

      final barWidth = drawArea.dx / displayBars;
      soundPaint.strokeWidth = barWidth - gap;

      final barRatio = drawArea.dy / maxValue / 2;
      // データが少ない時の位置調整
      var diff = 0;
      if (waveData.length < displayBars) {
        diff = (drawArea.dx - (drawArea.dx / displayBars * waveData.length))
            .toInt();
      }

      for (var i = 0; i < waveData.length; i++) {
        final barLength = waveData[i].toDouble() * barRatio;
        final barX = diff + (i * barWidth) + (barWidth / 2);
        final centerY = size.height / 2;
        if (waveData[i] > tooLoudVolume) {
          soundPaint.color = tooLoudColor;
        } else if (waveData[i] < tooSoftVolume) {
          soundPaint.color = tooSoftColor;
        } else {
          soundPaint.color = normalColor;
        }

        canvas
          ..drawLine(Offset(0, centerY), Offset(size.width, centerY), linePaint)
          ..drawLine(Offset(barX, centerY + barLength),
              Offset(barX, centerY - barLength), soundPaint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
