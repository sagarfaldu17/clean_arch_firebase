import 'package:flutter/material.dart';

class SuccessWidgetTwo extends StatefulWidget {
  const SuccessWidgetTwo({Key? key}) : super(key: key);

  @override
  State<SuccessWidgetTwo> createState() => _SuccessWidgetTwoState();
}

class _SuccessWidgetTwoState extends State<SuccessWidgetTwo>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController fadeController;

  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    scaleAnimation = Tween(begin: 0.2, end: 5.0).animate(controller);
    slideAnimation = Tween(begin: const Offset(0, 5), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    rotationAnimation = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(fadeController);

    controller.forward().whenComplete(() {
      fadeController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: RotationTransition(
            turns: rotationAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset("assets/done.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    fadeController.dispose();
    controller.dispose();
    super.dispose();
  }
}
