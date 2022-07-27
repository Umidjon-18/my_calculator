import 'dart:async';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:show_up_animation/show_up_animation.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../utils/routes.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1800),
    vsync: this,
  );
  late final Animation<AlignmentGeometry> _offsetAnimationOne =
      Tween<AlignmentGeometry>(
    begin: const Alignment(-2, 0),
    end: const Alignment(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));
  late final Animation<AlignmentGeometry> _offsetAnimationTwo =
      Tween<AlignmentGeometry>(
    begin: const Alignment(2, 0),
    end: const Alignment(0, 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward();
    Timer(const Duration(milliseconds: 2200), ()=>Navigator.pushReplacementNamed(context, Routes.homePage),);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlignTransition(
            alignment: _offsetAnimationOne,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_images/cal_logo.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(height: 25),
          ShowUpAnimation(
            animationDuration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            direction: Direction.horizontal,
            offset: -0.5,
            child: GradientText(
              'Best Calculator',
              style: const TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.none
              ),
              gradientType: GradientType.linear,
              radius: 0,
              colors: const[
                Colors.blue,
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.teal,
              ],
            ),
          ),
          const SizedBox(height: 25),
          AlignTransition(
            alignment: _offsetAnimationTwo,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/main_images/mechanism.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
