import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class RoundedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

//background: linear-gradient(121.95deg, #F99500 4.85%, #FF4B6C 41.01%, #DE22E9 85.01%);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        hoverColor: Colors.orange,
        splashColor: Colors.red,
        focusColor: Colors.yellow,
        highlightColor: Colors.purple,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                transform: GradientRotation(
                  math.radians(780),
                ),
                stops: const [
                  0.05,
                  0.4,
                  0.85,
                ],
                colors: const [
                  Color(0xFFF99500),
                  Color(0xFFFF4B6C),
                  Color(0xFFDE22E9),
                ]),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
