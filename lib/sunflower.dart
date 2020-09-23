import 'package:beadsOnDisplay/sunflowerPainter.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

final TargetPlatform platform = TargetPlatform.linux;
final Color primaryColor = Colors.red[300];

class Sunflower extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  CustomAnimationControl control =
      CustomAnimationControl.PLAY; // <-- state variable

  double seeds = 100.0;

  int get seedCount => seeds.floor();
  double duration = 1;
  void toggleDirection() {
    setState(() {
      // toggle between control instructions
      control = (control == CustomAnimationControl.PLAY)
          ? CustomAnimationControl.PLAY_REVERSE
          : CustomAnimationControl.PLAY;
    });
  }

  void _setDuration(double newValue) {
    duration = newValue;
    print(duration);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        platform: platform,
        brightness: Brightness.dark,
        sliderTheme: SliderThemeData.fromPrimaryColors(
          primaryColor: primaryColor,
          primaryColorLight: primaryColor,
          primaryColorDark: Colors.black,
          valueIndicatorTextStyle: DefaultTextStyle.fallback().style,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey[400],
          title: Text(
            "Beads Animation",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 24),
          ),
          elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            ),
          ),
        ),
        backgroundColor: Colors.cyan[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: CustomAnimation<double>(
                control: control, // <-- bind state variable to parameter
                tween: (0.0).tweenTo(360.0),
                startPosition: 0,
                duration: duration.seconds,
                delay: (duration * 0.3).seconds,
                builder: (context, child, value) {
                  return Transform.rotate(
                    // <-- animation that moves childs from left to right
                    angle: value,
                    child: child,
                  );
                },
                animationStatusListener: (AnimationStatus status) {
                  if (status == AnimationStatus.completed) {
                    print("Animation completed!");
                  }
                },
                child: GestureDetector(
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(600),
                    ),
                    onTap: () {
                      toggleDirection();
                    },
                    radius: 1,
                    splashColor: Colors.orange[200],
                    child: Container(
                      width: 551,
                      height: 551,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CustomPaint(
                        painter: SunflowerPainter(seedCount),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 600),
              child: RowSuper(
                fill: true,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 400),
                    child: Slider.adaptive(
                      inactiveColor: Colors.cyanAccent[400],
                      activeColor: Colors.redAccent[100],
                      min: 1,
                      max: 3000,
                      value: seeds,
                      onChanged: (newValue) {
                        setState(() {
                          seeds = newValue;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(width: 10, color: Colors.transparent),
                      color: Colors.cyan[300],
                    ),
                    child: Center(
                      child: Text(
                        "Showing $seedCount seeds",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 600),
              child: RowSuper(
                fill: true,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 400),
                    child: Slider.adaptive(
                      inactiveColor: Colors.cyanAccent[400],
                      activeColor: Colors.deepOrangeAccent[200],
                      min: 0,
                      max: 3,
                      divisions: 10,
                      value: duration.toDouble(),
                      onChanged: (newValue) {
                        setState(() {
                          _setDuration(newValue);
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(width: 10, color: Colors.transparent),
                      color: Colors.cyan[300],
                    ),
                    child: Center(
                      child: Text(
                        "Animation Speed : " +
                            duration.toStringAsFixed(2) +
                            " Seconds",
                        style: GoogleFonts.nunitoSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
