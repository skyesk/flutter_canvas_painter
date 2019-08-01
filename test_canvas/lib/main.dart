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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () {
            print(Provider.of<PointsProvider>(context).points);
          },
          onPanUpdate: (details){
            print(
              details.globalPosition.dx.toString() + "    " + details.globalPosition.dy.toString(),
            );
            Provider.of<PointsProvider>(context).addPoint(
              Offset(
                details.globalPosition.dx,
                details.globalPosition.dy,
              ),
            );
          },
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MainPainter extends CustomPainter {
  final Paint _paint;
  //final List<Offset> _points;
  final BuildContext context;

  MainPainter(this._paint, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoints(
      PointMode.points,
      Provider.of<PointsProvider>(context).points,
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyHomePage extends StatelessWidget {
  final Paint _paint = new Paint()
    ..color = Colors.blueAccent
    ..strokeWidth = 10.0
    ..isAntiAlias = false
    ..filterQuality = FilterQuality.none
    ..strokeCap = StrokeCap.round;


  MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomPaint(
          painter: MainPainter(_paint,context),
        ),
      ),
    );
  }
}
