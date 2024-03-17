import 'package:flutter/material.dart';
import 'package:meyn_lbh_simulation/domain/area/drawer_conveyor.dart';
import 'package:meyn_lbh_simulation/domain/area/module.dart';
import 'package:meyn_lbh_simulation/gui/area/area.dart';
import 'package:meyn_lbh_simulation/gui/style.dart';

class GrandeDrawerWidget extends StatelessWidget {
  final MachineLayout layout;
  final GrandeDrawer drawer;

  GrandeDrawerWidget(this.layout, this.drawer) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    var style = LiveBirdsHandlingStyle.of(context);
    return RotationTransition(
      turns: AlwaysStoppedAnimation(drawer.position.rotationInFraction(layout)),
      child: drawer.position is DrawerPositionAndSize
          ? Transform.scale(
              scale: (drawer.position as DrawerPositionAndSize).scale(),
              child: CustomPaint(painter: DrawerPainter(drawer, style)))
          : CustomPaint(painter: DrawerPainter(drawer, style)),
    );
  }
}

class DrawerPainter extends CustomPainter {
  final GrandeDrawer drawer;
  final LiveBirdsHandlingStyle style;
  DrawerPainter(this.drawer, this.style);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = _color();
    paint.style = PaintingStyle.stroke;

    // var path = Path();
    // //rectangle starting bottom left
    // var left = offset.dx;
    // var middle = (size.width * factor) / 2 + offset.dx;
    // var right = size.width * factor + offset.dx;
    // var top = offset.dy;
    // var bottom = size.height * factor + offset.dy;

    // // paint square
    // path.moveTo(left, bottom);
    // path.lineTo(left, top);
    // path.lineTo(right, top);
    // path.lineTo(right, bottom);
    // path.lineTo(left, bottom);

    // if (paintTriangle) {
    //   //paint triangle pointing north
    //   path.lineTo(middle, top);
    //   path.lineTo(right, bottom);
    // }
    // canvas.drawPath(path, paint);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Color _color() {
    switch (drawer.contents) {
      case BirdContents.noBirds:
        return style.withoutBirdsColor;
      case BirdContents.stunnedBirds:
        return style.withStunnedBirdsColor;
      case BirdContents.birdsBeingStunned:
        return style.withBirdsBeingStunnedColor;
      case BirdContents.awakeBirds:
        return style.withAwakeBirdsColor;
    }
  }
}
