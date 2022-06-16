import 'package:flutter/material.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({Key? key}) : super(key: key);

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<Offset> slideAnimation;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    slideAnimation =
        Tween(begin: Offset(0, 5), end: Offset(0, 0)).animate(controller.view);
    opacityAnimation = Tween(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: slideAnimation,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: Container(
            height: 100,
            width: 100,
            child: Image.asset("assets/done.png"),
          ),
        ),
      ),
    );
  }
}
