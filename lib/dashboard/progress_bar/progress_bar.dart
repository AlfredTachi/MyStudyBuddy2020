import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double compltetedPercentage;
  double circleWidth;

  ProgressPainter(
      {this.defaultCircleColor,
      this.percentageCompletedCircleColor,
      this.compltetedPercentage,
      this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi * (compltetedPercentage / maxCreditPoints);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2.1,
        arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

int creditPoints;
int maxCreditPoints;

class ProgressBar extends StatefulWidget {
  final int progressAnimationDuration;

  ProgressBar(
    int cpIn,
    int maxCpIn, {
    this.progressAnimationDuration = 1000,
    Key key,
  }) {
    creditPoints = cpIn;
    maxCreditPoints = maxCpIn;
  }

  @override
  State<StatefulWidget> createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController _progressAnimationController;

  @override
  initState() {
    super.initState();
    initAnimationsController();
  }

  initAnimationsController() {
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.progressAnimationDuration),
    )..addListener(
        () {
          setState(() {
            creditPoints = lerpDouble(creditPoints, maxCreditPoints,
                    _progressAnimationController.value)
                .round();
          });
        },
      );
  }

  publishProgress() {
    setState(() {
      creditPoints += 6;
      if (creditPoints >= maxCreditPoints) {
        creditPoints = maxCreditPoints;
      }
      _progressAnimationController.forward(from: 0.0);
    });
  }

  getProgressText() {
    return FittedBox(
      fit: BoxFit.cover,
      child: Text(
        creditPoints.toString() + "/" + maxCreditPoints.toString() + " CP",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
      ),
    );
  }

  progressView() {
    return CustomPaint(
      child: Center(
        child: getProgressText(),
      ),
      foregroundPainter: ProgressPainter(
        defaultCircleColor: Colors.grey,
        percentageCompletedCircleColor: Colors.orange,
        compltetedPercentage: double.tryParse(creditPoints.toString()),
        circleWidth: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(margin: EdgeInsets.all(10), child: progressView()),
    );
  }
}
