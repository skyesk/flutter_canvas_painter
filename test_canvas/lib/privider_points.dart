import 'package:flutter/widgets.dart';

class PointsProvider with ChangeNotifier {
  List<Offset> points = new List();

  PointsProvider();

  void addPoint(Offset point){
    points.add(point);
    notifyListeners();
  }

  void clearPoints(){
    points.clear();
    notifyListeners();
  }
}
