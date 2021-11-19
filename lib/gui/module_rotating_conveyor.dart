import 'package:flutter/material.dart';
import 'package:meyn_lbh_simulation/domain/module_rotating_conveyor.dart';

class ModuleRotatingConveyorWidget extends StatelessWidget {
  final ModuleRotatingConveyor rotatingConveyor;

  ModuleRotatingConveyorWidget(this.rotatingConveyor);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: rotatingConveyor.toString(),
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(
            rotatingConveyor.currentDirection.degrees / 360),
        child: CustomPaint(painter: ModuleRotatingConveyorPainter()),
      ),
    );
  }
}

class ModuleRotatingConveyorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawRectangle(canvas, size);
    drawDirectionTriangle(size, canvas);
    drawCircle(canvas, size);
  }

  void drawDirectionTriangle(Size size, Canvas canvas) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width * 0.45, size.height * 0.45);
    path.lineTo(size.width * 0.55, size.height * 0.45);
    path.lineTo(size.width * 0.50, size.height * 0.4);
    path.close();
    canvas.drawPath(path, paint);
  }

  Paint drawRectangle(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width * 0.4,
            height: size.width * 0.8),
        paint);
    return paint;
  }

  Paint drawCircle(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.height * 0.45,
      paint,
    );
    return paint;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
