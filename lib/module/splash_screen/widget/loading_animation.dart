// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:scale_realtime/util/custom_const.dart';
import 'package:flutter/material.dart';

class DotLoadingAnimation extends StatefulWidget {
  const DotLoadingAnimation({Key? key}) : super(key: key);

  @override
  State<DotLoadingAnimation> createState() => _DotLoadingAnimationState();
}

class _DotLoadingAnimationState extends State<DotLoadingAnimation> {
  int dotCount = 4;
  int currentDot = 0;

  late List<Widget> dots;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    dots = List.generate(dotCount, (index) {
      return AnimatedDot(
        isActive: index == currentDot,
      );
    });

    timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (mounted) {
        setState(() {
          currentDot = (currentDot + 1) % dotCount;
          for (int i = 0; i < dotCount; i++) {
            dots[i] = AnimatedDot(
              isActive: i == currentDot,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: dots,
    );
  }
}

class AnimatedDot extends StatelessWidget {
  final bool isActive;

  const AnimatedDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isActive ? secondaryColor : Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
