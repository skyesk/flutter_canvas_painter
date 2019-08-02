import 'package:flutter/material.dart';
import './my_canvas.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homePageScaffold(context);
  }

  Widget homePageScaffold(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("床前明月光，", style: TextStyle(fontSize: 40.0)),
            Text("疑是地上霜。", style: TextStyle(fontSize: 40.0)),
            Text("举头望明月，", style: TextStyle(fontSize: 40.0)),
            Text("低头思故乡。", style: TextStyle(fontSize: 40.0)),
            MaterialButton(
              onPressed: () {
                print("展示画板");
                showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new CanvasDialog();
                  },
                );
              },
              child: Text(
                "展示画板",
                style: TextStyle(color: Colors.red, fontSize: 60.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
