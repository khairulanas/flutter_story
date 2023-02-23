import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingAnimationWidget extends StatefulWidget {
  const LoadingAnimationWidget({super.key});

  @override
  State<LoadingAnimationWidget> createState() => _LoadingAnimationWidgetState();
}

class _LoadingAnimationWidgetState extends State<LoadingAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController loaderController;
  late Animation<double> loaderAnimation;

  @override
  void initState() {
    loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    loaderAnimation = Tween(begin: 1.0, end: 1.4).animate(CurvedAnimation(
      parent: loaderController,
      curve: Curves.easeIn,
    ));
    loaderController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: loaderController,
          builder: (context, child) {
            return Transform.rotate(
              angle: loaderController.status == AnimationStatus.forward
                  ? (math.pi * 2) * loaderController.value
                  : -(math.pi * 2) * loaderController.value,
              child: CustomPaint(
                foregroundPainter: LoaderAnimation(
                  radiusRatio: loaderAnimation.value,
                ),
                size: const Size(300, 300),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoaderAnimation extends CustomPainter {
  final double radiusRatio;

  LoaderAnimation({
    required this.radiusRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, size.width / 4, circle);

    Paint arc = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    Rect rect = Rect.fromCenter(
        center: center,
        width: size.width / 2 * radiusRatio,
        height: size.height / 2 * radiusRatio);

    canvas.drawArc(
      rect,
      math.pi / 4,
      math.pi / 2,
      false,
      arc,
    );
    canvas.drawArc(
      rect,
      -math.pi / 4,
      -math.pi / 2,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant LoaderAnimation oldDelegate) {
    return radiusRatio != oldDelegate.radiusRatio;
  }
}
