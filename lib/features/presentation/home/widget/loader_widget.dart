import 'dart:math';

import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationRadiusIn;
  late Animation<double> animationRadiusOut;
  final double initialRadius = 40;
  double radius = 0;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2400));
    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );
    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOut),
      ),
    );
    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));
    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animationRadiusOut.value * initialRadius;
        }
      });
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: RotationTransition(
          turns: animationRotation,
          child: Stack(
            children: [
              _DotWidget(radius: 15, color: Colors.blue.shade800),
              Transform.translate(
                offset:
                    Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.orangeAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.yellow),
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                child:
                    const _DotWidget(radius: 8, color: Colors.lightGreenAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.greenAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.blueAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.purpleAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.pinkAccent),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                child: const _DotWidget(radius: 8, color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _DotWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const _DotWidget({Key? key, required this.radius, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
