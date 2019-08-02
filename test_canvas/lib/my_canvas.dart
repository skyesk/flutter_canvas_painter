import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './privider_points.dart';

class CanvasDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: Stack(
        children: <Widget>[
          myCanvas(context),
          Positioned(
            left: 0.0,
            top: 20.0,
            child: MaterialButton(
              child: Icon(
                Icons.chevron_left,
                size: 50.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            right: 0.0,
            top: 20.0,
            child: MaterialButton(
              child: Icon(
                Icons.delete_forever,
                size: 50.0,
                color: Colors.white,
              ),
              onPressed: () {
                Provider.of<PointsProvider>(context).clearPoints();
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget myCanvas(BuildContext context) {
  final Paint _paint = new Paint()
    ..color = Colors.blueAccent
    ..strokeWidth = 2.0
    ..isAntiAlias = false
    ..filterQuality = FilterQuality.none
    ..strokeCap = StrokeCap.round;
  return Container(
    child: CustomPaint(
      child: GestureDetector(
        onPanUpdate: (details) {
          print(
            details.globalPosition.dx.toString() + "    " + details.globalPosition.dy.toString(),
          );
          Provider.of<PointsProvider>(context).addPoint(
            Offset(
              details.globalPosition.dx,
              details.globalPosition.dy - 40, //加了appbar以后要会往下推，所以要补齐
            ),
          );
        },
      ),
      painter: MainCanvas(_paint, context),
    ),
  );
}

class MainCanvas extends CustomPainter {
  final Paint _paint;
  final BuildContext context;

  MainCanvas(this._paint, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = Provider.of<PointsProvider>(context).points;
    for (var i = 0; i < points.length - 2; i++) {
      Offset firstPoint = points[i];
      Offset secondPoint = points[i + 1];
      double xDeviation = (secondPoint.dx - firstPoint.dx) * -1;
      double yDeviation = (secondPoint.dy - firstPoint.dy) * -1;
      if (xDeviation > 40.0 || yDeviation > 40.0) {
        i++;
      }
      canvas.drawLine(points[i], points[i + 1], _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
