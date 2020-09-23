import 'package:beadsOnDisplay/sunflowerPainter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TargetPlatform platform = TargetPlatform.linux;
final Color primaryColor = Colors.red[300];

class Sunflower extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SunflowerState();
  }
}

class _SunflowerState extends State<Sunflower> {
  double seeds = 100.0;

  int get seedCount => seeds.floor();

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
        backgroundColor: Colors.cyan[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: SizedBox(
                width: 551,
                height: 551,
                child: CustomPaint(
                  painter: SunflowerPainter(seedCount),
                ),
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
            SizedBox(
              height: 25,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 300),
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
          ],
        ),
      ),
    );
  }
}
