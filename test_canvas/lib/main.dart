import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './privider_points.dart';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => PointsProvider(),
        ),
      ],
      child: MaterialApp(
        title: '画板',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PressPage(),
      ),
    );
  }
}

class PressPage extends StatelessWidget {
  final Paint _paint = new Paint()
    ..color = Colors.blueAccent
    ..strokeWidth = 2.0
    ..isAntiAlias = false
    ..filterQuality = FilterQuality.none
    ..strokeCap = StrokeCap.round;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("画板demo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.cached,
            ),
            onPressed: () {
              Provider.of<PointsProvider>(context).clearPoints();
            },
          )
        ],
      ),
      body: Container(
        child: CustomPaint(
          child: GestureDetector(
            onPanUpdate: (details) {
              print(
                details.globalPosition.dx.toString() + "    " + details.globalPosition.dy.toString(),
              );
              Provider.of<PointsProvider>(context).addPoint(
                Offset(
                  details.globalPosition.dx,
                  details.globalPosition.dy - 90.0, //加了appbar以后要会往下推，所以要补齐
                ),
              );
            },
          ),
          painter: MainCanvas(_paint, context),
        ),
      ),
    );
  }
}

class MainCanvas extends CustomPainter {
  final Paint _paint;
  //final List<Offset> _points;
  final BuildContext context;

  MainCanvas(this._paint, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> points = Provider.of<PointsProvider>(context).points;
    for (var i = 0; i < points.length - 1; i++) {
      Offset firstPoint = points[i];
      Offset secondPoint = points[i + 1];
      double xDeviation = (secondPoint.dx - firstPoint.dx) * -1;
      double yDeviation = (secondPoint.dy - firstPoint.dy) * -1;
      if (xDeviation > 20.0 || yDeviation > 20.0) {
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

class CanvasAndPainter extends StatelessWidget {
  final Paint _paint = new Paint()
    ..color = Colors.blueAccent
    ..strokeWidth = 2.0
    ..isAntiAlias = false
    ..filterQuality = FilterQuality.none
    ..strokeCap = StrokeCap.round;

  CanvasAndPainter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MainCanvas(_paint, context),
      ),
    );
  }
}
