import 'package:flutter/material.dart';
import 'dart:math' as math;

final TargetPlatform platform = TargetPlatform.linux;
final Color primaryColor = Colors.red;

class SunflowerPainter extends CustomPainter {
  double seedRadius = 2.2;
  static const scaleFactor = 4;
  static const tau = math.pi * 2;

  static final phi = (math.sqrt(5) + 1) / 2;

  final int seeds;

  SunflowerPainter(this.seeds);

  @override
  void paint(Canvas canvas, Size size) {
    int scale;
    if (seeds < 500) {
      scale = 10;
      seedRadius = 4;
    } else if (seeds < 1000) {
      scale = 8;
      seedRadius = 4;
    } else if (seeds < 1500) {
      scale = 7;
      seedRadius = 4;
    } else if (seeds < 2000) {
      scale = 6;
      seedRadius = 3;
    } else if (seeds < 2500) {
      scale = 5;
      seedRadius = 2.5;
    } else if (seeds <= 3000) {
      scale = 5;
      seedRadius = 2.3;
    }

    var center = size.width / 2;

    for (var i = 0; i < seeds; i++) {
      var theta = i * tau / phi;
      var r = math.sqrt(i) * scale;
      var x = center + r * math.cos(theta);
      var y = center - r * math.sin(theta);
      var offset = Offset(x, y);
      if (!size.contains(offset)) {
        continue;
      }
      drawSeed(canvas, x, y);
    }
  }

  @override
  bool shouldRepaint(SunflowerPainter oldDelegate) {
    return oldDelegate.seeds != this.seeds;
  }

  // Draw a small circle representing a seed centered at (x,y).
  void drawSeed(Canvas canvas, num x, num y) {
    var paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = primaryColor;
    canvas.drawCircle(Offset(x, y), seedRadius, paint);
  }
}
