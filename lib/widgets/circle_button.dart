import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;

  double get _radius => size / 2;

  const CircleButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
    this.size = 44,
  }) : super(key: key);

  factory CircleButton.gradient(
          {Key? key,
          required Widget child,
          required VoidCallback? onPressed,
          double size = 44}) =>
      CircleButton(
        child: child,
        onPressed: onPressed,
        size: size,
        key: key,
        color: null,
      );

//background: linear-gradient(153.43deg, #FFD600 16.01%, #FF9900 90.53%);
//box-shadow: 0px 4px 10px 0px #00000033;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_radius),
      child: InkWell(
        hoverColor: Colors.orange,
        splashColor: Colors.red,
        focusColor: Colors.yellow,
        highlightColor: Colors.purple,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(_radius),
        child: Container(
          height: size,
          width: size,
          decoration: _decoration,
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  BoxDecoration get _decoration => color == null
      ? BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000033).withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
          gradient: LinearGradient(
              transform: GradientRotation(
                math.radians(780),
              ),
              stops: const [
                0.15,
                0.9,
              ],
              colors: const [
                Color(0xFFFFD600),
                Color(0xFFFF9900),
              ]),
          borderRadius: BorderRadius.circular(_radius),
        )
      : BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000033).withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
          color: color,
          borderRadius: BorderRadius.circular(_radius),
        );
}
