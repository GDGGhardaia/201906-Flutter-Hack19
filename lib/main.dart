import 'dart:async';
import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:flutter_web/rendering.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web CountDown',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  double Opacity = 1.0;
  var actualColor = Color(0xff135c9c);
  int s, m, h;
  int v;
  TextEditingController controller_HH = new TextEditingController();
  TextEditingController controller_MM = new TextEditingController();
  TextEditingController controller_SS = new TextEditingController();
  String buttonText = "Start";
  var twoDigits = NumberFormat("00", "en_US");
  @override
  void initState() {
    //////////////////////////////////////////////////////////////////
    // Change values here
    s = 00;
    m = 00;
    h = 00;
    //////////////////////////////////////////////////////////////////
    if (s != 00) {
      v = s;
    } else {
      v = 60;
    }
    super.initState();
  }

  statCount() {
    actualColor = Color(0xff135c9c);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        v--;
        if (v < 0) {
          v = 59;
        }
        s--;
        if (s < 0) {
          if (m > 0 || h > 0) {
            s = 59;
            m--;
            if (m < 0) {
              m = 59;
              h--;
            }
          } else {
            t.cancel();
            s = 0;
            v = 60;
            actualColor = Colors.red;
            buttonText = "Start";
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // background image to use
            Image.network(
              "https://pbs.twimg.com/media/DueoLpMX4AEey9r.jpg:large",
              fit: BoxFit.cover,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.7),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Event title
                Text(
                  "FLUTTER HACKATHON 19",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: min(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height) *
                          0.04,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  child: CustomPaint(
                    painter: CirclePainter(
                        color: actualColor,
                        val: v,
                        s: min(MediaQuery.of(context).size.width,
                            MediaQuery.of(context).size.height)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            twoDigits.format(h),
                            style: TextStyle(
                                color: actualColor,
                                fontSize: min(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height) *
                                    0.15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            ":",
                            style: TextStyle(
                                color: actualColor,
                                fontSize: min(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height) *
                                    0.15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            twoDigits.format(m),
                            style: TextStyle(
                                color: actualColor,
                                fontSize: min(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height) *
                                    0.15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            ":",
                            style: TextStyle(
                                color: actualColor,
                                fontSize: min(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height) *
                                    0.15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            twoDigits.format(s),
                            style: TextStyle(
                                color: actualColor,
                                fontSize: min(MediaQuery.of(context).size.width,
                                        MediaQuery.of(context).size.height) *
                                    0.15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 10),
                width: double.infinity,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: new InputDecoration(
                            hintText: "00", labelText: "HH"),
                        keyboardType: TextInputType.number,
                        controller: controller_HH,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: new InputDecoration(
                            hintText: "00", labelText: "MM"),
                        keyboardType: TextInputType.number,
                        controller: controller_MM,
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: TextField(
                        decoration: new InputDecoration(
                            hintText: "00", labelText: "SS"),
                        keyboardType: TextInputType.number,
                        controller: controller_SS,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (buttonText == "Stop") {
                          timer.cancel();
                          setState(() {
                            buttonText = "Start";
                          });
                        } else {
                          setState(() {
                            try {
                              s = controller_SS.text.isNotEmpty
                                  ? int.parse(controller_SS.text)
                                  : 00;
                              m = controller_MM.text.isNotEmpty
                                  ? int.parse(controller_MM.text)
                                  : 00;
                              h = controller_HH.text.isNotEmpty
                                  ? int.parse(controller_HH.text)
                                  : 00;
                              if (s != 00) {
                                v = s;
                              } else {
                                v = 60;
                              }
                              buttonText = "Stop";
                              statCount();
                            } catch (e) {
                              print(e.toString());
                            }
                          });
                        }
                      },
                      child: Text(buttonText),
                      textColor: Colors.white,
                      color: Colors.blue,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

// Circle Widget

class CirclePainter extends CustomPainter {
  var val;
  var color;
  var s;
  CirclePainter({@required this.val, @required this.color, @required this.s});
  var pI = (pi * 2) / 360;
  @override
  void paint(Canvas canvas, Size size) {
    Paint c = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 10;
    Paint grey = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 2;
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: (s / 3)),
        0,
        pi * 2,
        false,
        grey);
    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: (s / 3)),
        0,
        (val * 360 / 60) * pI,
        false,
        c);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
