import 'package:flutter/material.dart';
import 'package:sqflite_example/core/utils/navigator.dart';
import 'package:sqflite_example/features/presentation/add_note/pages/add_note_page.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    const quick = Duration(milliseconds: 150);
    final scaleTween = Tween(begin: 0.8, end: 1.0);
    controller = AnimationController(duration: quick, vsync: this);
    animation = scaleTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
      setState(() => scale = animation.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _animate() {
    animation.addStatusListener((AnimationStatus status) {
      if (scale == 1.0) {
        controller.reverse();
      }
    });
    controller.forward();
  }

  double scale = 0.8;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: IconButton(
        onPressed: () {
          _animate();
          Future.delayed(
            const Duration(milliseconds: 300),
                () => NavigatorUtil.get(
              context,
              const AddNotePage(),
            ),
          );
        },
        icon: const Icon(Icons.add, size: 40.0),
      ),
    );
  }
}
